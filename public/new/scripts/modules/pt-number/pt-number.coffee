ptNumber = angular.module "ptNumber", []

ptNumber.directive "ptNumber", ->
  restrict: "E"
  templateUrl: "scripts/modules/pt-number/pt-number.html"
  replace: true
  scope: ptNumberMin: "@", ptNumberMax: "@"
  require: "?ngModel"
  link: (scope, element, attributes, ngModel) ->
    scope.debug = attributes.hasOwnProperty "ptDebug"


    debug = ->
      if scope.debug
        console.log.apply console, arguments

    scope.sub = ->
      debug "scope.sub()"
      if scope.value
        if scope.value > min
          scope.value = String(Number(scope.value) - 1)
      else
        scope.value = String min

    scope.add = ->
      debug "scope.add()"
      if scope.value
        if scope.value < max
          scope.value = String(Number(scope.value) + 1)
      else
        scope.value = String min + 1

    min = 0
    max = 99
    scope.$watch "ptNumberMin", (ptNumberMin) ->
      debug "scope.$watch('ptNumberMin')", ptNumberMin
      min = Number ptNumberMin
    scope.$watch "ptNumberMax", (ptNumberMax) ->
      debug "scope.$watch('ptNumberMax')", ptNumberMax
      max = Number ptNumberMax

    if ngModel
      scope.$watch "value", (value) ->
        debug "scope.$watch('value')", value
        ngModel.$setViewValue value

      ngModel.$formatters.unshift (modelValue) ->
        debug "ngModel.$formatters", modelValue
        if typeof modelValue is "number"
          scope.value = String modelValue

      ngModel.$parsers.unshift (viewValue) ->
        debug "ngModel.$parsers", viewValue
        ngModel.$setValidity "number", true
        if viewValue is undefined or viewValue is null or viewValue is ""
          return undefined
        if viewValue.match /^-?\d+$/
          viewValue = Number viewValue
          if min <= viewValue <= max
            return viewValue
        ngModel.$setValidity "number", false
        return undefined
