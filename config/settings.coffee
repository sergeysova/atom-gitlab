module.exports =
  privateToken:
    type: 'string'
    description: 'Private token from Profile Settings -> Account'
    default: ''
  serverUrl:
    type: 'string'
    description: 'Enter the specified gitlab server address or leave blank to use default'
    default: 'https://gitlab.com'
  position:
    type: 'string'
    default: 'right'
    description: 'Select side of the GitLab projects list'
    enum: ['left', 'right']
