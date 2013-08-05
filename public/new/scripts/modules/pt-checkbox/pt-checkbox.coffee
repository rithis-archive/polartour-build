ptCheckbox = angular.module "ptCheckbox", []

ptCheckbox.directive "ptCheckbox", ->
  scope: {}
  templateUrl: "scripts/modules/pt-checkbox/pt-checkbox.html"
  replace: true
  restrict: "E"
  require: "?ngModel"
  link: (scope, element, attributes, ngModel) ->
    scope.checked = false

    if ngModel
      ngModel.$formatters.unshift (modelValue) ->
        if typeof modelValue is "boolean"
          scope.checked = modelValue

      scope.$watch "checked", (checked) ->
        ngModel.$setViewValue checked
