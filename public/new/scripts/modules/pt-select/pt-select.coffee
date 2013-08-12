ptSelect = angular.module "ptSelect", []

selectLink = ($document, type, scope, element, attributes, ngModel) ->
  scope.valuesLoadedCallback = null
  scope.selectedIndex = -1
  scope.valuesLoaded = false
  scope.ignoreFilter = true
  scope.multiselect = type is "multiselect"
  scope.selected = null
  scope.datalist = type is "datalist"
  scope.focused = false
  scope.debug = attributes.hasOwnProperty "ptDebug"
  scope.values = []
  scope.radio = type is "radio"
  scope.value = if scope.multiselect then [] else null
  scope.dirty = false
  scope.text = ""

  debug = ->
    if scope.debug
      console.log arguments

  scope.focus = ->
    debug "scope.focus()"
    scope.focused = true
    scope.dirty = false
    scope.filterValues()
    setTimeout ->
      input.focus() unless input.is ":focus"
    , 0

  scope.unfocus = ->
    debug "scope.unfocus()"
    return unless scope.focused
    scope.focused = false
    if scope.value
      scope.text = scope.value.value
    else
      scope.text = ""

  scope.blur = ->
    debug "scope.blur()"
    scope.unfocus()
    input.blur() if input.is ":focus"

  scope.toggleFocus = ->
    debug "scope.toggleFocus()"
    if scope.focused
      scope.blur()
    else
      scope.focus()

  scope.setValueWithoutBlur = (value) ->
    debug "scope.setValueWithoutBlur()", value
    if scope.multiselect
      scope.value.push value unless value in scope.value
      scope.text = ""
      if scope.focused
        scope.filterValues()
    else
      scope.value = value
      if scope.text is value.value
        scope.dirty = false
        if scope.focused
          scope.filterValues()
      else
        scope.text = value.value
        scope.ignoreFilter = true

  scope.removeValue = (value) ->
    debug "scope.removeValue()", value
    setTimeout ->
      safeApply ->
        scope.value = scope.value.filter (v) ->
          v isnt value
        scope.filterValues()
        input.focus() if scope.focused
    , 0

  scope.setValue = (value) ->
    debug "scope.setValue()", value
    scope.setValueWithoutBlur value
    scope.blur()

  scope.setSelectedValue = ->
    debug "scope.setSelectedValue()"
    if scope.selected
      scope.setValueWithoutBlur scope.selected

  scope.select = (index) ->
    debug "scope.select()", index
    if scope.filteredValues[index]
      scope.selectedIndex = index
      scope.selected = scope.filteredValues[index]
      scope.scrollList()
    else
      scope.selectedIndex = -1
      scope.selected = null

  scope.selectValue = ->
    debug "scope.selectValue()"
    if scope.value
      index = 0
      for value in scope.filteredValues
        if value is scope.value
          scope.select index
          return
        index += 1
    scope.select 0

  scope.selectPrevious = ->
    debug "scope.selectPrevious()"
    index = scope.selectedIndex - 1
    if scope.filteredValues[index]
      scope.select index

  scope.selectNext = ->
    debug "scope.selectNext()"
    index = scope.selectedIndex + 1
    if scope.filteredValues[index]
      scope.select index

  scope.filterValues = ->
    debug "scope.filterValues()"
    if scope.dirty and String(scope.text).length > 0
      test = new RegExp scope.text, "i"
      scope.filteredValues = scope.values.filter (value) ->
        String(value.value).match test
    else if scope.datalist
      scope.filteredValues = []
    else
      scope.filteredValues = scope.values

    if scope.multiselect
      scope.filteredValues = scope.filteredValues.filter (value) ->
        value not in scope.value

    scope.selectValue()

  scope.$watch "text", (value) ->
    debug "scope.$watch('text')", value
    return unless scope.focused
    if scope.ignoreFilter
      scope.ignoreFilter = false
      scope.dirty = false
    else
      scope.dirty = true
    scope.filterValues()

  scope.$watch "ptSelectValues", (ptSelectValues) ->
    debug "scope.$watch('ptSelectValues')", ptSelectValues
    if Array.isArray ptSelectValues
      scope.values = (key: value, value: value for value in ptSelectValues)
    else if typeof ptSelectValues is "object"
      scope.values = (key: key, value: value for key, value of ptSelectValues)
    else
      scope.values = []

    scope.valuesLoaded = true
    scope.valuesLoadedCallback() if scope.valuesLoadedCallback

  safeApply = (callback) ->
    if scope.$root.$$phase in ["$apply", "$digest"]
      callback()
    else
      scope.$apply callback

  scope.scrollList = ->
    debug "scope.scrollList()"
    if scope.selected and not scope.radio
      setTimeout -> # wait render
        listScroll = list.scrollTop()
        visibleHeight = list.height()
        listPadding = list.innerHeight() - visibleHeight
        height = list[0].scrollHeight - listPadding
        itemHeight = height / scope.filteredValues.length
        firstVisible = Math.ceil(listScroll / itemHeight)
        lastVisible = Math.ceil((listScroll + visibleHeight - itemHeight) / itemHeight) - 1

        if scope.selectedIndex < firstVisible
          list.scrollTop itemHeight * scope.selectedIndex
        else if scope.selectedIndex > lastVisible
          list.scrollTop itemHeight * (scope.selectedIndex + 1) - visibleHeight
      , 0

  input = element.find "input"
  list = element.find ".label__list"
  chosen = element.find(".label__select").find ".label__chosen"

  input.bind "focus", ->
    if not scope.focused
      safeApply ->
        scope.focus()

  input.bind "keydown", (event) ->
    switch event.keyCode
      when 9 # tab
        safeApply ->
          scope.unfocus()
      when 13 # enter
        safeApply ->
          scope.setSelectedValue()
          if scope.ptSelectSelected
            scope.$eval "ptSelectSelected()"
        event.preventDefault()
      when 27 # esc
        safeApply ->
          scope.blur()
      when 38 # up
        safeApply ->
          scope.selectPrevious()
        event.preventDefault()
      when 40 # down
        safeApply ->
          scope.selectNext()
        event.preventDefault()

  chosen.bind "click", (event) ->
    if chosen.is event.target
      safeApply ->
        scope.focus()

  $document.bind "click", (event) ->
    if scope.focused and not element.is(event.target) and element.has(event.target).length == 0
      safeApply ->
        scope.blur()

  if ngModel
    ngModel.$formatters.unshift (modelValue) ->
      debug "ngModel.$formatters", modelValue
      loadValue = ->
        if scope.multiselect and Array.isArray modelValue
          for value in scope.values
            if String(value.key) in modelValue
              scope.setValueWithoutBlur value
        else
          for value in scope.values
            if String(modelValue) is String(value.key)
              scope.setValueWithoutBlur value
              break

      if scope.valuesLoaded
        loadValue()
      else
        scope.valuesLoadedCallback = loadValue

    ngModel.$parsers.unshift (viewValue) ->
      debug "ngModel.$parsers", viewValue
      if scope.multiselect
        (value.key for value in viewValue)
      else if scope.datalist
        viewValue
      else
        viewValue.key

    if scope.datalist
      scope.$watch "text", (text) ->
        debug "scope.$watch('text')", text
        ngModel.$setViewValue text
    else
      scope.$watch "value", (value) ->
        debug "scope.$watch('value')", value
        if value or scope.multiselect
          ngModel.$setViewValue value
      , true

ptSelect.directive "ptSelect", ($document) ->
  scope: ptSelectValues: "=", ptSelectSelected: "&"
  templateUrl: "scripts/modules/pt-select/pt-select.html"
  replace: true
  restrict: "E"
  require: "?ngModel"
  link: selectLink.bind null, $document, "select"

ptSelect.directive "ptSelectRadio", ($document) ->
  scope: ptSelectValues: "=", ptSelectSelected: "&"
  templateUrl: "scripts/modules/pt-select/pt-select-radio.html"
  replace: true
  restrict: "E"
  require: "?ngModel"
  link: selectLink.bind null, $document, "radio"

ptSelect.directive "ptSelectDatalist", ($document) ->
  scope: ptSelectValues: "=", ptSelectSelected: "&"
  templateUrl: "scripts/modules/pt-select/pt-select-datalist.html"
  replace: true
  restrict: "E"
  require: "?ngModel"
  link: selectLink.bind null, $document, "datalist"

ptSelect.directive "ptSelectMultiselect", ($document) ->
  scope: ptSelectValues: "=", ptSelectSelected: "&"
  templateUrl: "scripts/modules/pt-select/pt-select-multiselect.html"
  replace: true
  restrict: "E"
  require: "?ngModel"
  link: selectLink.bind null, $document, "multiselect"

ptSelect.directive "ptSelectCurrency", ($document) ->
  scope: ptSelectValues: "=", ptSelectSelected: "&"
  templateUrl: "scripts/modules/pt-select/pt-select-currency.html"
  replace: true
  restrict: "E"
  require: "?ngModel"
  link: selectLink.bind null, $document, "country"
