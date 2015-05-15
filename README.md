Cordova AdBuddiz plugin
====================
# Overview #
show adbuddiz full screen ad

[android, ios] [cordova cli] [xdk]

requires adbuddiz account https://www.adbuddiz.com

adbuddiz android SDK 2.4.6
adbuddiz ios SDK 2.4.6

this is open source cordova plugin.

# Change log #
```c
```
# Install plugin #

## Cordova cli ##
```c
cordova plugin add com.cranberrygame.cordova.plugin.ad.adbuddiz
```

## Xdk ##
```c
XDK PORJECTS - your_xdk_project - CORDOVA 3.X HYBRID MOBILE APP SETTINGS - PLUGINS AND PERMISSIONS - Third Party Plugins - Add a Third Party Plugin - Get Plugin from the Web -

Name: revmob
Plugin ID: com.cranberrygame.cordova.plugin.ad.adbuddiz
[v] Plugin is located in the Apache Cordova Plugins Registry
```

## Phonegap build service (config.xml) ##
```c
<gap:plugin name="com.cranberrygame.cordova.plugin.ad.adbuddiz" source="plugins.cordova.io" />
```

## Construct2 ##
Download construct2 plugin: https://dl.dropboxusercontent.com/u/186681453/pluginsforcordova/adbuddiz/construct2.html

# Server setting #
```c
```

<img src="https://github.com/cranberrygame/cordova-plugin-ad-adbuddiz/blob/master/doc/publisher_key1.png"><br>
<img src="https://github.com/cranberrygame/cordova-plugin-ad-adbuddiz/blob/master/doc/publisher_key2.png"><br>

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
	//you can get free license key from https://play.google.com/store/apps/details?id=com.cranberrygame.pluginsforcordova
	//window.adbuddiz.setLicenseKey("yourEmailId@yourEmaildDamin.com", "yourFreeLicenseKey");

	window.adbuddiz.setUp(publisherKey);
	
	//full screen ad callback
	window.adbuddiz.onFullScreenAdPreloaded = function() {
		alert('onFullScreenAdPreloaded');
	};
	window.adbuddiz.onFullScreenAdLoaded = function() {
		alert('onFullScreenAdLoaded');
	};
	window.adbuddiz.onFullScreenAdShown = function() {
		alert('onFullScreenAdShown');
	};
	window.adbuddiz.onFullScreenAdHidden = function() {
		alert('onFullScreenAdHidden');
	};
}, false);

window.adbuddiz.preloadFullScreenAd();
window.adbuddiz.showFullScreenAd();

alert(window.adbuddiz.isShowingFullScreenAd());//boolean: true or false

```
# Examples #
<a href="https://github.com/cranberrygame/cordova-plugin-ad-adbuddiz/blob/master/example/basic/index.html">example/basic/index.html</a><br>

# Test #

[![](http://img.youtube.com/vi/h4Mka-oJBpM/0.jpg)](https://www.youtube.com/watch?v=h4Mka-oJBpM&feature=youtu.be "Youtube")

You can also run following test apk.
https://dl.dropboxusercontent.com/u/186681453/pluginsforcordova/adbuddiz/CordovaApp-debug.apk

# Useful links #

Plugins For Cordova<br>
http://cranberrygame.github.io?referrer=github

# Credits #
