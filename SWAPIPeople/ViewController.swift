//
//  ViewController.swift
//  SWAPIPeople
//
//  Created by Andrii Pohodin on 25.11.2020.
//

import UIKit

class ViewController: UIViewController {
    
    let service = PeopleService()
    var people = [Result]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "CustomTableViewCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: "CustomTableViewCell")
        tableView.dataSource = self
        service.getPeople { [weak self] people in
            self?.people = people
            self?.tableView.reloadData()
        }
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        let result = people[indexPath.row]
        cell.nameLabel.text = result.name
        cell.genderLabel.text = result.gender.rawValue
        cell.birthYearLabel.text = result.birthYear
        return cell
    }
    
    
}
