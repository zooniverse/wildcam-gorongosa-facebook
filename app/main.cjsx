React = require 'react'
Reflux = require 'reflux'
{RouteHandler} = require 'react-router'

userStore = require './stores/user-store'

MainHeader = require './partials/main-header'
MainFooter = require './partials/main-footer'

fbConfig = require './fbConfig'

module.exports = React.createClass
  displayName: "Main"
  mixins: [Reflux.connect(userStore, 'userData')]

  getIntitalState:
    project: null

  componentDidMount: ->
    window.fbAsyncInit = ->
      FB.init
        appId: fbConfig.appId
        cookie: true
        xfbml: true
        version: 'v2.5'

      FB.AppEvents.logEvent('VISITED_APP')

  render: ->
    user = unless @state.userData is null then @state.userData?.user else null

    <div className="main">
      <MainHeader user={user} />
      <RouteHandler user={user} userPreferences={@state.userData?.projectPreferences} />
      <MainFooter />
    </div>
