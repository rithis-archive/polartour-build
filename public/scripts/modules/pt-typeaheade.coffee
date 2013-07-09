ptTypeahead = angular.module "ptTypeahead", []

ptTypeahead.directive "ptTypeahead", ->
  restrict: "A"
  link: (scope, element, attrs) ->
    console.log attrs
    