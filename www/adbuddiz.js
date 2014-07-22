var adbuddiz = {
    preloadFullScreenAd: function(publisherKey, successCallback, errorCallback) {
        cordova.exec(
            successCallback,
            errorCallback,
            'AdBuddizPlugin',
            'preloadFullScreenAd',
            [publisherKey]
        ); 
    },
    showFullScreenAd: function(publisherKey, successCallback, errorCallback) {
        cordova.exec(
            successCallback,
            errorCallback,
            'AdBuddizPlugin',
            'showFullScreenAd',
            [publisherKey]
        ); 
    }
}

module.exports = adbuddiz;
