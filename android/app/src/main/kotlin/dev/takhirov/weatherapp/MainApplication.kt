package dev.takhirov.weatherapp
import android.app.Application

import com.yandex.mapkit.MapKitFactory

class MainApplication: Application() {
    override fun onCreate() {
        super.onCreate()
//        MapKitFactory.setLocale("YOUR_LOCALE") // Your preferred language. Not required, defaults to system language
        MapKitFactory.setApiKey("ba4b0d0f-00cc-4c6f-8412-796ee500f4b5") // Your generated API key
    }
}