//
//  ModuleBuilder.swift
//  TneMovie
//
//  Created by skarev on 24.08.2020.
//  Copyright © 2020 skarev. All rights reserved.
//

import UIKit

protocol Builder {
    static func createMainModule() -> UIViewController
}

class ModuleBuilder: Builder {
    static func createMainModule() -> UIViewController {
        let view = MainViewController()
        let networkService = NetworkSevice()
        let presenter = MainPresenter(view: view, networkSevice: networkService)
        view.presenter = presenter
        return view
    }
}
