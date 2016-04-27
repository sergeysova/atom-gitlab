
Axios = require 'axios'

conf = () =>
  url: atom.config.get('gitlab.serverUrl') + '/api/v3'
  token: atom.config.get('gitlab.privateToken')

axios = (c) =>
  Axios.create
    baseURL: c.url
    headers:
      'PRIVATE-TOKEN': c.token

module.exports =
class GitLab
  inst = null
  projects = []

  constructor: ->
    @inst = axios conf()

  getProjects: ->
    @inst.get '/projects'
      .then (response) => @projects = response.data
