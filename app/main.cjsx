React = require 'react'
Reflux = require 'reflux'
{RouteHandler} = require 'react-router'

userStore = require './stores/user-store'

MainHeader = require './partials/main-header'
MainFooter = require './partials/main-footer'

module.exports = React.createClass
  displayName: "Main"
  mixins: [Reflux.connect(userStore, 'userData')]

  getIntitalState:
    project: null

  componentDidMount: ->
    window.fbAsyncInit = ->
      FB.init
        appId: '537314539773777'
        cookie: true
        xfbml: true
        version: 'v2.5'

  render: ->
    user = unless @state.userData is null then @state.userData?.user else null

    <div className="main">
      <MainHeader user={user} />
      <RouteHandler user={user} userPreferences={@state.userData?.projectPreferences} />
      <MainFooter />
    </div>
