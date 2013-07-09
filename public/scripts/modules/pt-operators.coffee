ptOperators = angular.module "ptOperators", []


ptOperators.directive "ptOperators", ($timeout) ->
  link: (scope, element, attributes) ->
    scope.operators = [
      "TezTour"
      "Pegas Touristik"
    ]

    trigger = """
      <div class="search-operator-trigger">
        <span class="search-operator-trigger-mask"></span>
        <div>
          <b></b>
        </div>
      </div>
    """

    $timeout ->
      choices = element.prev().find(".select2-choices")
      choices.children().each (index, choice) ->
        $(choice).on "click", ->
          element.select2 "open"

      choices.before trigger

    element.on "change", (e) ->
      $timeout ->
        select = $(element).prev()
        choices = select.find(".select2-choices")
  
        width = 0
        choices.children().each (index, choice) ->
          width += $(choice).outerWidth()
  
        if width > select.width()
          choices.width width * 1.1
        
        unless choices.prev().length
          choices.before trigger
