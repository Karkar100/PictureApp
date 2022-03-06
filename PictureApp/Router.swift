//
//  Router.swift
//  PictureApp
//
//  Created by Diana Princess on 03.03.2022.
//

import UIKit
import CoreData

protocol RouterBasic {
    var navigationController: UINavigationController? { get set }
    var moduleBuilder: ModuleBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterBasic {
    func initialViewController()
    func openPhoto(photo: NSManagedObject)
    func popToRoot()
}

class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    var moduleBuilder: ModuleBuilderProtocol?
    
    init(navigationController: UINavigationController, moduleBuilder: ModuleBuilderProtocol) {
        self.navigationController = navigationController
        self.moduleBuilder = moduleBuilder
    }
    func initialViewController() {
        if let navigationController = navigationController {
            guard let photoCollectionViewController = moduleBuilder?.buildPhotoCollection(router: self) else { return }
            navigationController.viewControllers = [photoCollectionViewController]
        }
    }
    
    func openPhoto(photo: NSManagedObject) {
        if let navigationController = navigationController {
            guard let photoScreenViewController = moduleBuilder?.buildPhotoScreen(photo: photo, router: self) else { return }
            navigationController.pushViewController(photoScreenViewController, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
    
}

