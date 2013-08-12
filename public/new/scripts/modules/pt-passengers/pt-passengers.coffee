ptPassengers = angular.module "ptPassengers", []

ptPassengers.directive "ptPassengers", ($document) ->
  scope: {}
  templateUrl: "scripts/modules/pt-passengers/pt-passengers.html"
  replace: true
  restrict: "E"
  require: "?ngModel"
  link: (scope, element, attributes, ngModel) ->
    scope.focused = false
    scope.value =
      adults: 2
      childs: 0
      infants: 0

    scope.focus = ->
      scope.focused = true

    scope.blur = ->
      scope.focused = false

    scope.toggleFocus = ->
      if scope.focused
        scope.blur()
      else
        scope.focus()

    plural = (n, forms) ->
      if n % 10 == 1 and n % 100 != 11
        forms[0]
      else if n % 10 >= 2 and n % 10 <= 4 and (n % 100 < 10 or n % 100 >= 20)
        forms[1]
      else
        forms[2]

    passengersText = ->
      text = []
      if scope.value.adults > 0
        text.push scope.value.adults + " " + plural scope.value.adults, [
          "взрослый"
          "взрослых"
          "взрослых"
        ]
      if scope.value.childs > 0
        text.push scope.value.childs + " " + plural scope.value.childs, [
          "ребенок"
          "ребенка"
          "детей"
        ]
      if scope.value.infants > 0
        text.push scope.value.infants + " " + plural scope.value.infants, [
          "младенец"
          "младенца"
          "младенцев"
        ]
      scope.text = text.join ", "

    scope.$watch "value.adults", passengersText
    scope.$watch "value.childs", passengersText
    scope.$watch "value.infants", passengersText

    safeApply = (callback) ->
      if scope.$root.$$phase in ["$apply", "$digest"]
        callback()
      else
        scope.$apply callback

    input = element.find "input.label__text_passengers"

    unfocused = false
    input.bind "focus", ->
      if not scope.focused
        safeApply ->
          scope.focus()
      setTimeout ->
        numberInput = element.find "input.label__number-value"
        numberInput.eq(0).focus()
        unless unfocused
          unfocused = true
          numberInput.eq(2).bind "keydown", (event) ->
            if event.keyCode is 9
              setTimeout ->
                safeApply ->
                  scope.blur()
              , 0
      , 0

    $document.bind "click", (event) ->
      if scope.focused and not element.is(event.target) and element.has(event.target).length == 0
        safeApply ->
          scope.blur()

    if ngModel
      ngModel.$formatters.unshift (modelValue) ->
        if typeof modelValue is "object"
          scope.value = modelValue

      scope.$watch "value", ->
        ngModel.$setValidity "passengers", scope.form.$valid
      , true
