ptRooms = angular.module "ptRooms", []


ptRooms.directive "ptRooms", ->
  restrict: "EACM"
  template: """
    <div class="multiple-field" ng-repeat="room in hotel.rooms">
      <div class="multiple-field-wrapper">
        <div class="content-detail-field">
          <label>название</label>
          <input type="text" ng-model="room.name" />
        </div>
        <div class="content-detail-field">
          <label>описание</label>
          <textarea ng-model="room.description" />
        </div>
      </div>
      <button class="big_button multiple-field-remove" ng-click="removeRoom($index)">-</button>
    </div>
    <div>
      <button class="big_button multiple-field-add" ng-click="addRoom()">+</button>
    </div>
  """
  
  link: (scope, element, attrs) ->
    scope.hotel.rooms = [ name: "", description: ""] unless scope.hotel.rooms

    scope.addRoom = ->
      scope.hotel.rooms.push
        name: ""
        description: ""

    scope.removeRoom = (index) ->
      scope.hotel.rooms.splice index, 1
