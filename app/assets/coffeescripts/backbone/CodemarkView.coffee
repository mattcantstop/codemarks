define ['text!../../templates/codemark.html'], (template) ->
  CodemarkView = Backbone.View.extend
    className: 'codemark'

    initialize: ->
      #console.log template

    render: ->
      @$el.append(@toHTML())
      randomnumber = Math.floor(Math.random()*11) * 10
      @$el.width(randomnumber)

    toHTML: ->
      # TODO: Ideally, this would always just return a string and render would append it to the
      # DOM
      template
