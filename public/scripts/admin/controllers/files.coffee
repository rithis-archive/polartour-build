polartourAdmin.controller "FilesCtrl", ($scope, Files) ->
  $scope.data = $scope.queue = Files.query()
  
  $scope.options =
    autoUpload: true,
    url: "/files"

  clipWrapper = $ "#clipWrapper"
  clipWrapper.css
    display: "none"
    position: "absolute"
    top: "0px"
    left: "0px"
    width: "100%"

  ZeroClipboard.setDefaults moviePath: "/components/zeroclipboard/ZeroClipboard.swf"
  clip = new ZeroClipboard $ "#clipWrapper"
  clip.on "complete", ->
    clipWrapper.hide()
    $("#global-zeroclipboard-html-bridge").hide()
  
  $scope.$on "fileuploaddone", (e, data) ->
    $scope.data = $scope.queue
    files = data.response().result.files
    return unless files or files[0]
    $scope.clipboardText = files[0].path
    clipWrapper.css height: $(document).height()
    clipWrapper.show()
    $("#global-zeroclipboard-html-bridge").show()
