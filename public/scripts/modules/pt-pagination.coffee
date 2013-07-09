ptPagination = angular.module "ptPagination", []


ptPagination.directive "ptPagination", ->
  restrict: "EACM"
  scope: {}
  
  compile: (tElem) ->
    select = selectElement.clone()
    slider = sliderElement.clone()
    range = rangeElement.clone()
      .prepend slider
    
    tElem.append select
    tElem.append range

    (scope, element, attrs) ->
      renderValue = ->
        $.trim [
          scope.fromSeparator
          scope.from
          scope.toSeparator
          scope.to
        ].join(" ")

      scope.name = attrs.name || "select-range"
      scope.from = parseInt(attrs.fromRange) or 0
      scope.fromSeparator = attrs.fromSeparator or ""
      scope.toSeparator = attrs.toSeparator or "—"
      scope.to = parseInt(attrs.toRange) or 100
      scope.value = renderValue()

      range.width select.outerWidth()

      select.on "click", (e) ->
        e.preventDefault()
        element.toggleClass "select-range-active"

      slider.find(".select-range-slider").slider
        range: true
        min: parseInt attrs.minRange
        max: parseInt attrs.maxRange
        values: [ scope.from, attrs.toRange ]
        step: 1
        slide: (event, ui) ->
          scope.from = ui.values[0]
          scope.to = ui.values[1]
          scope.value = renderValue()
          scope.$apply()
