//
//  WeatherDetailVC.swift
//  WeatherDemo
//
//

import Foundation
import UIKit

class WeatherDetailVC: UIViewController {
    
    @IBOutlet weak var forecastDate: UITextField!
    @IBOutlet weak var forecastDateDetail: UITextField!
    @IBOutlet weak var forecastTempLabel: UITextField!
    @IBOutlet weak var forecastTempMinLabel: UITextField!
    @IBOutlet weak var forecastHumidityLabel: UITextField!
    @IBOutlet weak var forecastPresureLabel: UITextField!
    @IBOutlet weak var forecastWindLabel: UITextField!
    @IBOutlet weak var forecastWeatherStatusLabel: UITextField!
    @IBOutlet weak var forecastImageIcon: UIImageView!
    
    
    var valueDetailData = Next5DayWeather()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateWeatherDetailUI()
        
    }
    
    func updateWeatherDetailUI () {
        
        var fullDateArr = valueDetailData.date.components(separatedBy: ",")
        forecastDate.text = fullDateArr[0]
        forecastDateDetail.text = fullDateArr[1]
        
        if (valueDetailData.currentTemp != Double(DEFAULT_INIT_VALUE) ) {
            forecastTempLabel.text = "\(Double((valueDetailData.currentTemp)!))" + DEGREE
        } else {
            forecastTempLabel.text = ""
        }
        
        if (valueDetailData.currentTemp != Double(DEFAULT_INIT_VALUE) ) {
            forecastTempMinLabel.text = "\(Double((valueDetailData.currentTempMin)!))" + DEGREE
        } else {
            forecastTempMinLabel.text = ""
        }
        
        if (valueDetailData.forecastWeatherPresure! != Double(DEFAULT_INIT_VALUE) ) {
            forecastPresureLabel.text = "Pressure: " + "\(valueDetailData.forecastWeatherPresure!) " + "hPa"
        } else {
            forecastPresureLabel.text = "Pressure: "
        }
        
        if (valueDetailData.forecastWeatherHumidity! != Int(DEFAULT_INIT_VALUE)) {
            forecastHumidityLabel.text = "Humidity: " + "\(valueDetailData.forecastWeatherHumidity!) " + "%"
        } else {
            forecastHumidityLabel.text = "Humidity: "
        }
        
        if (valueDetailData.forecastWeatherWind! != Double(DEFAULT_INIT_VALUE)) {
            forecastWindLabel.text = "Wind: " + "\(valueDetailData.forecastWeatherWind!) " + "km/h"
        } else {
            forecastWindLabel.text = "Wind: "
        }
        
        if let imageInDic = ICON_DICTIONARY[valueDetailData.weatherIcon!] {
            forecastImageIcon.image = UIImage(named: imageInDic)
        } else {
            forecastImageIcon.image = UIImage(named: NOIMAGE)
            print("not weather image icon for this weather")
        }
        
        if (valueDetailData.weatherType != "") {
            forecastWeatherStatusLabel.text = "\(valueDetailData.weatherType!)"
        }
    }
}
