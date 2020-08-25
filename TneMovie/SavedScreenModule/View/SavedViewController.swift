//
//  SavedViewController.swift
//  TneMovie
//
//  Created by skarev on 24.08.2020.
//  Copyright © 2020 skarev. All rights reserved.
//

import UIKit

class SavedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView?
    
    var presenter: SavedViewPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "SavedCell")
        presenter?.setSaved()
    }

}

extension SavedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.movies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedCell", for: indexPath)
        cell.textLabel?.text = presenter?.movies?[indexPath.row].title
        return cell
    }
    
    
}

extension SavedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let movieToDelete = presenter?.movies?[indexPath.row], editingStyle == .delete else { return }
        presenter?.delete(movie: movieToDelete, at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

extension SavedViewController: SavedViewProtocol {
    func setSaved(movies: [Movie]?) {
        self.tableView?.reloadData()
    }
}
