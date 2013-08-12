ptRadio = angular.module "ptRadio", []


ptRadio.directive "ptRadioGroup", ($timeout) ->
  scope: ptRadioGroupValues: "="
  templateUrl: "scripts/modules/pt-radio/pt-radio.html"
  restrict: "EACM"
  require: "?ngModel"
  link: (scope, element, attributes, ngModel) ->
    scope.values = []
    scope.selected = null

    scope.$watch "ptRadioGroupValues", (values) ->
      scope.values = []
      if Array.isArray values
        for value in values
          scope.values.push key: value, value: value
      else if typeof values is "object"
        for key, value of values
          scope.values.push key: key, value: value

    scope.setValue = (value) ->
      scope.selected = value.key

    scope.isSelected = (value) ->
      value.key is scope.selected

    if ngModel
      ngModel.$formatters.unshift (modelValue) ->
        scope.selected = modelValue

      scope.$watch "selected", (selected) ->
        ngModel.$setViewValue selected
