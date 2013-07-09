ptSelectRange = angular.module "ptSelectRange", []


ptSelectRange.directive "ptSelectRange", ->
  selectElement = angular.element """
    <div class="select-range-select">
      {{ fromSeparator }}
      <input type="text" ng-model="from" style="width:{{ (from + '').length * 10 }}px;" />
      {{ toSeparator }}
      <input type="text" ng-model="to" style="width:{{ (to + '').length * 10 }}px;" />
      <div>
        <b></b>
      </div>
    </div>
  """
  
  rangeElement = angular.element """
    <div class="select-range-dropdown">
      <div class="select-range-dropdown-values">
        <span>{{ from }}</span>
        <span>{{ to }}</span>
      </div>
    </div>
  """

  sliderElement = angular.element """
    <div class="select-range-slider-wrapper">
      <div class="select-range-slider-wrapper-inner">
        <div class="select-range-slider"></div>
      </div>
    </div>
  """

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

      scope.$watch "from", (newVal) ->
        slider.find(".select-range-slider").slider
          values: [ newVal, scope.to ]

      scope.$watch "to", (newVal) ->
        slider.find(".select-range-slider").slider
          values: [ scope.from, newVal ]
