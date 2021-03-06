//
//  SavedPresenter.swift
//  TneMovie
//
//  Created by skarev on 24.08.2020.
//  Copyright © 2020 skarev. All rights reserved.
//

import Foundation

protocol SavedViewProtocol: class {
    func setSaved(movies: [Movie]?)
}

protocol SavedViewPresenterProtocol: class {
    init(view: SavedViewProtocol, coreDataService: CoreDataServiceProtocol, router: RouterProtocol)
    func setSaved()
    func delete(movie: Movie, at: Int)
    var movies: [Movie]? { get set }
}

class SavedPresenter: SavedViewPresenterProtocol {
    weak var view: SavedViewProtocol?
    var coreDataService: CoreDataServiceProtocol?
    var router: RouterProtocol?
    var movies: [Movie]?
    
    required init(view: SavedViewProtocol, coreDataService: CoreDataServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.coreDataService = coreDataService
        self.router = router
        self.movies = coreDataService.getFromDB()
    }
    
    public func setSaved() {
        self.view?.setSaved(movies: movies)
    }
    
    func delete(movie: Movie, at: Int) {
        movies?.remove(at: at)
        coreDataService?.deleteFromDB(movie: movie)
    }
}
