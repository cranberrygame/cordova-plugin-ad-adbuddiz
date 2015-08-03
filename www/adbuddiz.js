
var adbuddiz = {
	_loadedInterstitialAd: false,
	_isShowingInterstitialAd: false,
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
					if (result == "onInterstitialAdPreloaded") {
//cranberrygame start; deprecated					
						if (self.onFullScreenAdPreloaded)
							self.onFullScreenAdPreloaded();
//cranberrygame end							
						if (self.onInterstitialAdPreloaded)
							self.onInterstitialAdPreloaded();
					}
					else if (result == "onInterstitialAdLoaded") {
						self._loadedInterstitialAd = true;
						
						
//cranberrygame start; deprecated
						if (self.onFullScreenAdLoaded)
							self.onFullScreenAdLoaded();
//cranberrygame end							
						if (self.onInterstitialAdLoaded)
							self.onInterstitialAdLoaded();
					}
					else if (result == "onInterstitialAdShown") {
						self._loadedInterstitialAd = false;					
						self._isShowingInterstitialAd = true;
						
//cranberrygame start; deprecated
						if (self.onFullScreenAdShown)
							self.onFullScreenAdShown();
//cranberrygame end							
						if (self.onInterstitialAdShown)
							self.onInterstitialAdShown();
					}
					else if (result == "onInterstitialAdHidden") {
						self._isShowingInterstitialAd = false;
						
//cranberrygame start; deprecated
						if (self.onFullScreenAdHidden)
							self.onFullScreenAdHidden();
//cranberrygame end							
						if (self.onInterstitialAdHidden)
							self.onInterstitialAdHidden();
					}
				}
				else {
					//var event = result["event"];
					//var location = result["message"];				
					//if (event == "onXXX") {
					//	if (self.onXXX)
					//		self.onXXX(location);
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
//cranberrygame start; deprecated	
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
//cranberrygame end
	preloadInterstitialAd: function() {
        cordova.exec(
			null,
            null,
            'AdBuddizPlugin',
            'preloadInterstitialAd',
            [location]
        ); 
    },
    showInterstitialAd: function() {
		cordova.exec(
 			null,
            null,
            'AdBuddizPlugin',
            'showInterstitialAd',
            [location]
        ); 
    },
//cranberrygame start; deprecated	
	loadedFullScreenAd: function() {
		return this._loadedInterstitialAd;
	},	
	isShowingFullScreenAd: function() {
		return this._isShowingInterstitialAd;
	},
//cranberrygame end
	loadedInterstitialAd: function() {
		return this._loadedInterstitialAd;
	},	
	isShowingInterstitialAd: function() {
		return this._isShowingInterstitialAd;
	},
//cranberrygame start; deprecated	
	onFullScreenAdPreloaded: null,
	onFullScreenAdLoaded: null,
	onFullScreenAdShown: null,
	onFullScreenAdHidden: null,
//cranberrygame end	
	onInterstitialAdPreloaded: null,
	onInterstitialAdLoaded: null,
	onInterstitialAdShown: null,
	onInterstitialAdHidden: null
}

module.exports = adbuddiz;
