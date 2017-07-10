//
//  TodayWeather.swift
//  WeatherDemo
//

import Foundation

class TodayWeather {
    
    private var _date:String!
    private var _currentTemp: Double!
    private var _currentTempMin: Double!
    private var _weatherType: String!
    private var _weatherIcon: String!
    private var _urlString: String!
    
    var date: String! {
        get {
            if self._date == nil {
                self._date = ""
            }
            return self._date
        }
        set (newVal) {
            self._date = newVal
        }
    }
    var currentTemp: Double! {
        get {
            return self._currentTemp
        }
        set (newVal) {
            self._currentTemp = newVal
        }
        
    }
    var currentTempMin: Double! {
        get {
            return self._currentTempMin
        }
        set (newVal) {
            self._currentTempMin = newVal
        }
    }
    var weatherType: String! {
        get {
            if self._weatherType == nil {
                self._weatherType = ""
            }
            return self._weatherType
        }
        set (newVal) {
            self._weatherType = newVal
        }
    }
    var weatherIcon: String! {
        get {
            if self._weatherIcon == nil {
                self._weatherIcon = ""
            }
            return self._weatherIcon
        }
        set (newVal) {
            self._weatherIcon = newVal
        }
    }
    var urlString: String! {
        get {
            if self._urlString == nil {
                self._urlString = ""
            }
            return self._urlString
        }
        set (newVal) {
            self._urlString = newVal
        }
    }
    
    
    init () {
        self.date = setToday()
        self.currentTemp = Double(DEFAULT_INIT_VALUE)
        self.currentTempMin = Double(DEFAULT_INIT_VALUE)
        self.weatherType = ""
        self.weatherIcon = "no-image"
        self._urlString = "\(BASE_URL)\(API_KEY)"
    }
    
    func getTodayWeatherDate(completion: @escaping (_ result: TodayWeather) -> () ) {
        
        if let urlString = URL(string: urlString) {
            
            let task = URLSession.shared.dataTask(with: urlString) { (data, response, error) -> Void in
                
                guard error == nil else {
                    print("getTodayWeatherDate: ", error!)
                    return
                }
                guard let data = data else {
                    print("getTodayWeatherDate: ","Data is empty")
                    return
                }
                
                print("TodayWeather Data:", data)
                completion(self.JasonParsingTodayWeather(data: data))
                
            }
            
            task.resume()
        }
        
    }
    
    func JasonParsingTodayWeather(data: Data) -> (TodayWeather) {
        let todayWeather = TodayWeather()
        
        do {
            if let jsondata = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                if let main = jsondata["main"] as? NSDictionary {
                    if let temp = main["temp"] as? Double {
                        todayWeather.currentTemp = temp
                    }
                    if let temp_min = main["temp_min"] as? Double {
                        todayWeather.currentTempMin = temp_min
                    }
                }
                if let weather = jsondata["weather"] as? [NSDictionary] {
                    if let main = weather[0]["main"] as? String {
                        todayWeather.weatherType = main
                    }
                    if let icon = weather[0]["icon"] as? String {
                        todayWeather.weatherIcon = icon
                    }
                }
            }
        } catch let error as NSError {
            print(error)
        }
        
        return todayWeather
        
    }
    
    
}
