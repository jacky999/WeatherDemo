//
//  WeatherDetailViewController.swift
//  WeatherDemo
//
//  Created by Jack on 5/16/17.
//  Copyright © 2017 AMT. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    
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
    // var test: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // dismiss(animated: true, completion: nil)
        
        print ("inside DetialVC")
        
        // print("test:", test)
        
        printObj(n5dw: valueDetailData)
        
        if valueDetailData.date != "" {
            var fullDateArr = valueDetailData.date.components(separatedBy: ",")
            //weekDayLabel.text = forecast5days.date
            forecastDate.text = fullDateArr[0]
            forecastDateDetail.text = fullDateArr[1]
        }
        
        forecastTempLabel.text = "\(Double(valueDetailData.currentTemp))" + DEGREE
        forecastTempMinLabel.text = "\(Double(valueDetailData.currentTempMin))" + DEGREE
        forecastPresureLabel.text = "Pressure: " + "\(Double(valueDetailData.forecastWeatherPresure)) " + "hPa"
        forecastHumidityLabel.text = "Humidity: " + "\(Int(valueDetailData.forecastWeatherHumidity!)) " + "%"
        forecastWindLabel.text = "Wind: " + "\(valueDetailData.forecastWeatherWind!) " + "km/h"
        if let imageInDic = ICON_DICTIONARY[valueDetailData.weatherIcon] {
            forecastImageIcon.image = UIImage(named: imageInDic)
            print("img name ", imageInDic)
        } else {
            print("not weather image icon for this weather")
        }
        if (valueDetailData.weatherType != "") {
            forecastWeatherStatusLabel.text = "\(valueDetailData.weatherType!)"
        }
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
