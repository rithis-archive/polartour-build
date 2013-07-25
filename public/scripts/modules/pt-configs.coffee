ptConfigs = angular.module "ptConfigs", ["ngResource"]


ptConfigs.factory "Configs", ($resource) ->
  $resource "/configs/:id", {}, update: method:'PUT'

ptConfigs.service "configs", (Configs) ->
  configs = {}

  load: ->
    Configs.query (data) ->
      data.forEach (item) ->
        configs[item.property] = item.value
  get: (property) ->
    configs[property]
    