
var adbuddiz = {
	_loadedInterstitialAd: false,
	_loadedRewardedVideoAd: false,	
	_isShowingInterstitialAd: false,
	_isShowingRewardedVideoAd: false,	
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
					//
					else if (result == "onRewardedVideoAdPreloaded") {
						if (self.onRewardedVideoAdPreloaded)
							self.onRewardedVideoAdPreloaded();
					}
					else if (result == "onRewardedVideoAdLoaded") {
						self._loadedRewardedVideoAd = true;

						if (self.onRewardedVideoAdLoaded)
							self.onRewardedVideoAdLoaded();
					}
					else if (result == "onRewardedVideoAdShown") {
						self._loadedRewardedVideoAd = false;
						self._isShowingRewardedVideoAd = true;
					
						if (self.onRewardedVideoAdShown)
							self.onRewardedVideoAdShown();
					}
					else if (result == "onRewardedVideoAdHidden") {
						self._isShowingRewardedVideoAd = false;
					
						 if (self.onRewardedVideoAdHidden)
							self.onRewardedVideoAdHidden();
					}
					else if (result == "onRewardedVideoAdCompleted") {
						if (self.onRewardedVideoAdCompleted)
							self.onRewardedVideoAdCompleted();
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
	preloadRewardedVideoAd: function(location) {
        cordova.exec(
			null,
            null,
            'AdBuddizPlugin',
            'preloadRewardedVideoAd',
            [location]
        ); 
    },
    showRewardedVideoAd: function(location) {
		cordova.exec(
			null,
            null,
            'AdBuddizPlugin',
            'showRewardedVideoAd',
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
	loadedRewardedVideoAd: function() {
		return this._loadedRewardedVideoAd;
	},
	isShowingRewardedVideoAd: function() {
		return this._isShowingRewardedVideoAd;
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
	onInterstitialAdHidden: null,
	//
	onRewardedVideoAdPreloaded: null,
	onRewardedVideoAdLoaded: null,
	onRewardedVideoAdShown: null,
	onRewardedVideoAdHidden: null,
	onRewardedVideoAdCompleted: null	
}

module.exports = adbuddiz;
