env = require 'node-env-file'
fs = require 'fs-plus'

module.exports =
  config:
    envFile:
      type: 'string'
      default: '.env'
      description: 'File name for environments'
    showNotificationOnSuccess:
      type: 'boolean'
      default: true
    showNotificationOnError:
      type: 'boolean'
      default: false

  activate: ->
    project = atom.project.rootDirectories[0]
    fileName = atom.config.get('atom-env-for-project.envFile')
    filePath = project?.path + "/" + fileName

    if fs.isFileSync(filePath)
      env filePath
      if atom.config.get('atom-env-for-project.showNotificationOnSuccess')
        atom.notifications.addSuccess(
          "Loaded file with environment variables",
          { detail: filePath }
        )
    else
      if atom.config.get('atom-env-for-project.showNotificationOnError')
        atom.notifications.addError(
          "Not found" ,
          { detail: filePath }
        )
