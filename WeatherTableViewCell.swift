//
//  WeatherTableViewCell.swift
//  WeatherDemo
//
//  Created by Jack on 5/13/17.
//  Copyright © 2017 AMT. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherCellImage: UIImageView!
    
    @IBOutlet weak var weatherCellWeekDay: UITextField!
    
    @IBOutlet weak var weatherCellWeatherStatus: UITextField!
    
    @IBOutlet weak var weatherCellTempMax: UITextField!
    
    @IBOutlet weak var weatherCellTempMin: UITextField!
    
    
    func weatherCellUIUpdate(next5Days: Next5DayWeather) {
        
       
        weatherCellTempMax.text = "\(next5Days.currentTemp!)" + DEGREE
        weatherCellTempMin.text = "\(next5Days.currentTempMin!)" + DEGREE
        weatherCellWeatherStatus.text = next5Days.weatherType
        weatherCellWeekDay.text = next5Days.date
        if let imageInDic = ICON_DICTIONARY[next5Days.weatherIcon] {
            weatherCellImage.image = UIImage(named: imageInDic)
        } else {
            print("not weather image icon for this weather")
        }
    
    }
    
}
