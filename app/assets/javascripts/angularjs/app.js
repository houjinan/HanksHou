var myApp = angular.module('myApp', ['templates', "ngRoute", "ui.router"]);

myApp.constant('templateRoot', "angularjs/templates/");

myApp.config(['$stateProvider', '$urlRouterProvider', 'templateRoot', function($stateProvider, $urlRouterProvider, templateRoot){
 
  var tmplUrl = function(relative_path){
  	//console.log(templateRoot + relative_path);

    return templateRoot + relative_path;
  }

  $urlRouterProvider.otherwise("/articles");
  
  $stateProvider
    .state('articles',{
	    url: "/articles",
	    templateUrl: tmplUrl("articles/index.html"),
	    controller: "ArticlesController"
	 })
    .state('article',{
    	url: "/articles/:id",
    	templateUrl: tmplUrl("articles/show.html"),
    	controller: "ArticleController"
    })
    .state('users', {
    	url: "/users",
    	templateUrl: tmplUrl("users/index.html"),
    	controller: "UsersController"
    })

  }
]);

myApp.config(['$locationProvider', function($locationProvider) {
        $locationProvider.hashPrefix('');
    }]);
