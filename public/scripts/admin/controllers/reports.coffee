polartourAdmin.controller "ReportsCtrl", ($scope, Reports) ->
  $scope.data = Reports.query()
