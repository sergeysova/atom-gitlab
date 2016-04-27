{ CompositeDisposable } = require 'atom'
Config = require '../config/settings'
ProjectsView = require './projects-view'

module.exports = GitLab =
  projectsView: null
  config: Config

  activate: (@state) ->
    @disposables = new CompositeDisposable
    @state.attached ?= true if @shouldAttach()

    @createViews() if @state.attached

    @disposables.add atom.commands.add 'atom-workspace', 'gitlab:toggle-projects': => @toggle()

  deactivate: ->
    @disposables.dispose()
    @projectsView?.deactivate()
    @projectsView = null

  serialize: ->
    projectsViewState: @projectsView?.serialize()

  createViews: ->
    unless @projectsView?
      @projectsView = new ProjectsView @state.projectsViewState

    @projectsView

  shouldAttach: ->
    true

  toggle: ->
    if @projectsView?.isVisible()
      @projectsView.toggle()
    else
      @createViews()
      @projectsView.attach()
