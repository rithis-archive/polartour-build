ptEditableSelect = angular.module "ptEditableSelect", []

ptEditableSelect.directive "ptEditableSelect", ->
  buttonElement = angular.element """
    <button class="big_button editable-select-button">+</button>
  """
  
  modalElement = angular.element """
    <div pt-modal>
      <div class="editable-select-element">
        <h2>Добавить новый элемент</h2>
        <input type="text">
        <button class="big_button">Добавить</button>
      </div>
    </div>
  """

  restrict: "EACM"
  compile: (tElem) ->
    modal = modalElement.clone()
    newVal = modal.find "input"
    add = modal.find "button"
    button = buttonElement.clone()
    tElem.addClass "editable-select"
    tElem.after button
    tElem.parent().after modal

    (scope, element, attrs) ->
      button.on "click", ->
        newVal.val ""
        modal.toggle()
        
      add.on "click", ->
        element.children().first().after "<option>#{newVal.val()}</option>"
        modal.toggle()
