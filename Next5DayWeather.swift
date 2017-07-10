//
//  Next5DayWeather.swift
//  WeatherDemo
//
//

import Foundation

class Next5DayWeather : TodayWeather {
    
    private var _forecastWeatherHumidity: Int!
    private var _forecastWeatherPresure: Double!
    private var _forecastWeatherWind: Double!
    
    var forecastWeatherHumidity: Int! {
        get {
            return self._forecastWeatherHumidity
        }
        set (newVal) {
            self._forecastWeatherHumidity = newVal
        }
        
    }
    
    var forecastWeatherPresure: Double! {
        get {
            return self._forecastWeatherPresure
        }
        set (newVal) {
            self._forecastWeatherPresure = newVal
        }
        
    }
    
    var forecastWeatherWind: Double! {
        get {
            return self._forecastWeatherWind
        }
        set (newVal) {
            self._forecastWeatherWind = newVal
        }
        
    }
    
    override init () {
        super.init()
        self._forecastWeatherHumidity = Int(DEFAULT_INIT_VALUE)
        self._forecastWeatherPresure = Double(DEFAULT_INIT_VALUE)
        self._forecastWeatherWind = Double(DEFAULT_INIT_VALUE)
        self.urlString = "\(NEXT5DAYS_BASE_URL)\(API_KEY)"
    }
    
    func getNext5DayWeatherDate(completion: @escaping (_ result: [Next5DayWeather]) -> () ) {
        
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) {
                
                (data, response, error) -> Void in
                
                guard error == nil else {
                    print("getNext5DayWeatherDate: ", error!)
                    return
                }
                guard let data = data else {
                    print("getNext5DayWeatherDate: ","Data is empty")
                    return
                }
                completion(self.JasonParsingNext5DayWeather(data: data)
                )
            }
            task.resume()
        }
        
    }
    
    func JasonParsingNext5DayWeather(data: Data?) -> ( [Next5DayWeather] ) {        
        var next5DaysData = [Next5DayWeather]()
        
        if data != nil {
            do {
                if let jsondata = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                    if let list = jsondata["list"] as? [NSDictionary] {
                        for objInList in list {
                            let next5DayWeather = Next5DayWeather()
                            
                            if let dt = objInList["dt"] as? Int {
                                next5DayWeather.date = DateConvert(dt: dt)
                            }
                            if let temp = objInList["temp"] as? NSDictionary {
                                if let min = temp["min"] as? Double {
                                    next5DayWeather.currentTempMin = min
                                }
                                if let max = temp["max"] as? Double {
                                    next5DayWeather.currentTemp = max
                                }
                            }
                            if let pressure = objInList["pressure"] as? Double {
                                next5DayWeather.forecastWeatherPresure = pressure
                            }
                            if let humidity = objInList["humidity"] as? Int {
                                next5DayWeather.forecastWeatherHumidity = humidity
                            }
                            if let speed = objInList["speed"] as? Double  {
                                next5DayWeather.forecastWeatherWind = speed
                            }
                            if let weather = objInList["weather"] as? [NSDictionary] {
                                if let main = weather[0]["main"] as? String {
                                    next5DayWeather.weatherType = main
                                }
                                if let icon = weather[0]["icon"] as? String {
                                    next5DayWeather.weatherIcon = icon
                                }
                            }
                            let today = setTodayDate()
                            
                            if next5DayWeather.date.range(of: today) == nil {
                                next5DaysData.append(next5DayWeather)
                            }
                        }
                    }
                }
            } catch {
                print("error in JSONSerilization in fetching Forecast")
            }
            
        } else {
            print ("data is empty in Forecast")
        }
        
        return next5DaysData
    }
    
    
}
