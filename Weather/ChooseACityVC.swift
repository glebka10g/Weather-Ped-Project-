//
//  ChooseACityVC.swift
//  Weather
//
//  Created by Gleb Gurev on 28.08.2023.
//

import UIKit

class ChooseACityVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let city = Cityes()
    let urlData = testURL()
    let defaults = UserDefaults.standard
    var closureCity: ((String) -> Void)?
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return city.cityRussia.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let libraryCity = city.cityRussia
        let cities = libraryCity.keys
        let sortedCities = cities.sorted()
        cell.textLabel?.text = sortedCities[indexPath.row]
        return cell
    }
    

    let tableOfCities: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableOfCities.frame = view.bounds
        view.addSubview(tableOfCities)
        tableOfCities.delegate = self
        tableOfCities.dataSource = self
        view.backgroundColor = .white
        let tap = UITapGestureRecognizer(target: self, action: #selector(chooseCity(_:)))
        view.addGestureRecognizer(tap)
    }
    

    @objc private func chooseCity(_ sender: UITapGestureRecognizer) {
        let tapLocation = sender.location(in: tableOfCities)
        if let tappedIndexPath = tableOfCities.indexPathForRow(at: tapLocation) {
            let tappedCell = tableOfCities.cellForRow(at: tappedIndexPath)
            if let text = tappedCell?.textLabel?.text {
                closureCity?(text)
                city.latLon(text)
                defaults.set(text, forKey: "city")
                navigationController?.popViewController(animated: true)
            }
        }
        
    }

}
