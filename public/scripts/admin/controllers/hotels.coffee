polartourAdmin.controller "HotelsCtrl", ($scope, $filter, $location, $routeParams, Hotels) ->
  $scope.remoteFilters = {}
  $scope.remoteFilters.country = $routeParams.country if $routeParams.country

  $scope.$watch "remoteFilters", ->
    return unless $scope.remoteFilters
    Hotels.query $scope.remoteFilters, (data) ->
      $scope.data = data
  , true

  $scope.new = ->
    $location.url "/hotels/new?country=#{$scope.remoteFilters.country}"
