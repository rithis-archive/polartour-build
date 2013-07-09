polartourAdmin.controller "NewsCtrl", ($scope, $location, News) ->
  $scope.data = News.query()

  $scope.new = ->
    $location.url "/news/new"
