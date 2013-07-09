ptCountField = angular.module "ptCountField", []


ptCountField.directive "ptCountField", ->
  template: """
    <a class="count-field-less-button" ng-click="less()"></a>
    <input  class="count-field-input" type="text" ng-model="value" value="{{ value }}">
    <a class="count-field-more-button" ng-click="more()"></a></div>
  """

  restrict: "EACM"
  require: "ngModel"
  link: (scope, element, attrs, controller) ->
    scope.less = ->
      scope.value--

    scope.more = ->
      scope.value++

    scope.$watch attrs.ngModel, (newVal) ->
      scope.value = parseInt newVal
