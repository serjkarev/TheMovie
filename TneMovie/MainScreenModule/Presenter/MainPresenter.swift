//
//  MainPresenter.swift
//  TneMovie
//
//  Created by skarev on 24.08.2020.
//  Copyright © 2020 skarev. All rights reserved.
//

import Foundation

protocol MainViewProtocol: class {
    func success()
    func failure(error: Error)
}

protocol MainViewPresenterProtocol: class {
    init(view: MainViewProtocol,
         networkSevice: NetworkServiceProtocol,
         coreDataService: CoreDataServiceProtocol,
         router: RouterProtocol)
    
    func getPage()
    func saveToFavorits(movie: Movie?)
    func favoritesButtonPressed()
    
    var pages: [Page] { get set }
    var movies: [Movie] { get set }
}

class MainPresenter: MainViewPresenterProtocol {
    
    weak var view: MainViewProtocol?
    let networkSevice: NetworkServiceProtocol
    var coreDataService: CoreDataServiceProtocol?
    var router: RouterProtocol?
    
    var pages: [Page] = []
    var movies: [Movie] = []
    var currentPage: Int = 1
    
    required init(view: MainViewProtocol,
                  networkSevice: NetworkServiceProtocol,
                  coreDataService: CoreDataServiceProtocol,
                  router: RouterProtocol) {
        self.view = view
        self.networkSevice = networkSevice
        self.coreDataService = coreDataService
        self.router = router
        getPage()
    }

    func getPage() {
        networkSevice.getPopularMovies(page: currentPage) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.currentPage += 1
                switch result {
                case .success(let page):
                    if let page = page {
                        self.pages.append(page)
                        self.movies.append(contentsOf: page.results)
                        self.view?.success()
                    }
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
    
    func favoritesButtonPressed() {
        router?.showSaved()
    }
    
    func saveToFavorits(movie: Movie?) {
        coreDataService?.saveToDB(item: movie)
    }
}
