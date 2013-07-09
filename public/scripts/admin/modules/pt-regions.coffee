ptRegions = angular.module "ptRegions", []

ptRegions.directive "ptRegions", ->
  restrict: "EACM"
  #require: "ngModel"
  link: (scope, element, attrs) ->
    return unless attrs.ptRegionsData
    
    init = false
    scope.$watch attrs.ptRegionsData, (newVal) ->
      return unless newVal
      return if init
      
      typeahead = element.typeahead
        local: newVal
        template: (data) ->
          "<a>#{ data.value }</a>"
      init = true