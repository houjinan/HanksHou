myApp.controller("HeaderController", ['$scope', '$state', '$http', 'Article', function($scope, $state, $http, Article){
  $scope.linkArticle = function(type){
  }
}]);

myApp.controller("ArticlesController", ['$scope', '$state', '$http', 'Article', function($scope, $state, $http, Article){
  Article.article_list({}, function(result){
    $scope.articles = result.data
  }, function(error){
    $scope.articles = []
  });

  $scope.deleteArticle = function(id){
    if(confirm("确认删除？")){
      Article.delete({id: id}, function(result){
        location.reload();
      }, function(error){
      });
    }
  }
}]);

myApp.controller("ArticleController", ['$scope', '$state', '$stateParams', '$http', 'Article', function($scope, $state, $stateParams, $http, Article){
  Article.get({id: $state.params.id}, function(result){
    $scope.article = result
  }, function(error){
    $scope.article = []
  })
}]);


myApp.controller("ArticleNewController", ['$scope', '$state', '$http', 'Article', function($scope, $state, $http, Article){
  $scope.submitArticle = function(){
    if($scope.article["title"] == undefined){
      return
    }else{
      $scope.article.$create(function(data){
        $state.go("articles");
      },
      function(error){
      });
    }
  };
  $scope.article = new Article();
}]);

myApp.controller("ArticleEditController", ['$scope', '$state', '$http', 'Article', function($scope, $state, $http, Article){
  Article.get({id: $state.params.id}, function(result){
    $scope.article = result;
  }, function(error){
    $scope.article = new Article();
  })
  $scope.submitArticle = function(){
    $scope.article.$update(function(data){
      $state.go("articles");
    },
    function(error){
    });
  };
}]);