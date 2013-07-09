ptCKEditor = angular.module "ptCKEditor", []
ptCKEditor.factory "CKEditor", ($window) ->
  editor = $window["CKEDITOR"]
  editor.config.extraPlugins = "onchange"
  editor

ptCKEditor.directive "ptCkeditor", (CKEditor, $timeout) ->
  restrict: "EACM"
  require: "ngModel"
  link: (scope, element, attrs, controller) ->
    element.uniqueId()

    editor = CKEditor.replace element.attr "id"
    
    editor.on "blur", (e) ->
      controller.$setViewValue e.editor.getData()

    editor.on "change", (e) ->
      controller.$setViewValue e.editor.getData()

    editor.setData controller.$viewValue

    controller.$render = ->
      return unless controller.$viewValue
      setTimeout ->
        editor.setData controller.$viewValue
      , 300
