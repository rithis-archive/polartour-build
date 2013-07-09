polartourAdmin.controller "BannersCtrl", ($scope, $location, $http, Banners) ->
  $scope.banners = Banners.query()

  $scope.add = (size) ->
    banner = new Banners
      position: $scope.banners.length
      size: size
    
    banner.$save ->
      $scope.banners.push banner

  $scope.edit = (id) ->
    $location.url "banners/#{id}"
  
  $scope.save = ->
    banners = []
    for id, position of $scope.getRange()
      banners.push _id: id, position: position

    $.ajax
      type: "PATCH"
      dataType: "json"
      contentType: "application/json"
      url: "/banners"
      data: JSON.stringify banners
