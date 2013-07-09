ptNews = angular.module "ptNews", ["ngResource"]


ptNews.filter "newsLength", ($filter) ->
  (news) ->
    important = []
    angular.forEach news, (item) ->
      important.push item if item.important
    important.slice 0, 3


ptNews.factory "News", ($resource) ->
  $resource "/news/:id", {}, update: method:'PUT'
