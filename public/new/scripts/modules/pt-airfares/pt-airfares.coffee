ptAirfares = angular.module "ptAirfares", [
  "ngResource"
]

ptAirfares.factory "ptAirfares", ($resource) ->
  $resource "/certificates/:_id"

ptAirfares.controller "PtAirfaresCtrl", ($scope, $location, ptAirfares, ptFormDescriptions) ->
  $scope.showValidation = false
  $scope.airfares = new ptAirfares tourists: [""]
  $scope.description = ptFormDescriptions.get code: "ticket-price-request"

  $scope.send = ->
    $scope.showValidaiton = true
    if $scope.airfaresForm.$valid
      $scope.airfares.$save ->
        $scope.sent = true

ptAirfares.directive "ptAirfaresTourists", ->
  templateUrl: "scripts/modules/pt-airfares/pt-airfares-tourists.html"
  replace: true
  restrict: "E"
  require: "?ngModel"
  link: (scope, element, attributes, ngModel) ->
    ngModel.$formatters.push (values) ->
      tourists = []
      if values
        values.forEach (value) ->
          tourists.push value: value

      scope.tourists = tourists
      values

    isValid = (values) ->
      valid = true
      values.forEach (value) ->
        if valid
          valid = false if not value?
      valid

    ngModel.$parsers.unshift (viewValue) ->
      ngModel.$setValidity "strongPass", isValid(viewValue)
      viewValue

    ngModel.$formatters.unshift (modelValue) ->
      ngModel.$setValidity "strongPass", isValid(modelValue)
      modelValue

    scope.add = ->
      scope.tourists.push value: ""

    scope.remove = (remove) ->
      scope.tourists.splice remove, 1

    scope.$watch "tourists", ->
      values = []
      scope.tourists.forEach (field) ->
        values.push field.value
      ngModel.$setViewValue values
    , true
