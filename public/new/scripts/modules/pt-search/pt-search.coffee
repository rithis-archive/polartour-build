ptSearch = angular.module "ptSearch", []

ptSearch.controller "PtFastSearchCtrl", ($scope, ptCountriesManager) ->
  $scope.search =
    from: "Москва"
    to: "tr"
    date: new Date Date.now() + 1000 * 60 * 60 * 24 * 14
    nights: 7

  $scope.values =
    from: ["Москва", "Санкт-Петербург", "Екатеринбург", "Самара", "Ростов-на-Дону", "Уфа", "Казань"]
    to: ptCountriesManager.countries
