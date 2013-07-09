polartourAdmin.controller "PagesDetailCtrl", ($scope, $location, $routeParams, Pages) ->
  $scope.page = if $routeParams.id is "new" then new Pages \
    else Pages.get id: $routeParams.id

  
  $scope.save = ->
    return unless $scope.pageForm.$valid
    callback = ->
      $location.url "pages"
    if $routeParams.id == "new"
      $scope.page.$save callback
    else
      $scope.page.$update id: $routeParams.id, callback

  $scope.remove = ->
    if $routeParams.id == "new"
      $location.url "/pages"
    else if confirm("""Вы точно хотите удалить "#{$scope.page.name}"?""")
      $scope.page.$remove id: $routeParams.id, ->
        $location.url "/pages"
