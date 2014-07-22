package com.cranberrygame.plugin.ad.adbuddiz;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.PluginResult;
import org.apache.cordova.CallbackContext;
import org.json.JSONArray;
import org.json.JSONException;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaWebView;
import android.app.Activity;
import android.util.Log;
//
import com.purplebrain.adbuddiz.sdk.AdBuddiz;
import com.purplebrain.adbuddiz.sdk.AdBuddizDelegate;
import com.purplebrain.adbuddiz.sdk.AdBuddizError;

public class AdBuddizPlugin extends CordovaPlugin {
	private boolean preloaded;
   
    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        try {
            if (action.equals("preloadFullScreenAd")) {
				//Activity activity=cordova.getActivity();
				//webView
				//
				final String publisherKey = args.getString(0);				
				Log.d("AdBuddiz", publisherKey);
						
				final CallbackContext delayedCB = callbackContext;		
				cordova.getActivity().runOnUiThread(new Runnable(){
		            @Override
		            public void run() {						
						_preloadFullScreenAd(publisherKey);

						delayedCB.sendPluginResult(new PluginResult(PluginResult.Status.OK));				
						//delayedCB.sendPluginResult(new PluginResult(PluginResult.Status.ERROR));
		            }
		        });

				return true;				
            }		
            else if (action.equals("showFullScreenAd")) {
				//Activity activity=cordova.getActivity();
				//webView
				//
				final String publisherKey = args.getString(0);				
				Log.d("AdBuddiz", publisherKey);
						
				final CallbackContext delayedCB = callbackContext;		
				cordova.getActivity().runOnUiThread(new Runnable(){
		            @Override
		            public void run() {						
						_showFullScreenAd(publisherKey);

						delayedCB.sendPluginResult(new PluginResult(PluginResult.Status.OK));				
						//delayedCB.sendPluginResult(new PluginResult(PluginResult.Status.ERROR));
		            }
		        });

				return true;				
            } 
		}
		catch (JSONException e) {
		}
		
		callbackContext.sendPluginResult(new PluginResult(PluginResult.Status.ERROR));
		
		return false;
    }
	
	//-------------------------------------
	private void _preloadFullScreenAd(String publisherKey){
		if (!preloaded) {
			AdBuddiz.setPublisherKey(publisherKey);		
			AdBuddiz.cacheAds(this.cordova.getActivity());
			preloaded = true;
		}		
	}	
	private void _showFullScreenAd(String publisherKey){
		if (!preloaded) {
			_preloadFullScreenAd(publisherKey);
		}
		
		if (AdBuddiz.isReadyToShowAd(this.cordova.getActivity())) {				
			//AdBuddiz.setDelegate(new MyAdBuddizDelegate());				
			AdBuddiz.showAd(this.cordova.getActivity());					
		}
	}	
}

class MyAdBuddizDelegate implements AdBuddizDelegate {
    public MyAdBuddizDelegate() {
    }
    public void didCacheAd() {
    }
    public void didShowAd() {
    }
    public void didFailToShowAd(AdBuddizError error) {
    }
    public void didClick() {
    }
    public void didHideAd() {
    }
}
