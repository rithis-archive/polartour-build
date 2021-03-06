ptSearch = angular.module "ptSearch", [
  "ptRegion"
]

ptSearch.controller "PtSearchCtrl", ($scope, ptCountriesManager, ptRegion) ->
  $scope.bigSearch = false

  twoWeeks = Date.now() + 1000 * 60 * 60 * 24 * 14
  $scope.search =
    from: ptRegion.getRegion()
    to: "tr"
    tour: 11
    dateSmall: new Date twoWeeks
    dateStart: new Date twoWeeks
    dateEnd: new Date twoWeeks
    currency: "rub"
    passengers:
      adults: 3
      childs: 0
      infants: 0
    nightsSmall: 7
    nights: [7, 7]
    town: 11
    category: 3
    hotels: []
    meal: "ai"
    places: false
    stop: true

  $scope.values =
    from: ptRegion.regions
    to: ptCountriesManager.countries
    tour: 10: "Анталья", 11: "Бодрум", 12: "Даламан"
    currency: rub: "RUB", usd: "USD", eur: "EUR"
    town: 10: "Анталья", 11: "Бодрум", 12: "Даламан"
    category: 3: "3 и менее", 4: "4", 5: "5", hv: "HV"
    hotels: [
      "Accura Golden Horn Sirkesi"
      "Baia Bodrum"
      "Cande Festival (Ladies Beach)"
    ]
    meal: ai: "AI", bb: "BB", hb: "HB", ro: "RO"


  priceRanges =
    rub: min: 10000, max: 1000000
    usd: min: 300, max: 35000
    eur: min: 200, max: 25000

  $scope.$watch "search.currency", (currency) ->
    $scope.priceMin = priceRanges[currency].min
    $scope.priceMax = priceRanges[currency].max
    $scope.search.price = [
      $scope.priceMin
      $scope.priceMax
    ]

  inited = false
  $scope.$watch "bigSearch", (big) ->
    if inited
      if big
        $scope.search.dateStart = $scope.search.dateSmall
        $scope.search.dateEnd = $scope.search.dateSmall
        $scope.search.nights = [
          $scope.search.nightsSmall
          $scope.search.nightsSmall
        ]
      else
        $scope.search.dateSmall = $scope.search.dateStart
        $scope.search.nightsSmall = $scope.search.nights[0]
    else
      inited = true

  $scope.send = (search, form, big) ->
    console.log "$valid", form.$valid
    if form.$valid
      for key, value of search
        console.log key, value
