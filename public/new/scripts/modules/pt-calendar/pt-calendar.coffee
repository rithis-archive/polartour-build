ptCalendar = angular.module "ptCalendar", []

ptCalendar.directive "ptCalendar", ($document) ->
  restrict: "E"
  replace: true
  templateUrl: "scripts/modules/pt-calendar/pt-calendar.html"
  scope: placeholder: "@", ptCalendarMin: "@", ptCalendarMax: "@"
  require: "?ngModel"
  link: (scope, element, attributes, ngModel) ->
    today = new Date
    months = [
      "янв"
      "фев"
      "мар"
      "апр"
      "май"
      "июн"
      "июл"
      "авг"
      "сен"
      "окт"
      "ноя"
      "дек"
    ]

    scope.showMonths = false
    scope.showYears = false
    scope.focused = false
    scope.months = months
    scope.debug = attributes.hasOwnProperty "ptDebug"
    scope.month = new Date today.getUTCFullYear(), today.getUTCMonth(), today.getUTCDate()
    scope.min = new Date today.getUTCFullYear() - 100, today.getUTCMonth(), today.getUTCDate()
    scope.max = new Date today.getUTCFullYear() + 100, today.getUTCMonth(), today.getUTCDate()

    debug = ->
      if scope.debug
        console.log.apply console, arguments

    scope.calculateYears = ->
      debug "scope.calculateYears()"
      minYear = scope.min.getUTCFullYear()
      maxYear = scope.max.getUTCFullYear()
      scope.years = (year for year in [minYear..maxYear])
      scope.years.reverse()

    scope.$watch "min", scope.calculateYears
    scope.$watch "max", scope.calculateYears

    scope.setDate = (date) ->
      debug "scope.setDate()", date
      scope.date = date
      scope.blur()

    scope.setYear = (year) ->
      debug "scope.setYear()", year
      scope.showYears = false
      scope.month.setUTCFullYear year
      scope.calculateMonth()

    scope.setMonth = (index) ->
      debug "scope.setMonth()", index
      scope.showMonths = false
      scope.month.setUTCMonth index
      scope.calculateMonth()

    scope.prevMonth = ->
      debug "scope.prevMonth()"
      scope.month.setUTCMonth scope.month.getUTCMonth()-1
      scope.calculateMonth()

    scope.nextMonth = ->
      debug "scope.nextMonth()"
      scope.month.setUTCMonth scope.month.getUTCMonth()+1
      scope.calculateMonth()

    format = (date) ->
      debug "format()", date
      day = date.getUTCDate()
      day = "0#{day}" if day < 10
      month = date.getUTCMonth() + 1
      month = "0#{month}" if month < 10
      year = date.getUTCFullYear()
      "#{day}.#{month}.#{year}"

    parseDate = (str) ->
      debug "parseDate()", str
      if typeof str is "string" and str.match /^\d\d\.\d\d\.\d\d\d\d$/
        arr = str.split "."
        year = Number arr[2]
        month = Number arr[1]
        day = Number arr[0]
        new Date Date.UTC year, month - 1, day
      else
        false

    scope.$watch "ptCalendarMin", (min) ->
      debug "scope.$watch('ptCalendarMin')", min
      if typeof min is "string"
        if min is "today"
          scope.min = new Date Date.UTC today.getUTCFullYear(), today.getUTCMonth(), today.getUTCDate()
        else
          min = parseDate min
          scope.min = min if min

    scope.$watch "ptCalendarMax", (max) ->
      debug "scope.$watch('ptCalendarMax')", max
      if typeof max is "string"
        if max is "today"
          scope.max = new Date Date.UTC today.getUTCFullYear(), today.getUTCMonth(), today.getUTCDate()
        else
          max = parseDate max
          scope.max = max if max

    scope.focus = ->
      debug "scope.focus()"
      scope.focused = true
      scope.showMonths = false
      scope.showYears = false
      unless scope.weeks
        scope.calculateMonth()
      input.focus() unless input.is ":focus"

    scope.unfocus = ->
      debug "scope.unfocus()"
      scope.focused = false
      if scope.date
        scope.dateText = format scope.date

    scope.blur = ->
      debug "scope.blur()"
      scope.unfocus()
      input.blur() if input.is ":focus"

    scope.showNext = ->
      debug "scope.showNext()"

    scope.$watch "date", (date) ->
      debug "scope.$watch('date')", date
      if date
        scope.dateText = format date
        scope.month = new Date date
        scope.calculateMonth()

    scope.$watch "dateText", (dateText) ->
      debug "scope.$watch('dateText')", dateText
      return unless scope.focused
      date = parseDate dateText
      if date
        scope.date = date

    scope.calculateMonth = ->
      debug "scope.calculateMonth()"
      scope.month.setUTCDate 1
      scope.month.setUTCHours 0
      scope.month.setUTCMinutes 0
      scope.month.setUTCSeconds 0
      scope.month.setUTCMilliseconds 0
      scope.weeks = []
      start = new Date scope.month
      if start.getUTCDay() == 0
        start.setUTCDate start.getUTCDate() - 6
      else if start.getUTCDay() > 1
        start.setUTCDate start.getUTCDate() - start.getUTCDay() + 1
      end = new Date scope.month
      end.setUTCMonth end.getUTCMonth() + 1
      end.setUTCDate 0
      if end.getUTCDay() != 0
        end.setUTCDate end.getUTCDate() + 7 - end.getUTCDay()

      w = 0
      while start < end
        scope.weeks[w] = []
        for d in [0...7]
          scope.weeks[w][d] =
            date: start
            day: start.getUTCDate()
            inactive: start.getUTCMonth() != scope.month.getUTCMonth() or start < scope.min or start > scope.max
            today: scope.date and scope.date.getUTCFullYear() is start.getUTCFullYear() and scope.date.getUTCMonth() is start.getUTCMonth() and scope.date.getUTCDate() is start.getUTCDate()
          prev = new Date start.getTime()
          start = new Date start.getTime() + 86400000
          if prev.getUTCDay() == start.getUTCDay()
            start = new Date start.getTime() + 86400000
        w += 1

      scope.showPrev = scope.month.getUTCFullYear() > scope.min.getUTCFullYear() or (scope.month.getUTCFullYear() == scope.min.getUTCFullYear() and scope.month.getUTCMonth() > scope.min.getUTCMonth())
      scope.showNext = scope.month.getUTCFullYear() < scope.max.getUTCFullYear() or (scope.month.getUTCFullYear() == scope.max.getUTCFullYear() and scope.month.getUTCMonth() < scope.max.getUTCMonth())

    safeApply = (callback) ->
      if scope.$root.$$phase in ["$apply", "$digest"]
        callback()
      else
        scope.$apply callback

    input = element.find "input"
    months = element.find ".dp__period_month"
    years = element.find ".dp__period_year"

    input.bind "focus", ->
      safeApply ->
        scope.focus()

    input.bind "keydown", (event) ->
      switch event.keyCode
        when 9 # tab
          safeApply ->
            scope.unfocus()
        when 27 # esc
          safeApply ->
            scope.blur()

    $document.bind "click", (event) ->
      if scope.showMonths and not months.is(event.target) and months.has(event.target).length == 0
        safeApply ->
          scope.showMonths = false
      if scope.showYears and not years.is(event.target) and years.has(event.target).length == 0
        safeApply ->
          scope.showYears = false
      if scope.focused and not element.is(event.target) and element.has(event.target).length == 0
        safeApply ->
          scope.blur()

    if ngModel
      ngModel.$formatters.unshift (modelValue) ->
        debug "ngModel.$formatters", modelValue
        if modelValue instanceof Date
          scope.date = new Date Date.UTC modelValue.getFullYear(), modelValue.getMonth(), modelValue.getDate()

      ngModel.$parsers.unshift (viewValue) ->
        debug "ngModel.$parsers", viewValue
        if scope.min <= viewValue <= scope.max
          ngModel.$setValidity "date", true
          viewValue
        else
          ngModel.$setValidity "date", false
          undefined

      scope.$watch "date", (date) ->
        debug "scope.$watch('date')", date
        if date instanceof Date
          ngModel.$setViewValue date

