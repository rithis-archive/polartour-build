ptDatepicker = angular.module "ptDatepicker", []


ptDatepicker.directive "ptDatepicker", ->
  restrict: "EACM"
  require: "ngModel"
  link: (scope, element, attrs, controller) ->
    options =
      dateFormat: attrs.ptDatepickerFormat or "dd MM"

    if attrs.ptDatepickerTrigger?
      options.showOn = "both"
      options.buttonImage = "/images/datepicker-trigger.png"
      options.buttonImageOnly = true

    element.datepicker options
    
    element.keydown (e) ->
      element.datepicker "show" if e.keyCode is 40

    element.on "change", ->
      controller.$setViewValue element.datepicker "getDate"
      scope.$apply()

    init = false
    scope.$watch attrs.ngModel, (newVal) ->
      return if init
      return unless newVal
      element.datepicker "setDate", newVal
      init = true
    , true


ptDatepicker.directive "ptDatetimepicker", ->
  restrict: "EACM"
  require: "ngModel"
  link: (scope, element, attrs, controller) ->
    options =
      dateFormat: attrs.ptDatetimepickerFormat or "dd MM"

    if attrs.ptDatetimepickerTrigger?
      options.showOn = "both"
      options.buttonImage = "/images/datepicker-trigger.png"
      options.buttonImageOnly = true

    element.datetimepicker options

    element.on "change", ->
      controller.$setViewValue element.datetimepicker "getDate"

    init = false
    scope.$watch attrs.ngModel, (newVal) ->
      return if init
      return unless newVal
      element.datetimepicker "setDate", new Date newVal
      init = true
    , true
