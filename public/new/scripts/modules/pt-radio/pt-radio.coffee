ptRadio = angular.module "ptRadio", []


ptRadio.directive "ptRadioGroup", ($timeout) ->
  scope: values: "=", model: "=ngModel"
  templateUrl: "scripts/modules/pt-radio/pt-radio.html"
  restrict: "E"
  require: "?ngModel"
  link: (scope, element, attributes, ngModel) ->
    scope.name = (new Date()).getTime()

    init = false
    scope.$watch "model", (newVal) ->
      return if init

      element.iCheck
        radioClass: "input-radio"
        checkedRadioClass: "input-radio_checked"

      element.on "ifChecked", (e) ->
        ngModel.$setViewValue $(e.target).val()

      $timeout ->
        element.find("[value=\"#{ newVal }\"]").iCheck "check"

      init = true
