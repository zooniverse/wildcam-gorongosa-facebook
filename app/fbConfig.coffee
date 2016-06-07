fbConfig =
  'local':
    appId: '541886729316558'
    url: 'https://apps.facebook.com/wildcamg-local/'
  'heroku':
    appId: '537314539773777'
    url: 'https://apps.facebook.com/wildcamg-heroku/'
  'production':
    appId: '537314453107119'
    url: 'https://apps.facebook.com/wildcam-gorongosa/'

ENV = process.env.FB_ENV || 'production'

console.log 'process', process.env.FB_ENV

console.log 'Environment set to ', ENV, fbConfig[ENV]

module.exports = fbConfig[ENV]
