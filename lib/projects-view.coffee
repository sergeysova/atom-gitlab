{$, $$, ScrollView, SelectListView} = require 'atom-space-pen-views'
{CompositeDisposable} = require 'atom'

Requester = require('./requester')

gitlab = new Requester

module.exports =
class ProjectsView extends ScrollView
  panel: null

  @content: ->
    @div class: 'gitlab', =>
      @div class: 'panel', =>
        @div outlet: 'panelText', class: 'padded', =>
          @div class: 'block gitlab-title', =>
            @h4 class: 'inline-block', 'GitLab'
            @span class: 'badge badge-large icon icon-repo gitlab-projects-count', outlet: 'repoCount', 0
          @div class: 'btn-toolbar', =>
            @div class: 'block btn-group', =>
              @button class: 'btn icon icon-repo-clone', outlet: 'btnClone', 'Clone'
              @button class: 'btn icon icon-repo-create', outlet: 'btnCreate', 'Create'
              @button class: 'btn icon icon-repo-sync', outlet: 'btnSync', 'Sync'

  initialize: (state) ->
    @disposables = new CompositeDisposable
    @attach() if state?.attached

  serialize: ->
    attached: @panel?

  deactivate: ->
    @disposables.dispose()
    @detach() if @panel?

  getTitle: ->
    "GitLab"

  updateProjectsCount: ->
    gitlab.getProjects()
      .then (projects) =>
        @repoCount.context.style.display = undefined;
        @repoCount.context.innerHTML = projects.length
      .catch (error) =>
        console.error error
        @repoCount.context.style.display = 'none';

  attach: ->
    @updateProjectsCount()
    if atom.config.get('gitlab.position') == 'right'
      @panel ?= atom.workspace.addRightPanel item: this
    else
      @panel ?= atom.workspace.addLeftPanel item: this

  detach: ->
    @panel.destroy()
    @panel = null

  toggle: ->
    if @isVisible()
      @detach()
    else
      @attach()

  # Tear down any state and detach
  # destroy: ->
  #   # @root.remove()
  #
  # getElement: ->
  #   @root
