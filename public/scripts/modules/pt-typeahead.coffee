ptTypeahead = angular.module "ptTypeahead", []

ptTypeahead.directive "ptTypeahead", ($compile) ->
  restrict: "A"
  link: (scope, element, attrs) ->
    return unless attrs.typeaheadData and attrs.typeaheadProperty

    init = false
    scope.$watch attrs.typeaheadData, (newVal) ->
      return unless newVal
      return if init

      values = []
      newVal.forEach (item) ->
        values.push
          id: item._id if item._id
          country: item.country
          value: item[attrs.typeaheadProperty] if item[attrs.typeaheadProperty]

      typeahead = element.typeahead
        local: values
        template: (data) ->
          "<a>#{ data.value }</a>"
      
      typeahead.on "typeahead:selected", (e, data) ->
        if window.location.pathname == "/admin.html"
          window.location.hash = "!/hotels/#{ data.id }"
        else
          window.location.hash = "!/#{ data.country }/hotels/#{ data.id }"
      init = true
    