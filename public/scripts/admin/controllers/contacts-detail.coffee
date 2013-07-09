polartourAdmin.controller "ContactsDetailCtrl", ($scope, $location, $routeParams, Contacts) ->
  $scope.contact = if $routeParams.id is "new" then new Contacts \
    else Contacts.get id: $routeParams.id

  $scope.save = ->
    return unless $scope.contactForm.$valid
    callback = ->
      $location.url "contacts"
    if $routeParams.id == "new"
      $scope.contact.$save callback
    else
      $scope.contact.$update id: $routeParams.id, callback

  $scope.remove = ->
    if $routeParams.id == "new"
      $location.url "/contacts"
    else if confirm("""Вы точно хотите удалить "#{$scope.contact.name}"?""")
      $scope.contact.$remove id: $routeParams.id, ->
        $location.url "/contacts"
