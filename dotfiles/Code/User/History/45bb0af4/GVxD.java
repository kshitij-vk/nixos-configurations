/*
 * Copyright (C) 2020 The Pixel Experience Project
 *               2021-2024 crDroid Android Project
 *               2024 RisingOS Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.android.internal.util.crdroid;

import android.app.ActivityTaskManager;
import android.app.Application;
import android.app.TaskStackListener;
import android.content.ComponentName;
import android.content.Context;
import android.os.Environment;
import android.os.Binder;
import android.os.Build;
import android.os.Process;
import android.os.SystemProperties;
import android.util.Log;

import java.lang.reflect.Field;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

public class PixelPropsUtils {

    private static final String TAG = PixelPropsUtils.class.getSimpleName();
    private static final String PROP_HOOKS = "persist.sys.pihooks_";
    private static final boolean DEBUG = SystemProperties.getBoolean(PROP_HOOKS + "DEBUG", false);

    private static final String SPOOF_PIXEL_GMS = "persist.sys.pixelprops.gms";
    private static final String SPOOF_PIXEL_PI = "persist.sys.pixelprops.pi";
    private static final String SPOOF_PIXEL_GPHOTOS = "persist.sys.pixelprops.gphotos";
    private static final String SPOOF_PIXEL_NETFLIX = "persist.sys.pixelprops.netflix";
    private static final String ENABLE_GAME_PROP_OPTIONS = "persist.sys.gameprops.enabled";
    private static final String SPOOF_PIXEL_GOOGLE_APPS = "persist.sys.pixelprops.google";

    private static final Map<String, Object> propsToChangePixel9ProXL;
    private static final Map<String, Object> propsToChangePixelXL;
    private static final Map<String, Object> propsToChangePixel5a;

    private static final ComponentName GMS_ADD_ACCOUNT_ACTIVITY = ComponentName.unflattenFromString(
            "com.google.android.gms/.auth.uiflows.minutemaid.MinuteMaidActivity");

    private static final Map<String, String> DEFAULT_VALUES = Map.of(
        "BRAND", "google",
        "MANUFACTURER", "Google",
        "DEVICE", "comet",
        "FINGERPRINT", "google/comet_beta/comet:15/BP11.241121.013/12873528:user/release-keys",
        "MODEL", "Pixel 9 Pro Fold",
        "PRODUCT", "comet_beta",
        "DEVICE_INITIAL_SDK_INT", "35",
        "SECURITY_PATCH", "2025-01-06",
        "ID", "BP11.241121.013"
    );

    static {
        propsToChangePixel9ProXL  = new HashMap<>();
        propsToChangePixel9ProXL.put("BRAND", "google");
        propsToChangePixel9ProXL.put("MANUFACTURER", "Google");
        propsToChangePixel9ProXL.put("DEVICE", "komodo");
        propsToChangePixel9ProXL.put("PRODUCT", "komodo");
        propsToChangePixel9ProXL.put("HARDWARE", "komodo");
        propsToChangePixel9ProXL.put("MODEL", "Pixel 9 Pro XL");
        propsToChangePixel9ProXL.put("ID", "AP4A.250205.002");
        propsToChangePixel9ProXL.put("FINGERPRINT", "google/komodo/komodo:15/AP4A.250205.002/12821496:user/release-keys");
        propsToChangePixelXL = new HashMap<>();
        propsToChangePixelXL.put("BRAND", "google");
        propsToChangePixelXL.put("MANUFACTURER", "Google");
        propsToChangePixelXL.put("DEVICE", "marlin");
        propsToChangePixelXL.put("PRODUCT", "marlin");
        propsToChangePixelXL.put("MODEL", "Pixel XL");
        propsToChangePixelXL.put("FINGERPRINT", "google/marlin/marlin:10/QP1A.191005.007.A3/5972272:user/release-keys");
        propsToChangePixel5a = new HashMap<>();
        propsToChangePixel5a.put("BRAND", "google");
        propsToChangePixel5a.put("MANUFACTURER", "Google");
        propsToChangePixel5a.put("DEVICE", "barbet");
        propsToChangePixel5a.put("PRODUCT", "barbet");
        propsToChangePixel5a.put("HARDWARE", "barbet");
        propsToChangePixel5a.put("MODEL", "Pixel 5a");
        propsToChangePixel5a.put("ID", "AP2A.240805.005");
        propsToChangePixel5a.put("FINGERPRINT", "google/barbet/barbet:14/AP2A.240805.005/12025142:user/release-keys");
    }

    public static void setProps(String packageName) {
        setGameProps(packageName);
        if (packageName == null || packageName.isEmpty()) {
            return;
        }

        boolean isPixelDevice = SystemProperties.get("ro.soc.manufacturer").equalsIgnoreCase("Google");

        Map<String, Object> propsToChange = new HashMap<>();

        final String processName = Application.getProcessName();
        boolean isExcludedProcess = processName != null && (processName.toLowerCase().contains("unstable"));

        String[] packagesToChangeRecentPixel  = {
            "com.google.android.apps.aiwallpapers",
            "com.android.vending",
            "com.google.android.apps.bard",
            "com.google.android.apps.customization.pixel",
            "com.google.android.apps.emojiwallpaper",
            "com.google.android.apps.nexuslauncher",
            "com.google.android.apps.photos",
            "com.google.android.apps.pixel.agent",
            "com.google.android.apps.pixel.creativeassistant",
            "com.google.android.apps.pixel.support",
            "com.google.android.apps.privacy.wildlife",
            "com.google.android.apps.wallpaper",
            "com.google.android.apps.wallpaper.pixel",
            "com.google.android.gms",
            "com.google.android.googlequicksearchbox",
            "com.google.android.settings.intelligence",
            "com.google.android.wallpaper.effects",
            "com.google.pixel.livewallpaper",
            "com.google.android.apps.nexuslauncher",
            "com.google.android.inputmethod.latin",
            "com.google.android.tts",
            "com.netflix.mediaclient"
        };

        if (Arrays.asList(packagesToChangeRecentPixel ).contains(packageName) && !isExcludedProcess) {
            if (SystemProperties.getBoolean(SPOOF_PIXEL_GOOGLE_APPS, true)) {
                    propsToChange.putAll(propsToChangePixel9ProXL);
            } else if (packageName.equals("com.netflix.mediaclient") && 
                        !SystemProperties.getBoolean(SPOOF_PIXEL_NETFLIX, false)) {
                    if (DEBUG) Log.d(TAG, "Netflix spoofing disabled by system prop");
                    return;
            }
        }

        if (packageName.equals("com.google.android.apps.photos")) {
            if (SystemProperties.getBoolean(SPOOF_PIXEL_GPHOTOS, true)) {
                propsToChange.putAll(propsToChangePixelXL);
            } else {
                if (!isPixelDevice) {
                    if (processName.toLowerCase().contains("gservice")){
                        propsToChange.putAll(propsToChangePixel5a);
                    }
                }
                }
            }


	if (packageName.equals("com.snapchat.android")) {
            propsToChange.putAll(propsToChangePixelXL);
        }

        if (packageName.equals("com.google.android.gms")) {
            if (SystemProperties.getBoolean(SPOOF_PIXEL_GMS, true)) {
                if (shouldTryToCertifyDevice(Application.getProcessName())) {
                    return;
                }
            }
	}

        if (!propsToChange.isEmpty()) {
            if (DEBUG) Log.d(TAG, "Defining props for: " + packageName);
            for (Map.Entry<String, Object> prop : propsToChange.entrySet()) {
                String key = prop.getKey();
                Object value = prop.getValue();
                if (DEBUG) Log.d(TAG, "Defining " + key + " prop for: " + packageName);
                setPropValue(key, value);
            }
        }
    }
    
    public static void setGameProps(String packageName) {
        if (!SystemProperties.getBoolean(ENABLE_GAME_PROP_OPTIONS, false)) {
            return;
        }
        if (packageName == null || packageName.isEmpty()) {
            return;
        }
        Map<String, String> gamePropsToChange = new HashMap<>();
        String[] keys = {"BRAND", "DEVICE", "MANUFACTURER", "MODEL", "FINGERPRINT", "PRODUCT"};
        for (String key : keys) {
            String systemPropertyKey = "persist.sys.gameprops." + packageName + "." + key;
            String value = SystemProperties.get(systemPropertyKey);
            if (value != null && !value.isEmpty()) {
                gamePropsToChange.put(key, value);
                if (DEBUG) Log.d(TAG, "Got system property: " + systemPropertyKey + " = " + value);
            }
        }
        if (!gamePropsToChange.isEmpty()) {
            if (DEBUG) Log.d(TAG, "Defining props for: " + packageName);
            for (Map.Entry<String, String> prop : gamePropsToChange.entrySet()) {
                String key = prop.getKey();
                String value = prop.getValue();
                if (DEBUG) Log.d(TAG, "Defining " + key + " prop for: " + packageName);
                setPropValue(key, value);
            }
        }
    }

    private static void setPropValue(String key, Object value) {
        try {
            Field field = getBuildClassField(key);
            if (field != null) {
                field.setAccessible(true);
                if (field.getType() == int.class) {
                    if (value instanceof String) {
                        field.set(null, Integer.parseInt((String) value));
                    } else if (value instanceof Integer) {
                        field.set(null, (Integer) value);
                    }
                } else if (field.getType() == long.class) {
                    if (value instanceof String) {
                        field.set(null, Long.parseLong((String) value));
                    } else if (value instanceof Long) {
                        field.set(null, (Long) value);
                    }
                } else {
                    field.set(null, value.toString());
                }
                field.setAccessible(false);
                dlog("Set prop " + key + " to " + value);
            } else {
                Log.e(TAG, "Field " + key + " not found in Build or Build.VERSION classes");
            }
        } catch (NoSuchFieldException | IllegalAccessException | IllegalArgumentException e) {
            Log.e(TAG, "Failed to set prop " + key, e);
        }
    }

    private static Field getBuildClassField(String key) throws NoSuchFieldException {
        try {
            Field field = Build.class.getDeclaredField(key);
            dlog("Field " + key + " found in Build.class");
            return field;
        } catch (NoSuchFieldException e) {
            Field field = Build.VERSION.class.getDeclaredField(key);
            dlog("Field " + key + " found in Build.VERSION.class");
            return field;
        }
    }

    private static boolean isGmsAddAccountActivityOnTop() {
        try {
            final ActivityTaskManager.RootTaskInfo focusedTask =
                    ActivityTaskManager.getService().getFocusedRootTaskInfo();
            return focusedTask != null && focusedTask.topActivity != null
                    && focusedTask.topActivity.equals(GMS_ADD_ACCOUNT_ACTIVITY);
        } catch (Exception e) {
            Log.e(TAG, "Unable to get top activity!", e);
        }
        return false;
    }

    private static boolean shouldTryToCertifyDevice(String processName) {
        if (processName == null || !processName.toLowerCase().contains("unstable")) {
            return false;
        }

        setPropValue("TIME", System.currentTimeMillis());

        final boolean was = isGmsAddAccountActivityOnTop();
        final TaskStackListener taskStackListener = new TaskStackListener() {
            @Override
            public void onTaskStackChanged() {
                final boolean is = isGmsAddAccountActivityOnTop();
                if (is ^ was) {
                    dlog("GmsAddAccountActivityOnTop is:" + is + " was:" + was +
                            ", killing myself!"); // process will restart automatically later
                    Process.killProcess(Process.myPid());
                }
            }
        };
        if (!was) {
            dlog("Spoofing build for GMS");
            try {
                ActivityTaskManager.getService().registerTaskStackListener(taskStackListener);
            } catch (Exception e) {
                Log.e(TAG, "Failed to register task stack listener!", e);
            }
            spoofBuildGms();
            return true;
        } else {
            dlog("Skip spoofing build for GMS, because GmsAddAccountActivityOnTop");
            return false;
        }
    }

    public static boolean shouldBypassTaskPermission(Context context) {
        // GMS doesn't have MANAGE_ACTIVITY_TASKS permission
        final int callingUid = Binder.getCallingUid();
        final int gmsUid;
        try {
            gmsUid = context.getPackageManager().getApplicationInfo("com.google.android.gms", 0).uid;
            //dlog("shouldBypassTaskPermission: gmsUid:" + gmsUid + " callingUid:" + callingUid);
        } catch (Exception e) {
            //Log.e(TAG, "shouldBypassTaskPermission: unable to get gms uid", e);
            return false;
        }
        return gmsUid == callingUid;
    }

    private static void spoofBuildGms() {
        for (Map.Entry<String, String> entry : DEFAULT_VALUES.entrySet()) {
            String propKey = PROP_HOOKS + entry.getKey();
            String value = SystemProperties.get(propKey);
            setPropValue(entry.getKey(), value != null && !value.isEmpty() ? value : entry.getValue());
        }
    }

    private static boolean isCallerSafetyNet() {
        return Arrays.stream(Thread.currentThread().getStackTrace())
                        .anyMatch(elem -> elem.getClassName().toLowerCase()
                            .contains("droidguard"));
    }

    public static void onEngineGetCertificateChain() {

        if (!SystemProperties.getBoolean(SPOOF_PIXEL_PI, true))
            return;

        // If a keybox is found, don't block key attestation
        if (KeyProviderManager.isKeyboxAvailable()) {
            dlog("Key attestation blocking is disabled because a keybox is defined to spoof");
            return;
        }

        // Check stack for SafetyNet or Play Integrity
        if (isCallerSafetyNet()) {
            Log.i(TAG, "Blocked key attestation");
            throw new UnsupportedOperationException();
        }
    }

    private static void dlog(String msg) {
        if (DEBUG) Log.d(TAG, msg);
    }
}
