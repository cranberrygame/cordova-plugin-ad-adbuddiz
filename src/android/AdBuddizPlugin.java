package com.cranberrygame.plugin.ad.adbuddiz;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONObject;
import org.json.JSONArray;
import org.json.JSONException;
import android.app.Activity;
//
import com.purplebrain.adbuddiz.sdk.AdBuddiz;
import com.purplebrain.adbuddiz.sdk.AdBuddizDelegate;
import com.purplebrain.adbuddiz.sdk.AdBuddizError;

public class AdBuddizPlugin extends CordovaPlugin {
   
    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        try {
            if (action.equals("init")) {		
				AdBuddiz.setPublisherKey(args.getString(0));		
				AdBuddiz.cacheAds(this.cordova.getActivity());
				
				callbackContext.success();
				return true;
            }		
            else if (action.equals("showFullScreenAd")) {
                if (AdBuddiz.isReadyToShowAd(this.cordova.getActivity())) {
				
					//AdBuddiz.setDelegate(new MyAdBuddizDelegate());				
                    AdBuddiz.showAd(this.cordova.getActivity());
					
                    callbackContext.success();
                    return true;
                }
                else {
                    callbackContext.error("showFullScreenAd failed");
                    return false;
                }
            }
 
            callbackContext.error("Invalid action: " + action);
            return false;
        } catch(Exception e) {
            callbackContext.error(e.getMessage());
            return false;
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
