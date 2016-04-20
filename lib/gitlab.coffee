GitlabView = require './gitlab-view'
{ CompositeDisposable } = require 'atom'
Config = require 'config'

module.exports = AtomGitlab =
  gitlabView: null
  modalPanel: null
  subscriptions: null
  config: Config

  activate: (state) ->
    @gitlabView = new GitlabView(state.gitlabViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @gitlabView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'gitlab:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @gitlabView.destroy()

  serialize: ->
    gitlabViewState: @gitlabView.serialize()

  toggle: ->
    console.log 'Gitlab was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
