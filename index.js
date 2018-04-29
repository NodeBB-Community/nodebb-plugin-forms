// nodebb-plugin-forms

const forms = require('forms')

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

    next(null, JSON.stringify(formData))
    //next(null, forms.create(formData).toHTML())
  })
}

function renderPost (content, next) {
  let matches, formID, renderedForm
  let pattern = /\(form:(.+)\)/

  matches = content.match(pattern)

  if (!matches || !matches[1]) return next(null, content)

  formID = matches[1]

  getFormHTML(formID, (err, formHTML) => {
    if (err || !formHTML) return next(null, content)

    content = content.replace(pattern, formHTML)

    next(null, content)
  })
}

function renderFormPage (req, res, next) {
  const formID = req.params.formID

  getFormHTML(formID, (err, formHTML) => {
    res.render('views/form', {formHTML})
  })
}

PluginForms.init = (params, next) => {
  const {app, router, middleware} = params

  function renderAdminPage (req, res, next) {
    res.render(req.path.slice(1).replace('api/',''), {})
  }

  function addAdminPage(page) {
    router.get('/admin/plugins/plugin-forms' + (page ? '/' + page : ''), middleware.admin.buildHeader, renderAdminPage)
    router.get('/api/admin/plugins/plugin-forms' + (page ? '/' + page : ''), renderAdminPage)
  }

  addAdminPage()
  addAdminPage('form-builder')
  addAdminPage('input-builder')

  router.get('/plugin-forms/config', (req, res) => res.status(200))

  router.get('/forms/:formID', middleware.buildHeader, renderFormPage)

  let defaultSettings = {}

  PluginForms.settings = new Settings('plugin-forms', '0.0.1', defaultSettings)

  SocketAdmin.settings.syncPluginForms = () => PluginForms.settings.sync()

  SocketAdmin.forms = {}

  SocketAdmin.forms.save = (socket, data, next) => {
    let {formsData} = data

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
    })
  }

  SocketAdmin.forms.load = (socket, data, next) => {
    async.waterfall([
      async.apply(db.getObject, 'plugin-forms:formdata'),
    ], (err, formsData) => {
      if (err) return console.log(err)

      formsData = formsData || {}

      try {
        console.log('Loaded plugin-forms:formdata:')
        console.log(JSON.stringify(formsData, null, 4))

        Object.keys(formsData).forEach(formid => {
          formsData[formid] = JSON.parse(formsData[formid])
        })
      } catch (err) {
        return console.log(err)
      }

      next(null, formsData)
    })
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
    "route": '/plugins/plugin-forms/form-builder',
    "icon": 'fa-edit',
    "name": 'Forms',
  })

  next(null, custom_header)
}


PluginForms.parseRaw = (content, next) => {
  let pattern = /\(form:(.+)\)/g

  content = content.replace(pattern, '')

  next(null, content)
}

PluginForms.parsePost = (data, next) => {
  let pattern = /\(form:(.+)\)/g

  function fail () {
    data.postData.content = data.postData.content.replace(pattern, '')
    next(null, data)
  }

  if (!(data && data.postData && data.postData.content)) return fail()

  db.getObjectField('topic:' + data.postData.tid, 'mainPid', (err, pid) => {
    if (err || data.postData.pid !== parseInt(pid, 10)) return fail()

    User.isAdministrator(data.postData.uid, (err, isAdmin) => {
      if (err || !isAdmin) return fail()

      renderPost(data.postData.content, (err, content) => {
        data.postData.content = content.replace(pattern, '')

        next(null, data)
      })
    })
  })
}

module.exports = PluginForms
