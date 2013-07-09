ptEmployees = angular.module "ptEmployees", []


ptEmployees.directive "ptEmployees", ->
  restrict: "EACM"
  template: """
    <div class="multiple-field" ng-repeat="employe in contact.employees">
      <div class="multiple-field-wrapper">
        <div class="content-detail-field">
          <label>имя</label>
          <input type="text" ng-model="employe.name" />
        </div>
        <div class="content-detail-field">
          <label>фамилия</label>
          <input type="text" ng-model="employe.lastname" />
        </div>
        <div class="content-detail-field">
          <label>обязанности</label>
          <input type="text" ng-model="employe.responsibilities" />
        </div>
        <div class="content-detail-field">
          <label>телефон</label>
          <input type="text" ng-model="employe.phone" />
        </div>
        <div class="content-detail-field employe-emails-field">
          <label>email</label>
          <div class="employe-emails-field-item" ng-repeat="email in employe.emails">
            <input type="text" ng-model="email.email" placeholder="адрес" />
            <input type="text" ng-model="email.comment" placeholder="описание" />
            <button class="big_button employe-emails-field-remove" ng-click="removeEmail(employe, email)">-</button>
          </div>
          <button class="big_button employe-emails-field-add" ng-click="addEmail(employe)">+</button>
        </div>
      </div>
      <button class="big_button multiple-field-remove" ng-click="removeEmploye(employe)">-</button>
    </div>
    <div>
      <button class="big_button multiple-field-add" ng-click="addEmploye()">+</button>
    </div>
  """
  
  link: (scope, element, attrs) ->
    unless scope.contact.employees
      scope.contact.employees = [
        name: ""
        last: ""
        responsibilities: ""
        phone: ""
      ]

    scope.addEmploye = ->
      scope.contact.employees.push
        name: ""
        last: ""
        responsibilities: ""
        phone: ""

    scope.removeEmploye = (employe) ->
      updated = []
      scope.contact.employees.forEach (item) ->
        updated.push item unless employe == item
      scope.contact.employees = updated

    scope.removeEmail = (employe, email) ->
      scope.contact.employees.forEach (item) ->
        if item == employe
          updated = []
          item.emails.forEach (emailItem) ->
            updated.push emailItem unless email == emailItem
          employe.emails = updated

    scope.addEmail = (employe) ->
      scope.contact.employees.forEach (item) ->
        if item == employe
          employe.emails ?= []
          employe.emails.push {}

    

