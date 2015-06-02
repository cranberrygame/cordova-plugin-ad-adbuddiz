Cordova AdBuddiz plugin
====================
# Overview #
Show adbuddiz full screen ad

[android, ios] [cordova cli] [xdk]

Requires adbuddiz account https://www.adbuddiz.com

adbuddiz android SDK 2.4.6
adbuddiz ios SDK 2.4.6

This is open source cordova plugin.

You can see Plugins For Cordova in one page: http://cranberrygame.github.io?referrer=github

# Change log #
```c
```
# Install plugin #

## Cordova cli ##
https://cordova.apache.org/docs/en/edge/guide_cli_index.md.html#The%20Command-Line%20Interface - npm install -g cordova@4.1.2
```c
cordova plugin add com.cranberrygame.cordova.plugin.ad.adbuddiz
```

## Xdk ##
https://software.intel.com/en-us/intel-xdk - Download XDK - XDK PORJECTS - [specific project] - CORDOVA 3.X HYBRID MOBILE APP SETTINGS - PLUGINS - Third Party Plugins - Add a Third Party Plugin - Get Plugin from the Web -
```c
Name: adbuddiz
Plugin ID: com.cranberrygame.cordova.plugin.ad.adbuddiz
[v] Plugin is located in the Apache Cordova Plugins Registry
```

## Cocoon ##
https://cocoon.io - Create project - [specific project] - Setting - Plugins - Search - cranberrygame - adbuddiz - Save

## Phonegap build service (config.xml) ##
https://build.phonegap.com/ - Apps - [specific project] - Update code - Zip file including config.xml
```c
<gap:plugin name="com.cranberrygame.cordova.plugin.ad.adbuddiz" source="plugins.cordova.io" />
```

## Construct2 ##
Download construct2 plugin: http://www.paywithapost.de/pay?id=4ef3f2be-26e8-4a04-b826-6680db13a8c8
<br>
Now all the native plugins are installed automatically: https://plus.google.com/102658703990850475314/posts/XS5jjEApJYV
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

window.adbuddiz.preloadFullScreenAd();//option, download ad previously for fast show
window.adbuddiz.showFullScreenAd();

alert(window.adbuddiz.loadedFullScreenAd());//boolean: true or false

alert(window.adbuddiz.isShowingFullScreenAd());//boolean: true or false

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

