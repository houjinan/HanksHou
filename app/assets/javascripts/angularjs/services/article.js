angular.module("services").factory("Article", ["BaseResource", function($resource){
  return $resource(
    "/api/v1/articles/:id", 
    {
      id: "@id", 
      auth_token: "8275179d1d7bac8222b12dd1f165921d"
    }, 
    {
      article_list: {method: 'get', url: '/api/v1/articles', isArray: false},
      delete: {method: 'delete', url: '/api/v1/articles/:id',  isArray: false}
    }
  )}
])