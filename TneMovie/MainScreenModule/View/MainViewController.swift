//
//  ViewController.swift
//  TneMovie
//
//  Created by skarev on 24.08.2020.
//  Copyright © 2020 skarev. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView?
    
    var presenter: MainViewPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var number: Int = 0
        presenter?.pages?.forEach({ (page) in
            number += page.results.count
        })
        return number
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "Foo Bar"
        return cell
    }
    
    
}

extension MainViewController: UITableViewDelegate {
    
}

extension MainViewController: MainViewProtocol {
    func success() {
        self.tableView?.reloadData()
    }
    
    func failure(error: Error) {
        // add alert controller
        print(error.localizedDescription)
    }
}
