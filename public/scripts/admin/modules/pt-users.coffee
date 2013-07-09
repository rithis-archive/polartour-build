ptUsers = angular.module "ptUsers", ["ngResource", "ngCookies"]


ptUsers.directive "ptUser", (user) ->
  link: (scope) ->
    scope.currentUser = user


ptUsers.factory "user", ($resource, $http) ->
  setToken = (token) ->
    $http.defaults.headers.common.Authorization = "Token #{token}"

  if store.get("username")? and store.get("token")?
    promise = $http.get("/sessions/#{store.get "token"}")
    promise.success (data, status) ->
      setToken store.get "token" if status is 200
      store.remove "token" if status is 404

  isAuthenticated: ->
    store.get("token")?

  getUsername: ->
    store.get "username"

  logout: ->
    store.remove "username"
    store.remove "token"

  auth: (username, password, callback) ->
    body    = username: username, password: password
    promise = $http.post("/sessions", body)
    promise.success (auth, status) ->
      store.set "username", username
      store.set "token", auth.token if auth.token
      setToken auth.token
      callback(auth.token) if callback
