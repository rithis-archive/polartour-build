ptModal = angular.module "ptModal", []

ptModal.directive "ptModal", ->
  closeElement = angular.element """
    <a href="#" class="modal-close"></a>
  """
  
  wrapperElement = angular.element """
    <div class='modal-wrapper'></div>
  """

  restrict: "A"
  link: (scope, element, attrs) ->
    wrapper = wrapperElement.clone()
    close = closeElement.clone()
    element.addClass "modal"
    element.children().wrap wrapper
    element.children().first().append close
    
    close.on "click", (e) ->
      return unless attrs.ptModalShow
      e.preventDefault()
      scope[attrs.ptModalShow] = false
      scope.$apply()

    scope.$watch attrs.ptModalShow, (newVal) ->
      if newVal
        element.show()
      else
        element.hide()
