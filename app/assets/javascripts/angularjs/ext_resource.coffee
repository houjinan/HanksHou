angular.module('extNgResource', ['ngResource']).factory('BaseResource',
  ['$resource', ($resource)->
    (url, paramDefaults, actions, options) ->
      extActions = {
        query:  {method:'GET', isArray: false},
        update: { method: 'PUT', headers: { 'Content-Type': 'application/json' }, isArray: false },
        #update1: {method: 'PATCH', headers: { 'Content-Type': 'application/json' }},
        create: { method: 'POST' }
      }
      actions = angular.extend(extActions, actions)
      if !paramDefaults
        paramDefaults = {}
      if !paramDefaults.format
        paramDefaults.format = 'json' #  The api data format is json
      resource = $resource(url, paramDefaults, actions, options)
      resource.prototype.defaultErrorHandler = ->
        alert("There was a server error, please reload the page and try again.")

      resource.prototype.$save = (cb1, cb2)->
        if !this.id
          this.$create(cb1, cb2)
        else
          this.$update(cb1, cb2)
      resource.save = (obj, cb1, cb2)->
        if !obj.id
          this.create(obj, cb1, cb2)
        else
          this.update(obj,cb1, cb2)
      resource
])