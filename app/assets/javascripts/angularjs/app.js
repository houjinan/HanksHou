var myApp = angular.module('myApp', ['templates', "ngRoute", "ui.router", 'extNgResource', 'services']);

myApp.constant('templateRoot', "angularjs/templates/");

myApp.config(['$stateProvider', '$urlRouterProvider', 'templateRoot', function($stateProvider, $urlRouterProvider, templateRoot){
 
  var tmplUrl = function(relative_path){
    return templateRoot + relative_path;
  }
  $urlRouterProvider.otherwise("/articles");
  $stateProvider
    .state('articles',{
	    url: "/articles",
	    templateUrl: tmplUrl("articles/index.html"),
	 })
    .state('article_new',{
      url: "/articles/new",
      templateUrl: tmplUrl("articles/new.html"),
      controller: "ArticleNewController"
    })
    .state('article_edit',{
      url: "/articles/:id/edit",
      templateUrl: tmplUrl("articles/new.html"),
      controller: "ArticleEditController"
    })
    .state('article',{
    	url: "/articles/:id",
    	templateUrl: tmplUrl("articles/show.html"),
    })
    .state('users', {
    	url: "/users",
    	templateUrl: tmplUrl("users/index.html"),
    })

  }
]);

myApp.config(['$locationProvider', function($locationProvider) {
        $locationProvider.hashPrefix('');
    }]);
angular.module("services", []);
angular.module("extNgResource", []);


