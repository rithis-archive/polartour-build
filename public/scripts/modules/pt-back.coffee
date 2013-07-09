ptBack = angular.module "ptBack", []

ptBack.directive "ptBack", ->
  link: (scope, element) ->
    element.click ->
      history.back()
