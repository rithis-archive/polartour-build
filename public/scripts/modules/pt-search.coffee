ptSearch = angular.module "ptSearch", []


ptSearch.directive "ptSearch", ->
  (scope, element, attrs) ->
    $("input").iCheck
      checkboxClass: "icheckbox_polartour"
      increaseArea: "20%"
