ptPages = angular.module "ptPages", [
  "ngResource"
]

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

ptPages.factory "ptPages", ($resource) ->
  $resource "/pages/:_id"
  
ptPages.factory "ptPagesManager", (ptPages) ->
  new PagesManager ptPages

ptPages.controller "PtPagesCtrl", ($scope, $location, ptPagesManager, ptCountriesManager) ->
  part = $location.path().split("/")[1]
  if part and ptCountriesManager.exists part
    $scope.country = ptCountriesManager.getName part

  setCountries = ->
    links = []
    pattern = new RegExp "#{$location.path().replace part, "*"}$"

    for name, page of ptPagesManager.all()
      if $location.path() != page.href and pattern.test page.href
        links.push
          href: page.href
          code: page.href.split(pattern)[0].replace("/", "").trim()
    $scope.links = links

  if ptPagesManager.loaded()
    $scope.page = ptPagesManager.get $location.path()
    setCountries()
  else
    $(ptPagesManager).on "loaded", ->
      $scope.page = ptPagesManager.get $location.path()
      setCountries()

  $scope.getGenitive = ptCountriesManager.getGenitive
  $scope.getGenitiveByCode = (code) ->
    ptCountriesManager.getGenitive ptCountriesManager.getName code
