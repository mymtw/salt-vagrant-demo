var app = angular.module('testApp', ['config']);

app.controller('GetBackendDataCtrl', function($scope, $http, APP) {
  $http
    .get(APP.API_HOST)
    .then(function(response) {
      $scope.values = response.data
      console.log('backend data ' + response.data.data)
    });
});
