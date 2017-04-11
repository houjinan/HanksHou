myApp.controller("ArticlesController", ['$scope', '$http', function($scope, $http){
	$http({
    method: "GET",
    url: "articles.json"
  }).then(function(response){
    $scope.articles = response.data;
  }, function(error){
    console.log("error .....");
  });
}]);

myApp.controller("ArticleController", ['$scope', '$state', '$http', function($scope, $state, $http){
  //Artilce.get({id: $state.params.id}
  $http({
    method: "GET",
    url: "articles/" +$state.params.id+ ".json"
  }).then(function(response){
    $scope.article = response.data;
  }, function(error){
    console.log("error .....");
  });
}]);