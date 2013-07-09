ptButtonsGroup = angular.module "ptButtonsGroup", []


ptButtonsGroup.directive "ptButtonsGroup", ->
  restrict: "EACM"
  
  require: "?ngModel"
  compile: (tElm, tAttrs) ->
    repeatOption = tElm.find "*[ng-repeat], *[data-ng-repeat]"

    if repeatOption.length
      repeatAttr = repeatOption.attr("ng-repeat") || repeatOption.attr("data-ng-repeat")
      watch = $.trim(repeatAttr.split("|")[0]).split(" ").pop()


    (scope, element, attrs, controller) ->
      setActive = (newActive) ->
        active = element.find ".active"
        if active
          active.toggleClass "active"
        newActive.toggleClass "active"

      scope.$watch watch, (newVal, oldVal, scope) ->
        return unless newVal

        defaultValue = scope.$eval attrs.ngModel if attrs.ngModel
        element.children().each (index, button) =>
          button = $ button
          button.on "click", (e) ->
            e.preventDefault()
            scope.$eval "#{attrs.ngModel} = '#{button.text()}'" if attrs.ngModel
            scope.$apply()
            setActive button

      scope.$watch attrs.ngModel, (newVal, oldVal, scope) ->
        active = element.find ":contains(#{newVal})"
        setActive active if newVal and active
      , true
