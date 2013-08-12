ptFiles = angular.module "ptFiles", []

ptFiles.factory "Files", ($resource) ->
  $resource "/files/:id", {}, update: method: "PUT"

ptFiles.directive "ptFileClipboard", ->
  restrict: "EACM"
  replace: true
  link: (scope, element) ->
    scope.host = location.origin

    ZeroClipboard.setDefaults moviePath: "/components/zeroclipboard/ZeroClipboard.swf"
    clip = new ZeroClipboard element
