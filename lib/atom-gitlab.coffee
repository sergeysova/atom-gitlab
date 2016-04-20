AtomGitlabView = require './atom-gitlab-view'
{ CompositeDisposable } = require 'atom'
Config = require 'config'

module.exports = AtomGitlab =
  atomGitlabView: null
  modalPanel: null
  subscriptions: null
  config: Config

  activate: (state) ->
    @atomGitlabView = new AtomGitlabView(state.atomGitlabViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atomGitlabView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-gitlab:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomGitlabView.destroy()

  serialize: ->
    atomGitlabViewState: @atomGitlabView.serialize()

  toggle: ->
    console.log 'AtomGitlab was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
