ptPagination = angular.module "ptPagination", []

ptPagination.directive "ptPaginationControls", ->
  templateUrl: "scripts/modules/pt-pagination/pt-pagination.html"
  replace: true
  restrict: "E"

ptPagination.directive "ptPagination", ->
  cache = {}
  link: (scope, element, attributes) ->
   scope.$watch attributes.ptPagination, (values) ->
     return unless values
     scope.pagination =
       values: []
       pages: []
       cacheId: attributes.ptPaginationId or null
       activePage: null
       limit: attributes.ptPaginationLimit or 5
       isActive: (page) ->
         @activePage is page
       setPage: (page) ->
         @activePage = page
         if @cacheId
           cache[@cacheId] = page
         start = (@activePage - 1) * @limit
         end = start + @limit
         @values = values.slice start, end

     scope.pagination.setPage cache[scope.pagination.cacheId] or 1
     scope.pagination.pages = (i for i in [1...values.length/scope.pagination.limit+1])
   , true

