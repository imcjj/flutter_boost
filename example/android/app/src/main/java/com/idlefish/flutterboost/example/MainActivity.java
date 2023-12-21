package com.idlefish.flutterboost.example;

import android.content.Intent;
import android.graphics.Color;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import com.idlefish.flutterboost.FlutterBoost;
import com.idlefish.flutterboost.containers.FlutterBoostActivity;

import java.lang.ref.WeakReference;
import java.util.HashMap;
import java.util.Map;
import android.util.Log;

import io.flutter.embedding.android.FlutterActivityLaunchConfigs;

import static com.idlefish.flutterboost.containers.FlutterActivityLaunchConfigs.ACTIVITY_RESULT_KEY;

 public class MainActivity extends AppCompatActivity implements View.OnClickListener {

     private final int REQUEST_CODE = 999;
     private TextView mOpenNative;
     private TextView mOpenFlutter;
     private TextView mOpenFlutterFragment;
     private TextView mOpenCustomViewTab;

     //joey:start
     private Handler colorChangeHandler = new Handler();
     private Runnable colorChangeRunnable;
     private boolean isRed = false; // 初始颜色设置为非红色，所以第一次变化时会变成红色
     //joey:end

     @Override
     protected void onCreate(@Nullable Bundle savedInstanceState) {
         super.onCreate(savedInstanceState);
         Log.i("joey_test","native onCreate");

         if((getIntent().getFlags() & Intent.FLAG_ACTIVITY_BROUGHT_TO_FRONT) != 0){
             finish();
             return;
         }

         setContentView(R.layout.native_page);

         mOpenNative = findViewById(R.id.open_native);
         mOpenFlutter = findViewById(R.id.open_flutter);
         mOpenFlutterFragment = findViewById(R.id.open_flutter_fragment);
         mOpenCustomViewTab = findViewById(R.id.open_custom_view_tab);

         mOpenNative.setOnClickListener(this);
         mOpenFlutter.setOnClickListener(this);
         mOpenFlutterFragment.setOnClickListener(this);
         mOpenCustomViewTab.setOnClickListener(this);

         //joey:start
         colorChangeRunnable = new Runnable() {
             @Override
             public void run() {
                 // 切换颜色
                 if (isRed) {
                     mOpenNative.setBackgroundColor(Color.BLUE);
                 } else {
                     mOpenNative.setBackgroundColor(Color.RED);
                 }
                 isRed = !isRed;

                 // 每秒后再次运行
                 colorChangeHandler.postDelayed(this, 100);
             }
         };

         // 启动循环颜色变化
         colorChangeHandler.post(colorChangeRunnable);
         //joey:end
     }

     @Override
     protected void onDestroy() {
         super.onDestroy();
         Log.i("joey_test","native onDestroy");
         //joey:start
         // 确保在 Activity 销毁时停止 handler 的回调，以防内存泄漏
         colorChangeHandler.removeCallbacks(colorChangeRunnable);
         //joey:end
     }

     @Override
     public void onClick(View v) {
         Map<String, Object> params = new HashMap<>();
         params.put("string","a string");
         params.put("bool", true);
         params.put("int", 666);
         //Add some params if needed.
         if (v == mOpenNative) {
             NativeRouter.openPageByUrl(this, NativeRouter.NATIVE_PAGE_URL , params);
         } else if (v == mOpenFlutter) {
             Intent intent = new FlutterBoostActivity.CachedEngineIntentBuilder(FlutterBoostActivity.class)
                     .backgroundMode(FlutterActivityLaunchConfigs.BackgroundMode.opaque)
                     .destroyEngineWithActivity(false)
                     .url("flutterPage")
                     .urlParams(params)
                     .build(this);
 //            //joey:start
//             if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
//                 // 在支持的设备上以自由形式启动 FloatingActivity
//                 intent.addFlags(Intent.FLAG_ACTIVITY_LAUNCH_ADJACENT | Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_MULTIPLE_TASK);
//             }
 //            //joey:end
             startActivityForResult(intent, REQUEST_CODE);
         } else if (v == mOpenFlutterFragment) {
             NativeRouter.openPageByUrl(this, NativeRouter.FLUTTER_FRAGMENT_PAGE_URL,params);
         } else if (v == mOpenCustomViewTab) {
             NativeRouter.openPageByUrl(this, NativeRouter.FLUTTER_CUSTOM_VIEW_URL, params);
         }
     }

     @Override
     protected void onActivityResult(int requestCode, int resultCode, Intent data) {
         Log.d("xlog", "#onActivityResult, requestCode=" + requestCode + ", resultCode=" + resultCode + ", data=" + (data != null ? data.getSerializableExtra(ACTIVITY_RESULT_KEY) : ""));
         if (data != null) {
             Toast.makeText(getApplicationContext(), "#onActivityResult:" + data.getSerializableExtra(ACTIVITY_RESULT_KEY) , Toast.LENGTH_SHORT).show();
         }
     }
     @Override
     protected void onStart(){
         super.onStart();
         Log.i("joey_test","native onStart");
     }

     @Override
     protected void onRestart(){
         super.onRestart();
         Log.i("joey_test","native onRestart");
     }

     @Override
     protected void onResume(){
         super.onResume();
         Log.i("joey_test","native onResume");
     }

     @Override
     protected void onPause(){
         super.onPause();
         Log.i("joey_test","native onPause");
     }

     @Override
     protected void onStop(){
         super.onStop();
         Log.i("joey_test","native onStop");
     }

     @Override
     public void onTopResumedActivityChanged(boolean isTopResumedActivity) {
         super.onTopResumedActivityChanged(isTopResumedActivity);
         if(isTopResumedActivity){
             Log.i("joey_test","native is onTopResumed");
         }else{
             Log.i("joey_test","native is not onTopResumed");
         }
     }
 }
