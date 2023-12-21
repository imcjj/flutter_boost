package com.idlefish.flutterboost.example;

import android.content.pm.ActivityInfo;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;

import com.idlefish.flutterboost.containers.FlutterBoostActivity;

import io.flutter.embedding.android.FlutterActivityLaunchConfigs.BackgroundMode;

public class TransparencyPageActivity  extends FlutterBoostActivity {
    @Override
    protected BackgroundMode getBackgroundMode() {
        //joey:start
        Log.i("...joey_test","mode");
        //joey:end
        if (super.getBackgroundMode() != BackgroundMode.transparent) {
            throw new AssertionError("You *MUST* set FlutterActivity#backgroundMode correctly.");
        }
        return super.getBackgroundMode();
    }
    //joey:start
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (Build.VERSION.SDK_INT != Build.VERSION_CODES.O) {
            setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);
        }
    }

    @Override
    public void finish() {
        super.finish();
        overridePendingTransition(0, 0);
    }
    //joey:end
}
