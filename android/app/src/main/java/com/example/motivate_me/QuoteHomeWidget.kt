package com.example.motivate_me

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.util.Log
import android.widget.RemoteViews

/**
 * Implementation of App Widget functionality.
 */
class QuoteHomeWidget : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        val prefs = context.getSharedPreferences("quote_prefs", Context.MODE_PRIVATE)
        val quote = prefs.getString("quote_text", "Stay motivated!")
        Log.d("MotivateMe", "onUpdate: Loaded quote from SharedPreferences: $quote")

        for (appWidgetId in appWidgetIds) {
            Log.d("MotivateMe", "onUpdate: Updating widget Id $appWidgetId")
            val views = RemoteViews(context.packageName, R.layout.quote_home_widget)
            views.setTextViewText(R.id.quote_text, quote)
            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}
