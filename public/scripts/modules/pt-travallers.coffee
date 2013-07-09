ptTravallers = angular.module "ptTravallers", []


ptTravallers.directive "ptTravallers", ->
  selectElement = angular.element """
    <a href="#" class="select-travallers-select">
      {{ parents }} взрослых {{ getChildrenText() }} {{ getBabiesText() }}
      <div>
        <b></b>
      </div>
    </a>
  """
  
  dropdownElement = angular.element """
    <div class="select-travallers-dropdown">
      <div class="select-travallers-dropdown-item">
        <p>взрослых</p>
        <a href="#" class="select-travallers-less  select-travaller-count-button"></a>
        <input type="text" value="{{ parents }}" name="parents" />
        <a href="#" class="select-travallers-more select-travaller-count-button"></a>
      </div>
      <div class="select-travallers-dropdown-item">
        <p>детей</p>
        <a href="#" class="select-travallers-less  select-travaller-count-button"></a>
        <input type="text" value="{{ children }}" name="children" />
        <a href="#" class="select-travallers-more select-travaller-count-button"></a>
      </div>
      <div class="select-travallers-dropdown-item">
        <p>младенцев</p>
        <a href="#" class="select-travallers-less  select-travaller-count-button"></a>
        <input type="text" value="{{ babies }}" name="babies" />
        <a href="#" class="select-travallers-more select-travaller-count-button"></a>
      </div>
    </div>
  """

  counterElement = angular.element """
    <div class="select-range-slider"></div>
  """

  restrict: "EACM"
  scope: {}
  
  compile: (tElem) ->
    select = selectElement.clone()
    dropdown = dropdownElement.clone()
    
    tElem.append select
    tElem.append dropdown


    (scope, element, attrs) ->
      scope.parents = attrs.parents || 1
      scope.children = attrs.children || 0
      scope.babies = attrs.babies || 0
      
      scope.getChildrenText = ->
        ", #{scope.children} детей" if scope.children > 0

      scope.getBabiesText = ->
        ", #{scope.babies} младенцев" if scope.babies > 0

      dropdown.width select.outerWidth()

      select.on "click", (e) ->
        e.preventDefault()
        element.toggleClass "select-travallers-active"

      dropdown.find(".select-travallers-less").each (index, less) ->
        $(less).on "click", (e) ->
          e.preventDefault()
          input = $(@).next()
          val = parseInt(input.val())
          model = input.attr "name"
          if val > 0 and scope[model]?
            scope[model] = val - 1
            scope.$apply()

      dropdown.find(".select-travallers-more").each (index, less) ->
        $(less).on "click", (e) ->
          e.preventDefault()
          input = $(@).prev()
          val = parseInt(input.val())
          model = input.attr "name"
          if scope[model]?
            scope[model] = val + 1
            scope.$apply()
