React = require 'react'
Reflux = require 'reflux'

ProjectStore = require '../stores/project-store'

fbConfig =
  'wildcamg-local':
    appId: '541886729316558'
    url: 'https://apps.facebook.com/wildcamg-local/'
  'wildcamg-heroku':
    appId: '537314539773777'
    url: 'https://apps.facebook.com/wildcamg-heroku/'

isVowel = letter ->
  ['a', 'e', 'i', 'o', 'u'].indexOf(letter.toLowerCase()) !== -1


module.exports = React.createClass
  displayName: 'Summary'
  mixins: [Reflux.connect(ProjectStore, 'projectData')]

  onClickShare: ->
    task = @props.workflow.tasks[@props.workflow.first_task]
    annotation = @props.annotations[0]

    message = 'I found '
    if annotation and annotation.choice isnt 'NTHNGHR'
      plural = annotation.answers["HWMN"] > 1
      species = task.choices[annotation.choice].label
      message += if plural then 'some ' 
        else if isVowel species.charAt 0
          'an '
        else 'a'
      message += 
        if plural
          switch species
            when "Buffalo" then "#{species}"
            when "Hippopotamus" then "#{species}es"
            when "Lion (male)", "Lion (female)", "Lion (cub)" then "Lions"
            else 
              "#{species}s"
        else
          species
      message += ' on Wildcam Gorongosa!'
    else
      message += 'something interesting on Wildcam Gorongosa!'

    console.log message

    FB.ui
      method: 'share_open_graph'
      action_type: 'og.shares'
      action_properties: JSON.stringify
        object:
          'og:image': @props.subject.locations[0]['image/jpeg']
          'og:title': 'I found this on Wildcam Gorongosa'
          'og:description': message
          'og:site_name': 'Wildcam Gorongosa'
          'og:url': fbConfig['wildcamg-heroku'].url
          'fb:app_id': fbConfig['wildcamg-heroku'].appId

  render: ->
    task = @props.workflow.tasks[@props.workflow.first_task]
    <div className="task-summary">
      <div className="task-summary-annotations">
        <h3 className="task-summary-header">Your Classification Summary</h3>
        <ul className="task-summary-annotations-list">
          {for annotation, i in @props.annotations
            species = task.choices[annotation.choice].label
            plural = 
              if annotation.answers["HWMN"] > 1
                switch species
                  when "Buffalo" then "#{species}"
                  when "Hippopotamus" then "#{species}es"
                  when "Lion (male)"
                    "Lions (male)"
                  when "Lion (female)"
                    "Lions (female)"
                  when "Lion (cub)" then "Lions (cub)"
                  else 
                    "#{species}s"
              else
                species
            <li key={i} className="task-summary-annotations-list-item">
              <span className="item-species">{plural}</span><span className="item-number">{annotation.answers["HWMN"]}</span>
            </li>
        }</ul>
      </div>
      <div className="task-summary-call-to-action">
        <p className="call-to-action">
          Want to share this image on your News Feed?
        </p>
        <button className="discuss-link" onClick={@onClickShare}>
          Share this image
        </button>
        <p className="call-to-action">
          Want to discuss this with other volunteers?
        </p>
        <a href="https://www.zooniverse.org/projects/#{@state.projectData.slug}/talk/subjects/#{@props.subject.id}" className="discuss-link" target="_blank">
          Discuss on Talk
        </a>
      </div>
      <div className="task-summary-tip">
        <p>Ready to move on?</p>
      </div>
    </div>
