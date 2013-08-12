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
    hasChildren = false
    while childrenScope
      form = childrenScope.bookingRequestTouristForm
      hasChildren = true if form
      valid = form.$valid if form and valid
      childrenScope = childrenScope.$$nextSibling
    valid && hasChildren

  $scope.send = ->
    $scope.showValidation = true
    if $scope.bookingRequestForm.$valid and $scope.childrenFormsValid()
      $scope.bookingRequest.$save ->
        $scope.sent = true

ptBookingRequest.directive "ptBookingRequestsTourist", ($http, $compile, $templateCache) ->
  templateUrl: "scripts/modules/pt-booking-request/pt-booking-request-tourist.html"
  restrict: "EACM"
  link: (scope, element) ->
    scope.genderValues =
      male: "муж."
      female: "жен."
