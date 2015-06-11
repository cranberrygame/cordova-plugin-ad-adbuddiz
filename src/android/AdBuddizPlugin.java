//Copyright (c) 2014 Sang Ki Kwon (Cranberrygame)
//Email: cranberrygame@yahoo.com
//Homepage: http://cranberrygame.github.io
//License: MIT (http://opensource.org/licenses/MIT)
package com.cranberrygame.cordova.plugin.ad.adbuddiz;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.PluginResult;
import org.apache.cordova.CallbackContext;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONException;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaWebView;
import android.app.Activity;
import android.util.Log;
//
import com.purplebrain.adbuddiz.sdk.AdBuddiz;
import com.purplebrain.adbuddiz.sdk.AdBuddizDelegate;
import com.purplebrain.adbuddiz.sdk.AdBuddizError;
//md5
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
//Util
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.view.Surface;
//
import java.util.*;//Random

class Util {

	//ex) Util.alert(cordova.getActivity(),"message");
	public static void alert(Activity activity, String message) {
		AlertDialog ad = new AlertDialog.Builder(activity).create();  
		ad.setCancelable(false); // This blocks the 'BACK' button  
		ad.setMessage(message);  
		ad.setButton("OK", new DialogInterface.OnClickListener() {  
			@Override  
			public void onClick(DialogInterface dialog, int which) {  
				dialog.dismiss();                      
			}  
		});  
		ad.show(); 		
	}
	
	//https://gitshell.com/lvxudong/A530_packages_app_Camera/blob/master/src/com/android/camera/Util.java
	public static int getDisplayRotation(Activity activity) {
	    int rotation = activity.getWindowManager().getDefaultDisplay()
	            .getRotation();
	    switch (rotation) {
	        case Surface.ROTATION_0: return 0;
	        case Surface.ROTATION_90: return 90;
	        case Surface.ROTATION_180: return 180;
	        case Surface.ROTATION_270: return 270;
	    }
	    return 0;
	}

	public static final String md5(final String s) {
        try {
            MessageDigest digest = java.security.MessageDigest.getInstance("MD5");
            digest.update(s.getBytes());
            byte messageDigest[] = digest.digest();
            StringBuffer hexString = new StringBuffer();
            for (int i = 0; i < messageDigest.length; i++) {
                String h = Integer.toHexString(0xFF & messageDigest[i]);
                while (h.length() < 2)
                    h = "0" + h;
                hexString.append(h);
            }
            return hexString.toString();

        } catch (NoSuchAlgorithmException e) {
        }
        return "";
    }
}

public class AdBuddizPlugin extends CordovaPlugin {
	private static final String LOG_TAG = "AdBuddizPlugin";
	private CallbackContext callbackContextKeepCallback;
	//
	protected String email;
	protected String licenseKey;
	public boolean validLicenseKey;
	protected String TEST_PUBLISHER_KEY = "ef22dd80-0917-4ea0-82b6-acf79a96fe14";
	//
	protected String publisherKey;
	//
	private boolean fullScreenAdPreload;
 
    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
		super.initialize(cordova, webView);
    }

	//@Override
	//public void onCreate(Bundle savedInstanceState) {//build error
	//	super.onCreate(savedInstanceState);
	//	//
	//}
	
	//@Override
	//public void onStart() {//build error
	//	super.onStart();
	//	//
	//}
	
  	@Override
    public void onPause(boolean multitasking) {		
        super.onPause(multitasking);
		//
    }
      
    @Override
    public void onResume(boolean multitasking) {
        super.onResume(multitasking);
		//
    }
  	
	//@Override
	//public void onStop() {//build error
	//	super.onStop();
	//	//
	//}
	
    @Override
    public void onDestroy() {
        super.onDestroy();
		//
    }
	
	@Override
	public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {

		if (action.equals("setLicenseKey")) {
			setLicenseKey(action, args, callbackContext);

			return true;
		}	
		else if (action.equals("setUp")) {
			setUp(action, args, callbackContext);

			return true;
		}			
		else if (action.equals("preloadFullScreenAd")) {
			preloadFullScreenAd(action, args, callbackContext);
			
			return true;
		}
		else if (action.equals("showFullScreenAd")) {
			showFullScreenAd(action, args, callbackContext);
						
			return true;
		}
		
		return false; // Returning false results in a "MethodNotFound" error.
	}

	private void setLicenseKey(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
		final String email = args.getString(0);
		final String licenseKey = args.getString(1);				
		Log.d(LOG_TAG, String.format("%s", email));			
		Log.d(LOG_TAG, String.format("%s", licenseKey));
		
		cordova.getActivity().runOnUiThread(new Runnable() {
			@Override
			public void run() {
				_setLicenseKey(email, licenseKey);
			}
		});
	}
	
	private void setUp(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
		//Activity activity=cordova.getActivity();
		//webView
		//args.length()
		//args.getString(0)
		//args.getString(1)
		//args.getInt(0)
		//args.getInt(1)
		//args.getBoolean(0)
		//args.getBoolean(1)
		//JSONObject json = args.optJSONObject(0);
		//json.optString("adUnitBanner")
		//json.optString("adUnitFullScreen")
		//JSONObject inJson = json.optJSONObject("inJson");
		//final String adUnitBanner = args.getString(0);
		//final String adUnitFullScreen = args.getString(1);				
		//final boolean isOverlap = args.getBoolean(2);				
		//final boolean isTest = args.getBoolean(3);
		//final String[] zoneIds = new String[args.getJSONArray(4).length()];
		//for (int i = 0; i < args.getJSONArray(4).length(); i++) {
		//	zoneIds[i] = args.getJSONArray(4).getString(i);
		//}			
		//Log.d(LOG_TAG, String.format("%s", adUnitBanner));			
		//Log.d(LOG_TAG, String.format("%s", adUnitFullScreen));
		//Log.d(LOG_TAG, String.format("%b", isOverlap));
		//Log.d(LOG_TAG, String.format("%b", isTest));
		final String publisherKey = args.getString(0);
		Log.d(LOG_TAG, String.format("%s", publisherKey));			
		
		callbackContextKeepCallback = callbackContext;
			
		cordova.getActivity().runOnUiThread(new Runnable() {
			@Override
			public void run() {
				_setUp(publisherKey);
			}
		});
	}
	
	private void preloadFullScreenAd(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
		cordova.getActivity().runOnUiThread(new Runnable(){
			@Override
			public void run() {
				_preloadFullScreenAd();
			}
		});
	}

	private void showFullScreenAd(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
		cordova.getActivity().runOnUiThread(new Runnable(){
			@Override
			public void run() {
				_showFullScreenAd();
			}
		});
	}

	public void _setLicenseKey(String email, String licenseKey) {
		this.email = email;
		this.licenseKey = licenseKey;
		
		//
		String str1 = Util.md5("com.cranberrygame.cordova.plugin.: " + email);
		String str2 = Util.md5("com.cranberrygame.cordova.plugin.ad.adbuddiz: " + email);
		if(licenseKey != null && (licenseKey.equalsIgnoreCase(str1) || licenseKey.equalsIgnoreCase(str2))) {
			this.validLicenseKey = true;
			//
			String[] excludedLicenseKeys = {"xxx"};
			for (int i = 0 ; i < excludedLicenseKeys.length ; i++) {
				if (excludedLicenseKeys[i].equals(licenseKey)) {
					this.validLicenseKey = false;
					break;
				}
			}			
			if (this.validLicenseKey)
				Log.d(LOG_TAG, String.format("%s", "valid licenseKey"));
			else
				Log.d(LOG_TAG, String.format("%s", "invalid licenseKey"));
		}
		else {
			Log.d(LOG_TAG, String.format("%s", "invalid licenseKey"));
			this.validLicenseKey = false;			
		}
		//if (!this.validLicenseKey)
		//	Util.alert(cordova.getActivity(),"Cordova AdBuddiz: invalid email / license key. You can get free license key from https://play.google.com/store/apps/details?id=com.cranberrygame.pluginsforcordova");					
	}
	
	private void _setUp(String publisherKey) {
		this.publisherKey = publisherKey;
	
		if (!validLicenseKey) {
			if (new Random().nextInt(100) <= 1) {//0~99					
				this.publisherKey = TEST_PUBLISHER_KEY;
			}
		}
		
		AdBuddiz.setPublisherKey(this.publisherKey);
		AdBuddiz.setDelegate(new MyAdBuddizDelegate());		
	}

	private void _preloadFullScreenAd() {
		fullScreenAdPreload = true;
		
		AdBuddiz.cacheAds(this.cordova.getActivity());
	}

	private void _showFullScreenAd() {
		fullScreenAdPreload = false;		

		AdBuddiz.showAd(this.cordova.getActivity());					
	}
	
	class MyAdBuddizDelegate implements AdBuddizDelegate {
		public MyAdBuddizDelegate() {
		}
		public void didCacheAd() {
			Log.d(LOG_TAG, "didCacheAd");
		
			if (fullScreenAdPreload) {
				PluginResult pr = new PluginResult(PluginResult.Status.OK, "onFullScreenAdPreloaded");
				pr.setKeepCallback(true);
				callbackContextKeepCallback.sendPluginResult(pr);
				//PluginResult pr = new PluginResult(PluginResult.Status.ERROR);
				//pr.setKeepCallback(true);
				//callbackContextKeepCallback.sendPluginResult(pr);		
			}
			
			PluginResult pr = new PluginResult(PluginResult.Status.OK, "onFullScreenAdLoaded");
			pr.setKeepCallback(true);
			callbackContextKeepCallback.sendPluginResult(pr);
			//PluginResult pr = new PluginResult(PluginResult.Status.ERROR);
			//pr.setKeepCallback(true);
			//callbackContextKeepCallback.sendPluginResult(pr);
		}
		public void didShowAd() {
			Log.d(LOG_TAG, "didShowAd");
			
			PluginResult pr = new PluginResult(PluginResult.Status.OK, "onFullScreenAdShown");
			pr.setKeepCallback(true);
			callbackContextKeepCallback.sendPluginResult(pr);
			//PluginResult pr = new PluginResult(PluginResult.Status.ERROR);
			//pr.setKeepCallback(true);
			//callbackContextKeepCallback.sendPluginResult(pr);		
		}
		public void didFailToShowAd(AdBuddizError error) {
			Log.d(LOG_TAG, "didFailToShowAd");
		}
		public void didClick() {
			Log.d(LOG_TAG, "didClick");
		}
		public void didHideAd() {
			Log.d(LOG_TAG, "didHideAd");
			
			PluginResult pr = new PluginResult(PluginResult.Status.OK, "onFullScreenAdHidden");
			pr.setKeepCallback(true);
			callbackContextKeepCallback.sendPluginResult(pr);
			//PluginResult pr = new PluginResult(PluginResult.Status.ERROR);
			//pr.setKeepCallback(true);
			//callbackContextKeepCallback.sendPluginResult(pr);	
		}
	}	
}
