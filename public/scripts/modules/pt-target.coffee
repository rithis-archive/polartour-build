ptTarget = angular.module "ptTarget", []

ptTarget.directive "ptTarget", ->
  link: (scope, element, attrs) ->
    value = scope.$eval attrs.ptTarget
    element.attr "target", "_blank" if value
