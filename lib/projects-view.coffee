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
    @createContent()

  detach: ->
    @panel.destroy()
    @panel = null

  toggle: ->
    if @isVisible()
      @detach()
    else
      @attach()

  createContent: ->
    msg = document.createElement 'div'
    msg.textContent = 'Hello world!'
    msg.classList.add 'message'
    @panelText.context.appendChild msg

  # Tear down any state and detach
  # destroy: ->
  #   # @root.remove()
  #
  # getElement: ->
  #   @root
