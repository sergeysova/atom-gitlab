ProjectsView = require './projects-view'
{ CompositeDisposable } = require 'atom'
Config = require '../config/settings'

populateConfigs = (conf) ->
  for id in [1..5]
    conf["server_"+id] =
      type: 'object'
      properties:
        'use ssh':
          type: 'boolean'
          default: false
        token:
          type: 'string'
          default: ''
        url:
          type: 'string'
          default:
            if id == 1
              'https://gitlab.com'
            else
              ''
  conf

module.exports = GitLab =
  projectsView: null
  config: populateConfigs Config

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
