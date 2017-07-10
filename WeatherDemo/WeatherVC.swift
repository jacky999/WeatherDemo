//
//  ViewController.swift
//  WeatherDemo
//

import UIKit

var todayWeather = TodayWeather()
var next5DayWeather = [Next5DayWeather]()
var valueToDetail = Next5DayWeather()

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var todayTemp: UITextField!
    @IBOutlet weak var todayDate: UITextField!
    @IBOutlet weak var todayLowTemp: UITextField!
    @IBOutlet weak var todayWeatherStatus: UITextField!
    @IBOutlet weak var todayWeatherImage: UIImageView!
    @IBOutlet weak var weatherTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherTableView.delegate = self
        weatherTableView.dataSource = self
        
         todayWeather.getTodayWeatherDate() {

            (result: TodayWeather) in
            
            DispatchQueue.main.async {
                self.updateUIToday(todayWeather: result)
            }
        }
        
        valueToDetail.getNext5DayWeatherDate() {
        
            (result: [Next5DayWeather]) in
            
            next5DayWeather = result
            DispatchQueue.main.async {
                self.weatherTableView?.reloadData()
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return next5DayWeather.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherTableViewCell {
            
            cell.contentView.isUserInteractionEnabled = false
            let next5days = next5DayWeather[indexPath.row]
            cell.weatherCellUIUpdate(next5Days: next5days)
            return cell
            
        } else {
            print (" tableView indexPath no cell")
            return WeatherTableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow!
        valueToDetail = next5DayWeather[indexPath.row]
        performSegue(withIdentifier: "ShowDetailSegue", sender: valueToDetail)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let guest = segue.destination as! WeatherDetailVC
        guest.valueDetailData = sender as! Next5DayWeather
        
        
    }
    
    func updateUIToday(todayWeather: TodayWeather) {
        
        self.todayDate.text = todayWeather.date
        
        if (todayWeather.currentTemp == Double(DEFAULT_INIT_VALUE) ) {
            self.todayTemp.text = ""
        } else {
            self.todayTemp.text = "\(todayWeather.currentTemp!)" + DEGREE
        }
        
        if (todayWeather.currentTempMin == Double(DEFAULT_INIT_VALUE) ) {
            self.todayLowTemp.text = ""
        } else {
              self.todayLowTemp.text = "\(todayWeather.currentTempMin!)" + DEGREE
        }
        
        self.todayWeatherStatus.text = todayWeather.weatherType
        
        if let imageInDic = ICON_DICTIONARY[todayWeather.weatherIcon] {
            self.todayWeatherImage.image = UIImage(named: imageInDic)
        } else {
            self.todayWeatherImage.image = UIImage(named: NOIMAGE)
            print("not weather image icon for this weather")
        }
    }
    
}


