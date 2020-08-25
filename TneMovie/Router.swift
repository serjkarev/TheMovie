//
//  Router.swift
//  TneMovie
//
//  Created by skarev on 24.08.2020.
//  Copyright © 2020 skarev. All rights reserved.
//

import UIKit

protocol MainRouter {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: MainRouter {
    func initialViewController()
    func showSaved()
//    func popToRoot()
}

class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = assemblyBuilder?.createMainModule(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }
    
    func showSaved() {
        if let navigationController = navigationController {
            guard let savedViewController = assemblyBuilder?.createSavedModule(router: self) else { return }
            navigationController.pushViewController(savedViewController, animated: true)
        }
    }
    
//    func popToRoot() {
//        if let navigationController = navigationController {
//            navigationController.popToRootViewController(animated: true)
//        }
//    }
    
}
