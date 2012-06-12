define ['CodemarksView', 'CodemarkView', '../jquery.masonry', '../jquery.imagesloaded'], (CodemarksView, CodemarkView, Masonry) ->
  CodemrksView = Backbone.View.extend
    className: 'codemarks clearfix'

    render: ->
      @toHTML()

    toHTML: ->
      for codemark in @collection.models
        codemarkView = new CodemarkView
          model: codemark
        codemarkView.render()
        @$el.append(codemarkView.$el)
