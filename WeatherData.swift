//
//  WeatherData.swift
//  WeatherDemo
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?q=Dallas,tx&units=imperial&APPID="
let NEXT5DAYS_BASE_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?q=Dallas,tx&units=imperial&cnt=5&APPID="

// Replace the API key below with your own key
let API_KEY = "ca2f0159e1d2510f693b81c0e9a37724"

let DEFAULT_INIT_VALUE = -100.00
let NOIMAGE = "no-image"

let DEGREE =  "°"

let ICON_DICTIONARY = [
    "01d": "art_clear",
    "01n": "ic_clear",
    "02d": "art_light_clouds",
    "02n": "ic_light_clouds",
    "03d": "art_clouds",
    "03n": "ic_cloudy",
    "04d": "art_clouds",
    "04n": "ic_cloudy",
    "09d": "art_light_rain",
    "09n": "ic_light_rain",
    "10d": "art_rain",
    "10n": "ic_rain",
    "11d": "art_storm",
    "11n": "ic_storm",
    "13d": "art_snow",
    "13n": "ic_snow",
    "50d": "art_fog",
    "50n": "ic_fog",
]

func setTodayDate() -> String {
    
    let todayDate = DateFormatter()
    todayDate.dateFormat = "MMMM dd"
    let currentDate = todayDate.string(from: Date())
    
    return "\(currentDate)"
}

func relativeDate() -> String {
        
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .long
    dateFormatter.doesRelativeDateFormatting = true
    
    let relatiDate = dateFormatter.string(from: Date())
    
    return "\(relatiDate)"
}

func setToday() -> String {
    
    return "\(relativeDate()), \(setTodayDate())"
}

func DateConvert (dt: Int) -> String {
    
    let convertedDate = Date(timeIntervalSince1970: TimeInterval(dt))
    let forecastDate = DateFormatter()
    forecastDate.dateFormat = "EEEE, MMMM dd"

    return ("\(forecastDate.string(from: convertedDate))" )

}


