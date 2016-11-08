var app = angular.module('testApp', []);

app.controller('GetBackendDataCtrl', function($scope, $http) {
  $http
    .get('http://127.0.0.1:8080/')
    .then(function(response) {
      $scope.values = response.data
    });
});

