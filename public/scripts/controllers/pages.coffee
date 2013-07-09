polartour.controller "PagesCtrl", ($scope, $location, pages, ptCountriesManager) ->
  part = $location.path().split("/")[1]
  if part and ptCountriesManager.exists part
    $scope.country = ptCountriesManager.getName part

  setCountries = ->
    links = []
    pattern = new RegExp "#{$location.path().replace part, "*"}$"

    for name, page of pages.all()
      if $location.path() != page.href and pattern.test page.href
        links.push
          href: page.href
          code: page.href.split(pattern)[0].replace("/", "").trim()
    $scope.links = links

  if pages.loaded()
    $scope.page = pages.get $location.path()
    setCountries()
  else
    $(pages).on "loaded", ->
      $scope.page = pages.get $location.path()
      setCountries()

  $scope.getGenitive = ptCountriesManager.getGenitive
  $scope.getGenitiveByCode = (code) ->
    ptCountriesManager.getGenitive ptCountriesManager.getName code
