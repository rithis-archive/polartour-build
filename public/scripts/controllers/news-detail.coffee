polartour.controller "NewsDetailCtrl", ($scope, $routeParams, News) ->
  $scope.news = News.get id: $routeParams.id
