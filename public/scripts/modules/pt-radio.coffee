ptReservations = angular.module "ptRadio", []
  

ptReservations.directive "ptRadio", ->
  restrict: "EACM"
  require: "ngModel"
  link: (scope, element, attrs, controller) ->
    element.iCheck
      radioClass: "iradio_polartour"
      increaseArea: "20%"

    element.on "ifChecked", ->
      controller.$setViewValue element.val() 
