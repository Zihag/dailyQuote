package com.example.motivate_me

import android.appwidget.AppWidgetManager
import android.content.ComponentName
import android.content.Context
import android.util.Log
import android.widget.RemoteViews
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity(){
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "quote_channel")
            .setMethodCallHandler{call, result ->
                if (call.method == "saveQuote"){
                    val quote = call.argument<String>("quote")
                    Log.d("MovivateMe", "Receivec quote from flutter: $quote")


                    val prefs = getSharedPreferences("quote_prefs", Context.MODE_PRIVATE)
                    prefs.edit().putString("quote_text",quote).apply()
                    Log.d("MotivateMe","Quote saved to SharedPreferences")

//                    Update widget
                    val widgetManager = AppWidgetManager.getInstance(this)
                    val widgetComponent = ComponentName(this, QuoteHomeWidget::class.java)
                    val appWidgetIds = widgetManager.getAppWidgetIds(widgetComponent)

                    val remoteViews = RemoteViews(packageName, R.layout.quote_home_widget)
                    remoteViews.setTextViewText(R.id.quote_text, quote)

                    for(widgetId in appWidgetIds){
                        Log.d("MotivateMe", "Updating widget with Id $widgetId with quote: $quote")
                        widgetManager.updateAppWidget(widgetId, remoteViews)
                    }
                    result.success(null)
                } else {
                    result.notImplemented()
                }
            }
    }
}
