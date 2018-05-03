// nodebb-plugin-forms

const forms = require('forms')
const fields = forms.fields
const validators = forms.validators
const widgets = forms.widgets

const fs = require('fs')
const path = require('path')
const util = require('util')

const async = require.main.require('async')

const meta = require.main.require('./src/meta')
const Settings = require.main.require('./src/settings')
const db = require.main.require('./src/database')
const User = require.main.require('./src/user')
const Topics = require.main.require('./src/topics')
const plugins = require.main.require('./src/plugins')
const cache = require.main.require('./src/posts/cache')
const SocketAdmin = require.main.require('./src/socket.io/admin')
const SocketPlugins = require.main.require('./src/socket.io/modules')

const translator = require.main.require('./public/src/modules/translator')

let app, router, middleware
let PluginForms = {}

function getFormObject (formID, next) {
  db.getObject(`plugin-forms:formid:${formID}`, (err, form) => {
    if (err) return next(err)

    next(null, form)
  })
}

function getFormData (formID, next) {
  db.getObjectField('plugin-forms:formdata', formID, (err, formData) => {
    if (err) return next(err)
    if (!formData) return next(new Error(`formID ${formID} doesn't exist.`))

    try {
      formData = JSON.parse(formData)
    } catch (err) {
      return next(err)
    }

    next(null, formData)
  })
}

function getFormHTML (formID, next) {
  getFormData(formID, (err, formData) => {
    if (err) return next(err)

    // Transform data.
    let transformedData = {}
    formData.elements.forEach(elementObj => {
      const {field, widget} = elementObj

      // TODO: Configurable settings for widget.
      elementObj.widget = widgets[widget]({})

      transformedData[elementObj.name] = fields[field](elementObj)
    })

    console.dir(transformedData)

    next(null, forms.create(transformedData).toHTML())
  })
}

function renderFormPage (req, res, next) {
  const formID = req.params.formID

  getFormHTML(formID, (err, formHTML) => {
    if (err) return res.redirect('/')

    res.render('views/form', {formHTML})
  })
}

function deleteForm (formid, next) {
  async.waterfall([
    async.apply(db.sortedSetRemove, 'plugin-forms:formids', formid),
    async.apply(db.deleteObjectField , 'plugin-forms:formdata', `${formid}`),
    async.apply(db.delete, `plugin-forms:formid:${formid}`),
  ], next)
}

PluginForms.init = (params, next) => {
  const {app, router, middleware} = params

  function renderAdminPage (req, res, next) {
    const formElementsStandard = {
      'text': 'Text',
      'textarea': 'Text Area',
      'number': 'Number',
      'radiogroup': 'Multiple Choice',
      'checkboxes': 'Check Group',
      'select': 'Dropdown',
      'selectmultiple': 'List Box',
      'hidden': 'Hidden',
      'buttons': 'Buttons',
    }

    const formElementsAdvanced = {
      'url': 'Link',
      'email': 'E-Mail',
      'price': 'Price',
      'address': 'Address',
      'date': 'Date',
      'time': 'Time',
      'select2': 'Select2',
    }

    const formElementsDecor = {
      'info': 'Text Info',
      'divider': 'Divider',
    }

    const formElementsPhase = {
      'sendusers': 'Send to Users',
      'validate': 'Validate Form',
    }

    res.render('admin/plugins/plugin-forms-builder', {formElementsStandard, formElementsAdvanced, formElementsDecor, formElementsPhase})
  }

  router.get('/admin/plugins/plugin-forms-builder', middleware.admin.buildHeader, renderAdminPage)
  router.get('/api/admin/plugins/plugin-forms-builder', renderAdminPage)

  router.get('/plugin-forms/config', (req, res) => res.status(200))

  router.get('/forms/:formID', middleware.buildHeader, renderFormPage)

  let defaultSettings = {}

  PluginForms.settings = new Settings('plugin-forms', '0.0.1', defaultSettings)

  SocketAdmin.settings.syncPluginForms = () => PluginForms.settings.sync()

  SocketAdmin.forms = {}

  SocketAdmin.forms.save = (socket, data, next) => {
    let {formsData} = data

    async.each(formsData, (formData, next) => {
      if (!formData.formid || !formData.formidOld) return next(new Error('Bad data sent to SocketAdmin.forms.save'))

      const {formid, formidOld} = formData

      if (String(formid) !== String(formidOld)) {
        async.waterfall([
          async.apply(db.rename, `plugin-forms:formid:${formidOld}`, `plugin-forms:formid:${formid}`),
          async.apply(deleteForm, formidOld),
        ], next)
      } else {
        next()
      }
    }, () => {
      formsData.forEach(formData => {
        let {formid} = formData

        try {
          console.log('Saving formid:' + formid)
          console.log(JSON.stringify(formData, null, 4))
          formData = JSON.stringify(formData)
        } catch (e) {
          return console.log(e)
        }

        async.waterfall([
          async.apply(db.sortedSetAdd, 'plugin-forms:formids', 0, formid),
          async.apply(db.setObjectField, 'plugin-forms:formdata', `${formid}`, formData),
          async.apply(db.setObject, `plugin-forms:formid:${formid}`, {lastModifiedByUid: socket.uid}),
          (next) => {
            db.getObjectField('plugin-forms:formdata', `${formid}`, (err, formData) => {
              console.log('get plugin-forms:formdata')
              console.log(formData)
            })
          }
        ])

        // Re-render all cached posts.
        db.getSetMembers(`plugin-forms:formid:${formid}:cached`, (err, pids = []) => {
          pids.forEach(pid => cache.del(String(pid)))
          db.delete(`plugin-forms:formid:${formid}:cached`)
        })
      })
    })
  }

  SocketAdmin.forms.load = (socket, data, next) => {
    let forms = []

    async.waterfall([
      async.apply(db.getObject, 'plugin-forms:formdata'),
    ], (err, formsData) => {
      if (err) return console.log(err)

      formsData = formsData || {}

      try {
        console.log('Loaded plugin-forms:formdata:')
        console.log(JSON.stringify(formsData, null, 4))

        Object.keys(formsData).forEach(formid => forms.push(JSON.parse(formsData[formid])))
      } catch (err) {
        return console.log(err)
      }

      next(null, forms)
    })
  }

  SocketAdmin.forms.delete = (socket, data, next) => {
    if (!data || !data.formid) return next(new Error('No formid given to SocketAdmin.forms.delete'))

    deleteForm(data.formid, next)
  }

  SocketPlugins.PluginForms = {}

  SocketPlugins.PluginForms.getRecords = (socket, data, next) => {
    let uid = socket.uid
    let ip = socket.ip
  }

  next()
}

PluginForms.adminHeaderBuild = (custom_header, next) => {
  custom_header.plugins.push({
    "route": '/plugins/plugin-forms-builder',
    "icon": 'fa-edit',
    "name": 'Forms',
  })

  next(null, custom_header)
}


PluginForms.parseRaw = (content, next) => {
  next(null, content)
}

PluginForms.parsePost = (data, next) => {
  let pattern = /\(form:(.+)\)/g
  let pid = parseInt(data.postData.pid, 10)

  function fail () {
    data.postData.content = data.postData.content.replace(pattern, '')
    next(null, data)
  }

  function renderPost (content, next) {
    let matches, formID, renderedForm
    let pattern = /\(form:(.+)\)/

    matches = content.match(pattern)

    if (!matches || !matches[1]) return next(new Error('No matched formID'))

    formID = matches[1]

    getFormHTML(formID, (err, formHTML) => {
      if (err || !formHTML) return next(null, content)

      // Store cached post.
      db.setAdd(`plugin-forms:formid:${formID}:cached`, pid)

      content = content.replace(pattern, formHTML)

      next(null, content)
    })
  }

  if (!(data && data.postData && data.postData.content)) return fail()

  db.getObjectField('topic:' + data.postData.tid, 'mainPid', (err, mainPid) => {
    if (err || pid !== parseInt(mainPid, 10)) return fail()

    User.isAdministrator(data.postData.uid, (err, isAdmin) => {
      if (err || !isAdmin) return fail()

      renderPost(data.postData.content, (err, content) => {
        if (err || !content) return next(null, data)

        data.postData.content = content.replace(pattern, '')

        next(null, data)
      })
    })
  })
}

module.exports = PluginForms
