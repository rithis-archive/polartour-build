ptNumber = angular.module "ptNumber", []

ptNumber.directive "ptNumber", ->
  restrict: "E"
  templateUrl: "scripts/modules/pt-number/pt-number.html"
  replace: true
  scope: ptNumberMin: "@", ptNumberMax: "@"
  require: "ngModel"
  link: (scope, element, attributes, ngModel) ->
    scope.sub = ->
      if scope.value
        scope.value = String(Number(scope.value) - 1)
      else
        scope.value = String min

    scope.add = ->
      if scope.value
        scope.value = String(Number(scope.value) + 1)
      else
        scope.value = String min + 1

    scope.$watch "value", (value) ->
      ngModel.$setViewValue value

    ngModel.$formatters.unshift (modelValue) ->
      if typeof modelValue is "number"
        scope.value = String modelValue

    min = 0
    max = 99
    scope.$watch "ptNumberMin", (ptNumberMin) ->
      min = Number ptNumberMin
    scope.$watch "ptNumberMax", (ptNumberMax) ->
      max = Number ptNumberMax

    ngModel.$parsers.unshift (viewValue) ->
      ngModel.$setValidity "number", true
      if viewValue is undefined or viewValue is null or viewValue is ""
        return undefined
      if viewValue.match /^-?\d+$/
        viewValue = Number viewValue
        if viewValue <= min
          scope.value = String min
          viewValue = min
        if viewValue >= max
          scope.value = String max
          viewValue = max
        return viewValue
      ngModel.$setValidity "number", false
      return undefined
