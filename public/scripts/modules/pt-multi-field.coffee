ptMultiField = angular.module "ptMultiField", []


ptMultiField.directive "ptMultiField", ->
  template: """
    <div class="multi-field">
      <div class="multi-field-item" ng-repeat="field in fields">
        <input ng-model="field.value" required>
        <button class="big_button" ng-click="remove($index)" ng-show="fields.length > ptMultiFieldMin">-</button>
      </div>
      <button class="big_button" ng-click="add()" ng-show="fields.length < ptMultiFieldLimit">+</button>
    </div>
  """

  restrict: "EACM"
  require: "ngModel"
  link: (scope, element, attrs, controller) ->
    scope.fields = []

    if attrs.ptMultiFieldLimit
      scope.ptMultiFieldLimit = Number attrs.ptMultiFieldLimit
    else
      scope.ptMultiFieldLimit = 100

    if attrs.ptMultiFieldMin
      scope.ptMultiFieldMin = Number attrs.ptMultiFieldMin
    else
      scope.ptMultiFieldMin = 0

    controller.$formatters.push (values) ->
      fields = []
      if values
        values.forEach (value) ->
          fields.push value: value

      if fields.length < scope.ptMultiFieldMin
        for i in [0...scope.ptMultiFieldMin-fields.length]
          fields.push value: ""

      scope.fields = fields
      values

    scope.add = ->
      scope.fields.push value: ""

    scope.remove = (remove) ->
      scope.fields.splice remove, 1
      # updated = []
      # scope.fields.forEach (field, index) ->
      #   updated.push field unless remove == index
      # scope.fields = updated

    scope.$watch "fields", ->
      values = []
      scope.fields.forEach (field) ->
        values.push field.value
      controller.$setViewValue values
    , true
