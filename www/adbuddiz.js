var adbuddiz = {
    init: function(successCallback, errorCallback, publisherKey) {
        cordova.exec(
            successCallback,
            errorCallback,
            'AdBuddizPlugin',
            'init',
            [publisherKey]
        ); 
    },
    showFullScreenAd: function(successCallback, errorCallback) {
        cordova.exec(
            successCallback,
            errorCallback,
            'AdBuddizPlugin',
            'showFullScreenAd',
            []
        ); 
    }
}

module.exports = adbuddiz;
