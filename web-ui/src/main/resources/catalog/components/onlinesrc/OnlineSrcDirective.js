(function() {
  goog.provide('gn_onlinesrc_directive');

  goog.require('gn_utility');

  angular.module('gn_onlinesrc_directive', [
    'gn_utility'
  ])
  .directive('gnAddOnlinesrc', ['gnOnlinesrc',
        function(gnOnlinesrc) {
          return {
            restrict: 'A',
            templateUrl: '../../catalog/components/onlinesrc/' +
                'partials/addOnlinesrc.html',
            scope: {},
            link: function(scope, element, attrs) {
              scope.mode = 'url';
              scope.params = {};
              scope.onlinesrcService = gnOnlinesrc;
            }
          };
        }])
  .directive('gnLinkParentMd', ['gnOnlinesrc',
        function(gnOnlinesrc) {
          return {
            restrict: 'A',
            templateUrl: '../../catalog/components/onlinesrc/' +
                'partials/linkParentMd.html',
            link: function(scope, element, attrs) {
              scope.onlinesrcService = gnOnlinesrc;
            }
          };
        }]);
  //  .config(['gnOnlinesrc',
  //        function(gnOnlinesrc) {
  //
  //  }]);
})();