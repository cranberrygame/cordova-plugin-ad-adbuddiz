
var adbuddiz = {
	_isShowingFullScreenAd: false,
	//
	setLicenseKey: function(email, licenseKey) {
		var self = this;	
        cordova.exec(
            null,
            null,
            'AdBuddizPlugin',
            'setLicenseKey',			
            [email, licenseKey]
        ); 
    },
	setUp: function(publisherKey) {
		var self = this;	
        cordova.exec(
			function (result) {
				console.log('setUp succeeded.');
				
				if (typeof result == "string") {
					if (result == "onFullScreenAdPreloaded") {
						if (self.onFullScreenAdPreloaded)
							self.onFullScreenAdPreloaded();
					}
					else if (result == "onFullScreenAdLoaded") {
						if (self.onFullScreenAdLoaded)
							self.onFullScreenAdLoaded();
					}
					else if (result == "onFullScreenAdShown") {
						self._isShowingFullScreenAd = true;
						if (self.onFullScreenAdShown)
							self.onFullScreenAdShown();
					}
					else if (result == "onFullScreenAdHidden") {
						self._isShowingFullScreenAd = false;
						if (self.onFullScreenAdHidden)
							self.onFullScreenAdHidden();
					}
				}
				else {
					//if (result["event"] == "onXXX") {
					//	//result["message"]
					//	if (self.onXXX)
					//		self.onXXX(result);
					//}
				}
			},
			function (error) {
				console.log('setUp failed.');
			},
            'AdBuddizPlugin',
            'setUp',			
			[publisherKey]
        ); 
    },
    preloadFullScreenAd: function() {
        cordova.exec(
			null,
            null,
            'AdBuddizPlugin',
            'preloadFullScreenAd',
            []
        ); 
    },
    showFullScreenAd: function() {
        cordova.exec(
			null,
            null,
            'AdBuddizPlugin',
            'showFullScreenAd',
            []
        ); 
    },
	isShowingFullScreenAd: function() {
		return this._isShowingFullScreenAd;
	},
	onFullScreenAdPreloaded: null,
	onFullScreenAdLoaded: null,
	onFullScreenAdShown: null,
	onFullScreenAdHidden: null
}

module.exports = adbuddiz;
