polartourAdmin.controller "ExcursionsDetailCtrl", ($scope, $location, $routeParams, $parse, Excursions) ->
  if $routeParams.id is "new"
    $scope.excursion = new Excursions
  else
    $scope.excursion = Excursions.get id: $routeParams.id

  $scope.addImage = ->
    $scope.excursion.images ?= []
    $scope.excursion.images.push ""

  $scope.isSelectedTag = (name) ->
    $scope.selectedTags and $scope.selectedTags.indexOf(name) != -1

  $scope.save = ->
    return unless $scope.excursionForm.$valid
    callback = ->
      $location.url "excursions"
    if $routeParams.id == "new"
      $scope.excursion.$save callback
    else
      $scope.excursion.$update id: $routeParams.id, callback

  $scope.addImage = ->
    $scope.excursion.images ?= []
    $scope.excursion.images.push ""

  $scope.remove = ->
    if $routeParams.id == "new"
      $location.url "/excursions"
    else if confirm("""Вы точно хотите удалить "#{$scope.excursion.name}"?""")
      $scope.excursions.$remove id: $routeParams.id, ->
        $location.url "/excursions"
