Cordova AdBuddiz plugin
====================
# Overview #
Show adbuddiz interstitial ad

[android, ios] [cordova cli] [xdk] [cocoon] [phonegap build service]

Requires adbuddiz account https://www.adbuddiz.com

adbuddiz android SDK 3.0.9
adbuddiz ios SDK 2.5.6

This is open source cordova plugin.

You can see Plugins For Cordova in one page: http://cranberrygame.github.io?referrer=github

# Change log #
```c
```
# Install plugin #

## Cordova cli ##
https://cordova.apache.org/docs/en/edge/guide_cli_index.md.html#The%20Command-Line%20Interface - npm install -g cordova@5.0.0
```c
cordova plugin add cordova-plugin-ad-adbuddiz
(when build error, use github url: cordova plugin add cordova plugin add https://github.com/cranberrygame/cordova-plugin-ad-adbuddiz)
```

## Xdk ##
https://software.intel.com/en-us/intel-xdk - Download XDK - XDK PORJECTS - [specific project] - CORDOVA HYBRID MOBILE APP SETTINGS - Plugins - Third Party Plugins - Add a Third Party Plugin - Get Plugin from the Web -
```c
Name: adbuddiz
Plugin ID: com.cranberrygame.cordova.plugin.ad.adbuddiz
[v] Plugin is located in the Apache Cordova Plugins Registry
```

## Cocoon ##
https://cocoon.io - Create project - [specific project] - Setting - Plugins - Custom - Git Url: https://github.com/cranberrygame/cordova-plugin-ad-adbuddiz.git - INSTALL - Save<br>

## Phonegap build service (config.xml) ##
https://build.phonegap.com/ - Apps - [specific project] - Update code - Zip file including config.xml
```c
<gap:plugin name="cordova-plugin-ad-adbuddiz" source="npm" />
```

## Construct2 ##
Download construct2 plugin<br>
https://dl.dropboxusercontent.com/u/186681453/pluginsforcordova/index.html<br>
How to install c2 native plugins in xdk, cocoon and cordova cli<br>
https://plus.google.com/102658703990850475314/posts/XS5jjEApJYV

# Server setting #

## android ##

<img src="https://raw.githubusercontent.com/cranberrygame/cordova-plugin-ad-adbuddiz/master/doc/publisher_key1.png"><br>
<img src="https://raw.githubusercontent.com/cranberrygame/cordova-plugin-ad-adbuddiz/master/doc/publisher_key2.png"><br>

```c
AdBuddiz - Apps - [specific app] - get Publisher Key:
```

## ios ##

```c
itunes - Manage Your Apps - [specific app] - get Apple ID

AdBuddiz - Apps - [specific app] - get Publisher Key
```

# API #
```javascript
var publisherKey = "REPLACE_THIS_WITH_YOUR_PUBLISHER_KEY";
/*
var publisherKey;
//android
if (navigator.userAgent.match(/Android/i)) {
	publisherKey = "REPLACE_THIS_WITH_YOUR_PUBLISHER_KEY";
}
//ios
else if (navigator.userAgent.match(/iPhone/i) || navigator.userAgent.match(/iPad/i)) {
	publisherKey = "REPLACE_THIS_WITH_YOUR_PUBLISHER_KEY";
}
*/

document.addEventListener("deviceready", function(){
	//if no license key, 2% ad traffic share for dev support.
	//you can get paid license key: https://cranberrygame.github.io/request_cordova_ad_plugin_paid_license_key
	//window.adbuddiz.setLicenseKey("yourEmailId@yourEmaildDamin.com", "yourLicenseKey");

	window.adbuddiz.setUp(publisherKey);
	
	window.adbuddiz.onInterstitialAdPreloaded = function() {
		alert('onInterstitialAdPreloaded');
	};
	window.adbuddiz.onInterstitialAdLoaded = function() {
		alert('onInterstitialAdLoaded');
	};
	window.adbuddiz.onInterstitialAdShown = function() {
		alert('onInterstitialAdShown');
	};
	window.adbuddiz.onInterstitialAdHidden = function() {
		alert('onInterstitialAdHidden');
	};
}, false);

window.adbuddiz.preloadInterstitialAd();//option, download ad previously for fast show
window.adbuddiz.showInterstitialAd();

alert(window.adbuddiz.loadedInterstitialAd());//boolean: true or false

alert(window.adbuddiz.isShowingInterstitialAd());//boolean: true or false

```
# Examples #
<a href="https://github.com/cranberrygame/cordova-plugin-ad-adbuddiz/blob/master/example/basic/index.html">example/basic/index.html</a><br>

# Test #

[![](http://img.youtube.com/vi/h4Mka-oJBpM/0.jpg)](https://www.youtube.com/watch?v=h4Mka-oJBpM&feature=youtu.be "Youtube")

You can also run following test apk.
https://dl.dropboxusercontent.com/u/186681453/pluginsforcordova/adbuddiz/apk.html

# Useful links #

Plugins For Cordova<br>
http://cranberrygame.github.io?referrer=github

# Credits #

