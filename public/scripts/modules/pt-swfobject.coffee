ptSwfobject = angular.module "ptSwfobject", []

ptSwfobject.directive "ptSwfobject", ->
  restrict: "EACM"
  link: (scope, element, attrs) ->
    scope.$watch attrs.ngModel, (newVal) ->
      if newVal?
        width = element.width()
        height = element.height()
        wrapper = $ "<div>"
        element.html wrapper
        swfobject.embedSWF newVal, wrapper.get(0), width, height, 10
