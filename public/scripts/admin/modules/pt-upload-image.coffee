ptUploadImage = angular.module "ptUploadImage", ["ngResource"]

ptUploadImage.directive "ptUploadImage", ->
  restrict: "EACM"
  require: "ngModel"
  link: (scope, element, attributes, controller) ->
    fileupload = $("<input type=\"file\">").fileupload
      url: "/uploads"
      paramName: "file"

    fileupload.on "fileuploaddone", (event, data) ->
      controller.$setViewValue data.jqXHR.getResponseHeader "Location"
      scope.$apply()

    scope.upload = ->
      fileupload.click()
