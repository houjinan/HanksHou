//var myApp = angular.module("myApp", [])

myApp.factory("articleService", ['$http', function($http){
  return {
    article_list: function(){
      $http({
        method: "GET",
        url: "articles.json"
      }).then(function(response){
        return response.data;
      }, function(error){
        console.log("error .....");
        return [];
      });
    }
    ,
    article: function(id){
      $http({
        method: "GET",
        url: "articles/" +$state.params.id+ ".json"
      }).then(function(response){
        return response.data;
      }, function(error){
        console.log("error .....");
        console.log(error);
        return {};
      });
    }
  }
}]);