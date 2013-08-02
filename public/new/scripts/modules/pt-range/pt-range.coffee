ptRange = angular.module "ptRange", []

ptRange.directive "ptRange", ($document) ->
  scope: ptRangeMin: "@", ptRangeMax: "@"
  templateUrl: "scripts/modules/pt-range/pt-range.html"
  replace: true
  restrict: "E"
  require: "?ngModel"
  link: (scope, element, attributes, ngModel) ->
    scope.focused = false
    scope.start = null
    scope.end = null
    scope.min = null
    scope.max = null

    scope.$watch "ptRangeMin", (min) ->
      scope.min = min or 1

    scope.$watch "ptRangeMax", (max) ->
      scope.max = max or 10

    setText = ->
      if not scope.start or not scope.end
        null
      else if scope.focused
        scope.text = "#{scope.start}-#{scope.end}"
      else if scope.start is scope.end
        scope.text = scope.start
      else
        scope.text = "от #{scope.start} до #{scope.end}"

    scope.$watch "start", setText
    scope.$watch "end", setText

    textRegexp = /^(-?\d+)-(-?\d+)$/
    scope.$watch "text", (text) ->
      if scope.focused
        matches = textRegexp.exec text
        if matches
          scope.start = matches[1]
          scope.end = matches[2]

    scope.focus = ->
      scope.focused = true
      setText()
      input.focus() unless input.is ":focus"

    scope.unfocus = ->
      scope.focused = false
      setText()

    scope.blur = ->
      scope.unfocus()
      input.blur() if input.is ":focus"

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
            scope.blur()
          event.preventDefault()
        when 27 # esc
          safeApply ->
            scope.blur()

    $document.bind "click", (event) ->
      if not element.is(event.target) and element.has(event.target).length == 0
        safeApply ->
          scope.blur()

    if ngModel
      ngModel.$formatters.unshift (modelValue) ->
        if Array.isArray(modelValue) and modelValue.length is 2
          scope.start = modelValue[0]
          scope.end = modelValue[1]

      ngModel.$parsers.unshift (viewValue) ->
        start = Number viewValue[0]
        end = Number viewValue[1]
        if start < scope.min or end > scope.max or start > end
          ngModel.$setValidity "range", false
          undefined
        else
          ngModel.$setValidity "range", true
          [start, end]

      setViewValue = ->
        return if not scope.start or not scope.end
        ngModel.$setViewValue [scope.start, scope.end]

      scope.$watch "start", setViewValue
      scope.$watch "end", setViewValue
