{$, $$, ScrollView, SelectListView} = require 'atom-space-pen-views'
{CompositeDisposable} = require 'atom'

module.exports =
class ProjectsView extends ScrollView
  panel: null

  @content: ->
    @div class: 'gitlab-projects', =>
      @div class: 'panel', =>
        @div outlet: 'panelText', class: 'padded', =>
          @h4 'GitLab'
          @p 'Hello world'

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

  attach: ->
    @panel ?= atom.workspace.addRightPanel item: this

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
