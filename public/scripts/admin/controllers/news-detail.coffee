polartourAdmin.controller "NewsDetailCtrl", ($scope, $location, $routeParams, News) ->
  $scope.news = if $routeParams.id is "new" then new News \
    else News.get id: $routeParams.id

  $scope.save = ->
    return unless $scope.newsForm.$valid
    callback = ->
      $location.url "news"
    if $routeParams.clone
      cloneData = {}
      for name, value of $scope.news
        unless name[0] is "_" or typeof value is "function"
          cloneData[name] = value
      (new News cloneData).$save callback
    else if $routeParams.id == "new"
      $scope.news.$save callback
    else
      $scope.news.$update id: $routeParams.id, callback

  $scope.remove = ->
    if $routeParams.id == "new"
      $location.url "/news"
    else if confirm("""Вы точно хотите удалить "#{$scope.news.title}"?""")
      $scope.news.$remove id: $routeParams.id, ->
        $location.url "/news"

  $scope.cloneNews = ->
    $location.url "/news/#{$routeParams.id}/clone"
