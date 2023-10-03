//
//  testTableView.swift
//  Weather
//
//  Created by Gleb Gurev on 03.10.2023.
//

import UIKit

class testTableView: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    let defaults = UserDefaults.standard
    let cityes = Cityes()
    let firstVC = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(red: 247/255, green: 237/255, blue: 255/255, alpha: 1)
        constraintTableView()
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(tapped(_:)))
        view.addGestureRecognizer(longTap)
    
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let city = defaults.string(forKey: "city") {
            return cityes.attractionCity[city]!.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let city = defaults.string(forKey: "city") {
            let currentData = cityes.attractionCity[city] ?? []
            cell.textLabel?.text = currentData[indexPath.row]
            cell.backgroundColor = UIColor(red: 247/255, green: 237/255, blue: 255/255, alpha: 1)
        }
        return cell
    }
        func constraintTableView() {
        //    tableView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(tableView)
            
            tableView.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
                make.height.equalToSuperview()//.dividedBy(2)
            }

            }
    
    @objc private func tapped(_ sender: UILongPressGestureRecognizer) {
        let tapLocation = sender.location(in: tableView)
        if let locationIndex = tableView.indexPathForRow(at: tapLocation) {
            if let tappedCell = tableView.cellForRow(at: locationIndex) {
                if let text = tappedCell.textLabel?.text {
                    let copy = UIPasteboard.general
                    copy.string = text
                                    let labelCopy = UILabel(frame: CGRect(x: 0, y: 0, width: 170, height: 40))
                                    labelCopy.center = self.view.center
                                    labelCopy.textAlignment = .center
                                    labelCopy.backgroundColor = .black.withAlphaComponent(0.5)
                                    labelCopy.textColor = .white
                                    labelCopy.text = "Скопировано"
                                    labelCopy.layer.masksToBounds = true
                                    labelCopy.layer.cornerRadius = 5
                                    self.view.addSubview(labelCopy)
                    UIView.animate(withDuration: 0.3, animations: {
                        labelCopy.alpha = 1
                    }, completion: { _ in
                        UIView.animate(withDuration: 0.3, delay: 0.5, options: [], animations: {
                            labelCopy.alpha = 0
                        }, completion: { _ in
                            labelCopy.removeFromSuperview()
                        })
                    })
                }
            }
        }
    }
    
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


