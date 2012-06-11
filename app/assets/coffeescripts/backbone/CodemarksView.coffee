define ['CodemarksView', 'CodemarkView', '../isotope'], (CodemarksView, CodemarkView, Isotope) ->
  CodemrksView = Backbone.View.extend
    className: 'codemarks'

    render: ->
      @toHTML()
      @$el.isotope
        itemSelector : '.iso',
        layoutMode : 'fitRows'

    toHTML: ->
      for codemark in @collection.models
        codemarkView = new CodemarkView
          model: codemark
        codemarkView.render()
        @$el.append(codemarkView.$el)
