ptBookingRequest = angular.module "ptBookingRequest", [
  "ngResource"
]

ptBookingRequest.factory "ptBookingRequests", ($resource) ->
  $resource "/reservations/:_id"

ptBookingRequest.controller "PtBookingRequestCtrl", ($scope, $location, ptBookingRequests, ptFormDescriptions) ->
  $scope.showValidation = false
  $scope.bookingRequest = new ptBookingRequests tourists: [gender: "male"]
  $scope.childrenForms = []
  $scope.description = ptFormDescriptions.get code: "reservations"

  $scope.nights = ["1", "2", "3", "4", "5", "6", "7"]

  $scope.addTourist = ->
    $scope.bookingRequest.tourists.push gender: "male"

  $scope.removeTourist = (remove) ->
    updated = []
    $scope.bookingRequest.tourists.forEach (tourist, index) ->
      updated.push tourist unless remove == index
    $scope.bookingRequest.tourists = updated

  $scope.childrenFormsValid = ->
    childrenScope = $scope.$$childHead
    valid = true
    while childrenScope
      form = childrenScope.bookingRequestTouristForm
      valid = form.$valid if form and valid
      childrenScope = childrenScope.$$nextSibling
    valid

  $scope.send = ->
    $scope.showValidation = true
    if $scope.bookingRequestForm.$valid and $scope.childrenFormsValid()
      $scope.bookingRequest.$save ->
        alert "Ваш запрос успешно сохранен."
        $location.url "/"

ptBookingRequest.directive "ptBookingRequestsTourist", ->
  templateUrl: "scripts/modules/pt-booking-request/pt-booking-request-tourist.html"
  restrict: "E"
  link: (scope) ->
    scope.genderValues =
      male: "муж."
      female: "жен."
