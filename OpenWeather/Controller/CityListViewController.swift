//
//  CityListViewController.swift
//  OpenWeather
//
//  Created by Prashanthi Boravelly on 10/3/18.
//  Copyright © 2018 Optus. All rights reserved.
//

import UIKit

class CityListViewController: UITableViewController {
    
    var cities: [City]?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "RightDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "city")
        showLoadingView()
        WeatherInfoManager.fetchWeatherInfo(success: { cityList in
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.cities = cityList.cities
                strongSelf.tableView.reloadData()
                strongSelf.hideLoadingView()
            }
        }, failure:{ customError in
            print(customError.debugDescription)
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.showAlert(message: customError.userDescription)
                strongSelf.hideLoadingView()
            }
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "city")
        let city = cities![indexPath.row]
        cell?.textLabel?.text = city.name
        cell?.detailTextLabel?.text = String(city.main.temp) + "°C"
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        performSegue(withIdentifier: "city", sender: cell)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? DetailViewController,
            let tableViewCell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: tableViewCell)
        {
            viewController.city = cities?[indexPath.row]
        }
    }
    
    
    
}

