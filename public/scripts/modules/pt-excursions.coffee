ptExcursions = angular.module "ptExcursions", ["ngResource"]


ptExcursions.factory "Excursions", ($resource) ->
  $resource "/excursions/:id", {}, update: method:'PUT'


ptExcursions.directive "ptExcursionsImages", ($timeout) ->
  link: (scope, element, attributes) ->
    scope.scrollTo = (banner) ->
      scope.listposition = left: (211 * banner * -1) + "px"
      element.find(".active").removeClass "active"
      element.find(".excursion-description-item-image:nth-child(#{banner + 1})")
        .addClass "active"
