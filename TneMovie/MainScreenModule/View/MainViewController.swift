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
        return presenter?.movies.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = presenter?.movies[indexPath.row].title
//        cell.imageView?.image = UIImage
        return cell
    }
    
    
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = presenter?.movies[indexPath.row]
        let alert = UIAlertController(title: "Add to Favorite?", message: "If you agree, \"\(movie?.title ?? "")\" will be added to your favorites", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [weak self] action in
            self?.presenter?.saveToFavorits(movie: movie)
        }))
        self.present(alert, animated: true)
    }
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
