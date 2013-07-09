ptList = angular.module "ptList", ["ngResource"]


ptList.factory "ptListPage", ->
  savePage: (id, page) ->
    if id and id isnt "pt-list"
      store.set("ptListPage.#{id}", page)

  loadPage: (id) ->
    store.get("ptListPage.#{id}") or 1

ptList.directive "ptList", ($filter, ptListPage) ->
  restrict: "EACM"
  link: (scope, element, attributes) ->
    scope.pages = {}
    scope.pageSize = 10
    scope.currentPage = ptListPage.loadPage attributes.ptList
    scope.pagination = []

    if attributes.pageSize
      scope.pageSize = Number attributes.pageSize

    scope.filter = (data) ->
      pages = {}
      data = $filter('filter') data, (item) ->
        success = true
        for filter, value of scope.filters
          if value
            if value instanceof Date
              success = moment(value).isSame(moment(item[filter]), "day")
            else if value.match "и менее"
              value = value.replace " и менее", ""
              success = false unless parseInt(item[filter]) <= parseInt(value)
            else
              success = false unless item[filter] == value \
                or item[filter].toLowerCase().match value.toLowerCase()
        return success
      return unless data
      for i in [0..data.length]
        page = Math.floor i / scope.pageSize + 1
        if i % scope.pageSize == 0
          pages[page] = [data[i]] if data[i]
        else
          pages[page].push data[i] if data[i]
      scope.pages = pages
      scope.filteredData = pages[scope.currentPage]
      scope.pagination = Object.keys(scope.pages).sort (first, second) ->
        parseInt(first) - parseInt(second)

    scope.$watch "data", ->
      scope.filter scope.data
    , true
  
    scope.$watch "filters", ->
      scope.filter scope.data
    , true
  
    scope.$watch "currentPage", ->
      scope.filter scope.data
      ptListPage.savePage attributes.ptList, scope.currentPage
    , true
