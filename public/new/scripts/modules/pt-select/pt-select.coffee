ptSelect = angular.module "ptSelect", []

ptSelect.directive "ptSelect", ($document) ->
  scope: ptSelectValues: "=", model: "=ngModel"
  templateUrl: "scripts/modules/pt-select/pt-select.html"
  replace: true
  restrict: "E"
  require: "?ngModel"
  link: (scope, element, attributes, ngModel) ->
    scope.valuesLoadedCallback = null
    scope.selectedIndex = -1
    scope.valuesLoaded = false
    scope.ignoreFilter = true
    scope.selected = null
    scope.focused = false
    scope.values = []
    scope.value = null
    scope.dirty = false
    scope.text = ""

    scope.focus = ->
      scope.focused = true
      scope.dirty = false
      scope.filterValues()
      input.focus() unless input.is ":focus"

    scope.unfocus = ->
      scope.focused = false
      if scope.value
        scope.text = scope.value.value
      else
        scope.text = ""

    scope.blur = ->
      scope.unfocus()
      input.blur() if input.is ":focus"

    scope.setValueWithoutBlur = (value) ->
      scope.value = value
      if scope.text is value.value
        scope.dirty = false
        scope.filterValues()
      else
        scope.text = value.value
        scope.ignoreFilter = true

    scope.setValue = (value) ->
      scope.setValueWithoutBlur value
      scope.blur()

    scope.setSelectedValue = ->
      if scope.selected
        scope.setValueWithoutBlur scope.selected

    scope.select = (index) ->
      if scope.filteredValues[index]
        scope.selectedIndex = index
        scope.selected = scope.filteredValues[index]
      else
        scope.selectedIndex = -1
        scope.selected = null

    scope.selectValue = ->
      if scope.value
        index = 0
        for value in scope.filteredValues
          if value is scope.value
            scope.select index
            return
          index += 1
      scope.select 0

    scope.selectPrevious = ->
      index = scope.selectedIndex - 1
      if scope.filteredValues[index]
        scope.select index

    scope.selectNext = ->
      index = scope.selectedIndex + 1
      if scope.filteredValues[index]
        scope.select index

    scope.filterValues = ->
      if scope.dirty and String(scope.text).length > 0
        test = new RegExp scope.text, "i"
        scope.filteredValues = scope.values.filter (value) ->
          String(value.value).match test
      else
        scope.filteredValues = scope.values

      scope.selectValue()

    scope.$watch "text", (value) ->
      if scope.ignoreFilter
        scope.ignoreFilter = false
        scope.dirty = false
      else
        scope.dirty = true
      scope.filterValues()

    scope.$watch "ptSelectValues", (ptSelectValues) ->
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

    input = element.find "input"

    input.bind "focus", ->
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

    $document.bind "click", (event) ->
      if not element.is(event.target) and element.has(event.target).length == 0
        safeApply ->
          scope.blur()

    if ngModel
      ngModel.$formatters.unshift (modelValue) ->
        loadValue = ->
          for value in scope.values
            if String(modelValue) is String(value.key)
              scope.setValue value
              break

        if scope.valuesLoaded
          loadValue()
        else
          scope.valuesLoadedCallback = loadValue

      ngModel.$parsers.unshift (viewValue) ->
        viewValue.key

      scope.$watch "value", (value) ->
        if value
          ngModel.$setViewValue value
