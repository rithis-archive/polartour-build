ptCalendar = angular.module "ptCalendar", []

ptCalendar.directive "ptCalendar", ($document) ->
  restrict: "E"
  replace: true
  templateUrl: "scripts/modules/pt-calendar/pt-calendar.html"
  scope: placeholder: "@"
  require: "ngModel"
  link: (scope, element, attributes, ngModel) ->
    scope.focused = false
    scope.months = [
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

    yearStart = Number(attributes.ptCalendarYearStart or (new Date).getUTCFullYear()-100)
    yearStop = Number(attributes.ptCalendarYearStop or (new Date).getUTCFullYear()+100)

    scope.years = (y for y in [yearStart..yearStop])
    if attributes.ptCalendarYearReverse
      scope.years.reverse()

    scope.showNext = ->
      return true unless scope.month
      return true if scope.month.getUTCFullYear() < yearStop
      scope.month.getUTCMonth() < 11

    scope.showPrev = ->
      return true unless scope.month
      return true if scope.month.getUTCFullYear() > yearStart
      scope.month.getUTCMonth() > 0

    scope.setYear = (year) ->
      scope.showYears = false
      scope.month.setUTCFullYear year
      scope.setCurrentMonth scope.month

    scope.setMonth = (index) ->
      scope.showMonths = false
      scope.month.setUTCMonth index
      scope.setCurrentMonth scope.month

    scope.setCurrentMonth = (month) ->
      scope.month = month
      scope.month.setUTCDate 1
      scope.weeks = []
      start = new Date month
      if start.getUTCDay() == 0
        start.setUTCDate start.getUTCDate() - 6
      else if start.getUTCDay() > 1
        start.setUTCDate start.getUTCDate() - start.getUTCDay() + 1
      end = new Date month
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
            inactive: start.getUTCMonth() != month.getUTCMonth()
          prev = new Date start.getTime()
          start = new Date start.getTime() + 86400000
          if prev.getUTCDay() == start.getUTCDay()
            start = new Date start.getTime() + 86400000
        w += 1

    scope.isToday = (date) ->
      scope.dateText == format date

    scope.blur = ->
      return unless scope.focused

      fn = ->
        input.blur()
        scope.focused = false

      if scope.$root.$$phase in ["$apply", "$digest"]
        fn()
      else
        scope.$apply fn

    scope.setDate = (date) ->
      scope.date = date
      scope.blur()

    scope.prevMonth = ->
      scope.month.setUTCMonth scope.month.getUTCMonth()-1
      scope.setCurrentMonth scope.month

    scope.nextMonth = ->
      scope.month.setUTCMonth scope.month.getUTCMonth()+1
      scope.setCurrentMonth scope.month

    format = (date) ->
      day = date.getUTCDate()
      day = "0#{day}" if day < 10
      month = date.getUTCMonth() + 1
      month = "0#{month}" if month < 10
      year = date.getUTCFullYear()
      "#{day}.#{month}.#{year}"

    scope.$watch "date", (date) ->
      return unless date
      scope.dateText = format date

    scope.$watch "dateText", (date) ->
      if date and date.match /^\d\d\d$/
        scope.dateText = date[0..1] + "." + date[2]
      else if date and date.match /^\d\d\.\d\d\d$/
        scope.dateText = date[0..4] + "." + date[5]
      else
        if input.is ":focus"
          input[0].selectionStart = input[0].selectionEnd = date.length
        ngModel.$setViewValue date

    ngModel.$formatters.unshift (modelValue) ->
      if modelValue instanceof Date
        scope.date = new Date Date.UTC modelValue.getFullYear(), modelValue.getMonth(), modelValue.getDate()
      modelValue

    ngModel.$parsers.unshift (viewValue) ->
      if viewValue is undefined or viewValue is null or viewValue is ""
        ngModel.$setValidity "date", true
        return undefined
      if typeof viewValue is "string" and viewValue.match /^\d\d\.\d\d\.\d\d\d\d$/
        ngModel.$setValidity "date", true
        date = viewValue.split "."
        day = Number(date[0])
        month = Number(date[1])
        year = Number(date[2])
        if yearStart <= year <= yearStop
          viewValue = new Date year, month-1, day
          scope.setCurrentMonth viewValue
          return viewValue
      ngModel.$setValidity "date", false
      return undefined

    input = element.find "input"
    button = element.find "button.label__btn"

    button.bind "click", ->
      input.focus()

    input.bind "focus", ->
      scope.$apply ->
        scope.focused = true
        scope.showMonths = false
        scope.showYears = false
        if scope.date
          scope.setCurrentMonth new Date scope.date
        else
          date = new Date
          scope.setCurrentMonth new Date Date.UTC date.getFullYear(), date.getMonth(), date.getDate()

    input.bind "keydown", (event) ->
      switch event.keyCode
        when 27 # esc
          scope.blur()

    $document.bind "keyup", (event) ->
      if event.keyCode == 9
        unless input.is ":focus"
          scope.blur()

    $document.bind "click", (event) ->
      if not element.is(event.target) and element.has(event.target).length == 0
        scope.blur()
