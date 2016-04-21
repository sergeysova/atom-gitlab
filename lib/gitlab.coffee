ProjectsView = require './projects-view'
{ CompositeDisposable } = require 'atom'
Config = require '../config/settings'

populateConfigs = (conf) ->
  for id in [1..5]
    conf["server_"+id] =
      type: 'object'
      properties:
        'throw ssh':
          type: 'boolean'
          default: false
        token:
          type: 'string'
          default: ''
        url:
          type: 'string'
          default: 'https://gitlab.com'
  conf

module.exports = Gitlab =
  projectsView: null
  projectsPanel: null
  modalPanel: null
  subscriptions: null
  config: populateConfigs Config

  activate: (state) ->
    @projectsView = new ProjectsView(@state)
    # @modalPanel = atom.workspace.addModalPanel(item: @projectsView.getElement(), visible: false)
    @projectsPanel = (item: @projectsView.getElement())

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'gitlab:toggle-projects': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @projectsView.destroy()

  serialize: ->
    projectsViewState: @projectsView.serialize()

  toggle: ->
    console.log 'Gitlab was toggled!'

    if @projectsPanel.isVisible()
      @projectsPanel.hide()
    else
      @projectsPanel.show()
