//
//  AssemblyBuilder.swift
//  TneMovie
//
//  Created by skarev on 24.08.2020.
//  Copyright © 2020 skarev. All rights reserved.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createSavedModule(router: RouterProtocol, movies: [Movie]?) -> UIViewController
}

class AssemblyBuilder: AssemblyBuilderProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let networkService = NetworkSevice()
        let coreDataService = CoreDataService()
        let presenter = MainPresenter(view: view, networkSevice: networkService, coreDataService: coreDataService, router: router)
        view.presenter = presenter
        return view
    }
    
    func createSavedModule(router: RouterProtocol, movies: [Movie]?) -> UIViewController {
        let view = SavedViewController()
        let coreDataService = CoreDataService()
        let presenter = SavedPresenter(view: view, coreDataService: coreDataService, router: router)
        view.presenter = presenter
        return view
    }
}
