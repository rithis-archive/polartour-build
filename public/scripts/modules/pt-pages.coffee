ptPages = angular.module "ptPages", ["ngResource"]


class PagesManager
  constructor: (Pages) ->
    @pages = {}
    Pages.query (pages) =>
      pages.forEach (page) =>
        @pages[page.href] = page
      @pagesLoaded = true
      $(@).trigger "loaded"

  all: =>
    @pages

  get: (page) =>
    @pages[page]

  loaded: =>
    @pagesLoaded?


ptPages.factory "Pages", ($resource) ->
  $resource "/pages/:id", {}, update: method:'PUT'
  
ptPages.factory "pages", ($resource, Pages) ->
  new PagesManager Pages
