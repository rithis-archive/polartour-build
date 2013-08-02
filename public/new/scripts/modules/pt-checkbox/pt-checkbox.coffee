ptCheckbox = angular.module "ptCheckbox", []

ptCheckbox.directive "ptCheckbox", ->
  scope: label: "@"
  templateUrl: "scripts/modules/pt-checkbox/pt-checkbox.html"
  replace: true
  transclude: true
  restrict: "E"
  require: "?ngModel"
  link: (scope, element, attributes, ngModel) ->
    element.iCheck
      checkboxClass: "input-checkbox"
      checkedClass: "input-checkbox_checked"

    return unless ngModel

    init = false
    scope.$watch "model", ->
      element.iCheck "check" if ngModel.$viewValue
        
      return if init
        
      element.on "ifChecked", (e) -> 
        ngModel.$setViewValue !ngModel.$viewValue

      init = true
