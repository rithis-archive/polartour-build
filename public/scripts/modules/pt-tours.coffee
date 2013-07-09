ptTours = angular.module "ptTours", []


ptTours.directive "ptTours", ->
  (scope) ->
    scope.tours = [
      "любой"
    ]
