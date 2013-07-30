ptNews = angular.module "ptNews", [
  "ngResource"
]

ptNews.factory "ptNews", ($resource) ->
  $resource "/news/:_id"

ptNews.controller "PtNewsCtrl", ($scope, $routeParams, ptNews) ->
  $scope.news = ptNews.get _id: $routeParams.newsId

ptNews.controller "PtAllNewsCtrl", ($scope, ptNews) ->
  $scope.allNews = ptNews.query()

ptNews.controller "PtImportantNewsCtrl", ($scope, ptNews) ->
  ptNews.query (news) ->
    $scope.importantNews = news.filter (news) ->
      news.important
