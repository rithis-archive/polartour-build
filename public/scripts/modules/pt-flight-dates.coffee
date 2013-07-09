ptFlightDates = angular.module "ptFlightDates", []


class FlightDatesManager
  constructor: ->
    @fromDate = new Date()
    @toDate = new Date(@fromDate.getTime() + 1000*9*24*60*60)


ptFlightDates.service "ptFlightDatesManager", ->
  new FlightDatesManager


ptFlightDates.directive "ptFlightFrom", (ptFlightDatesManager) ->
  restrict: "A"
  scope: {}
  link: (scope, element, attrs) ->
    $(element).datepicker
        dateFormat: "dd MM"
    .datepicker "setDate", ptFlightDatesManager.fromDate

ptFlightDates.directive "ptFlightTo", (ptFlightDatesManager) ->
  restrict: "A"
  scope: {}
  link: (scope, element, attrs) ->
    $(element).datepicker
        dateFormat: "dd MM"
    .datepicker "setDate", ptFlightDatesManager.toDate
