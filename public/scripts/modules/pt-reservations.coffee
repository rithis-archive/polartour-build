ptReservations = angular.module "ptReservations", ["ngResource"]


ptReservations.factory "Reservations", ($resource) ->
  $resource "/reservations/:id", {}, update: method:'PUT'
  

ptReservations.directive "ptReservationTourists", ->
  template: """
    <div class="reservation-field-tourists">
      <div class="reservation-field-tourists-item" ng-repeat="tourist in tourists">
        <button class="big_button" ng-show="tourists.length > 1" ng-click="remove($index)">-</button>
        <div class="reservation-field reservation-field-sex">
          <input type="radio" pt-radio ng-model="tourist.gender" name="gender-{{ $index }}" value="male" checked/>
          <label>муж.</label>
          <input type="radio" pt-radio ng-model="tourist.gender" name="gender-{{ $index }}" value="female"/>
          <label>жен.</label>
        </div>
        
        <div class="reservation-field reservation-field-fio">
          <label>ФИО</label>
          <input type="text" ng-model="tourist.fio" required>
        </div>
        
        <div class="reservation-field reservation-field-birthday">
          <label>дата рождения</label>
          <input type="text" ng-model="tourist.birthday" pt-datepicker pt-datepicker-format="dd.mm.yy" pt-datepicker-trigger required>
        </div>
        
        <div class="reservation-field reservation-field-passport">
          <label>паспортные данные</label>

          <input type="text" ng-model="tourist.series" class="reservation-field-passport-series" placeholder="серия" required>
          <input type="text" ng-model="tourist.number" class="reservation-field-passport-number" placeholder="номер" required>
          <input type="text" ng-model="tourist.validity" class="reservation-field-passport-validity" placeholder="срок действия"  pt-datepicker pt-datepicker-format="dd.mm.yy" pt-datepicker-trigger required>
          <input type="text" ng-model="tourist.date" class="reservation-field-passport-date" placeholder="когда выдан"  pt-datepicker pt-datepicker-format="dd.mm.yy" pt-datepicker-trigger required>
          <input type="text" ng-model="tourist.who" class="reservation-field-passport-who" placeholder="кем выдан" required>
          <input type="text" ng-model="tourist.citizenship" class="reservation-field-passport-citizenship" placeholder="гражданство" required>
        </div>
      </div>
      <button class="big_button" ng-click="add()">+</button>
    </div>
  """

  restrict: "EACM"
  require: "ngModel"
  link: (scope, element, attrs, controller) ->
    scope.tourists = [
      birthday: new Date()
      validity: new Date()
      gender: "male"
      date: new Date()
    ]

    scope.add = ->
      scope.tourists.push
        birthday: new Date()
        validity: new Date()
        gender: "male"
        date: new Date()

    scope.remove = (remove) ->
      updated = []
      scope.tourists.forEach (tourist, index) ->
        updated.push tourist unless remove == index
      scope.tourists = updated

    scope.$watch "tourists", ->
      controller.$setViewValue scope.tourists
    , true
