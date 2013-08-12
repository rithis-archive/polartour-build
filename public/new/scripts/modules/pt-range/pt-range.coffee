ptRange = angular.module "ptRange", []

ptRange.directive "ptRange", ($document) ->
  scope: ptRangeMin: "@", ptRangeMax: "@"
  templateUrl: "scripts/modules/pt-range/pt-range.html"
  replace: true
  transclude: true
  restrict: "E"
  require: "?ngModel"
  link: (scope, element, attributes, ngModel) ->
    scope.focused = false
    scope.debug = attributes.hasOwnProperty "ptDebug"
    scope.start = null
    scope.end = null
    scope.min = null
    scope.max = null

    debug = ->
      if scope.debug
        console.log.apply console, arguments

    scope.$watch "ptRangeMin", (min) ->
      debug "scope.$watch('ptRangeMin')", min
      scope.min = if min then Number(min) else 1

    scope.$watch "ptRangeMax", (max) ->
      debug "scope.$watch('ptRangeMax')", max
      scope.max = if max then Number(max) else 10

    moveLine = ->
      debug "moveLine()"
      return unless scope.focused
      start = if scope.start then Number scope.start else scope.min
      end = if scope.end then Number scope.end else scope.max
      if start <= end and start >= scope.min and end <= scope.max
        left = (start - scope.min) / (scope.max - scope.min) * 100
        width = (end - scope.min) / (scope.max - scope.min) * 100 - left
        line.css "left", String(left) + "%"
        line.css "width", String(width) + "%"

    scope.$watch "start", moveLine
    scope.$watch "end", moveLine
    scope.$watch "min", moveLine
    scope.$watch "max", moveLine

    setText = ->
      debug "setText()"
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
      debug "scope.$watch('text')", text
      if scope.focused
        matches = textRegexp.exec text
        if matches
          scope.start = matches[1]
          scope.end = matches[2]

    scope.focus = ->
      debug "scope.focus()"
      scope.focused = true
      setText()
      input.focus() unless input.is ":focus"

    scope.unfocus = ->
      debug "scope.unfocus()"
      scope.focused = false
      setText()

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

    safeApply = (callback) ->
      if scope.$root.$$phase in ["$apply", "$digest"]
        callback()
      else
        scope.$apply callback

    input = element.find "input"
    line = element.find ".toddler__drag"
    leftButton = line.find ".toddler__btn-left"
    rightButton = line.find ".toddler__btn-right"

    lineOffset = null
    lineWidth = null
    lineStep = null
    button = null

    calculateLineSize = ->
      debug "calculateLineSize()"
      line.css "width", "100%"
      line.css "left", "0%"
      lineOffset = line.offset().left
      lineWidth = line.width()
      lineStep = lineWidth / (scope.max - scope.min)
      moveLine()

    downHandler = (event) ->
      debug "downHandler()"
      event.preventDefault()
      calculateLineSize()
      $document.bind "mousemove", moveHandler
      $document.bind "mouseup", upHandler

    moveHandler = (event) ->
      debug "moveHandler()"
      event.preventDefault()
      pos = Math.round((event.pageX - lineOffset) / lineStep) + scope.min
      switch button
        when "start"
          if scope.min <= pos
            unless scope.end
              scope.end = String scope.max
            if pos <= Number(scope.end)
              safeApply ->
                scope.start = String pos
        when "end"
          if pos <= scope.max
            unless scope.start
              scope.start = String scope.min
            if Number(scope.start) <= pos
              safeApply ->
                scope.end = String pos

    upHandler = (event) ->
      debug "upHandler()"
      event.preventDefault()
      $document.unbind "mousemove", moveHandler
      $document.unbind "mouseup", upHandler

    leftButton.bind "mousedown", (event) ->
      button = "start"
      downHandler event

    rightButton.bind "mousedown", (event) ->
      button = "end"
      downHandler event

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
      if scope.focused and not element.is(event.target) and element.has(event.target).length == 0
        safeApply ->
          scope.blur()

    if ngModel
      ngModel.$formatters.unshift (modelValue) ->
        debug "ngModel.$formatters", modelValue
        if Array.isArray(modelValue) and modelValue.length is 2
          scope.start = modelValue[0]
          scope.end = modelValue[1]

      ngModel.$parsers.unshift (viewValue) ->
        debug "ngModel.$parsers", viewValue
        start = Number viewValue[0]
        end = Number viewValue[1]
        if start < scope.min or end > scope.max or start > end
          ngModel.$setValidity "range", false
          undefined
        else
          ngModel.$setValidity "range", true
          [start, end]

      setViewValue = ->
        debug "setViewValue()"
        return if not scope.start or not scope.end
        ngModel.$setViewValue [scope.start, scope.end]

      scope.$watch "start", setViewValue
      scope.$watch "end", setViewValue
