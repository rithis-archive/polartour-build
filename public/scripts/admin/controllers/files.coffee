polartourAdmin.controller "FilesCtrl", ($scope, Files, configs) ->
  $scope.data = $scope.queue = Files.query()
  configs.load()

  $scope.options =
    autoUpload: true,
    url: "/files"

  clipButton = $ "#clipButton"
  $scope.showProgress = false

  ZeroClipboard.setDefaults moviePath: "/components/zeroclipboard/ZeroClipboard.swf"
  clip = new ZeroClipboard $ "#clipButton"
  clip.on "complete", ->
    $scope.showProgress = false
    $scope.$apply()

  $scope.$on "fileuploaddone", (e, data) ->
    $scope.data = $scope.queue
    files = data.response().result.files
    return unless files or files[0]
    host = configs.get("domain") or location.origin
    $scope.clipboardText = "#{host}/#{files[0].path}"

  $scope.$on "fileuploadadd", ->
    $scope.showProgress = true

  timeout = false
  initDragOver = false
  $scope.$on "fileuploaddragover", ->
    unless initDragOver
      $(".files-drag-over").height $(document).height()
      initDragOver = true
    clearTimeout timeout if timeout
    $scope.dragOver = true
    $scope.$apply()
    timeout = setTimeout ->
      $scope.dragOver = false
      $scope.$apply()
    , 300
