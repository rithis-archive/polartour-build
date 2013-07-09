polartourAdmin.controller "ReportsDetailCtrl", ($scope, $location, $routeParams, Reports) ->
  $scope.report = Reports.get id: $routeParams.id
