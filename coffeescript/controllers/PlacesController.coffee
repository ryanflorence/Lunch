define [
  'controllers/Controller'
  'collections/PlacesCollection'
  'views/PlaceItemView'
], (Controller, PlacesCollection, PlaceItemView) ->

  class PlaceItemController extends Controller

    className: 'place'

    tagName: 'li'

    events:
      'click .vote' : 'vote'

    initialize: ->
      @model.on 'change:'+@model.votesKey, @render, this

    render: () ->
      @html PlaceItemView @model.toJSON()
      this

    vote: ->
      @model.vote()

  class PlacesController extends Controller

    className: 'places list'

    tagName: 'ul'

    initialize: () ->
      @collection = new PlacesCollection
      @collection.on 'reset', @render, this
      @collection.fetch()

    render: () ->
      @append '<h2>What are my options?</h2>'
      @collection.each (place) ->
        @append new PlaceItemController(
          model: place
        ).render()
      , this
      this

    findLocation: () ->
      throw "No collection!" if ! @collection

      @collection.select()
