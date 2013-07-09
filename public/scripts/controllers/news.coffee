polartour.controller "NewsCtrl", ($scope, News) ->
  $scope.important = false
  News.query (data) ->
    news = []
    now = new Date()
    data.forEach (item) ->
      console.log new Date(item.startAt)
      console.log now
      console.log new Date(item.startAt) < now
      news.push item if new Date(item.startAt) < now
      $scope.important = true if item.important
    console.log news
    $scope.data = news
