//
//  ModuleBuilder.swift
//  PictureApp
//
//  Created by Diana Princess on 03.03.2022.
//

import Foundation
import UIKit
import CoreData

protocol ModuleBuilderProtocol {
    func buildPhotoCollection(router: RouterProtocol) -> UIViewController
    func buildPhotoScreen(photo: NSManagedObject, router: RouterProtocol) -> UIViewController
}

class ModuleBuilder: ModuleBuilderProtocol {
    
    func buildPhotoCollection(router: RouterProtocol) -> UIViewController {
        let layout = UICollectionViewFlowLayout()
        let view = PhotoCollectionViewController(collectionViewLayout: layout)
        let networkService = NetworkService()
        let presenter = PhotoCollectionPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    func buildPhotoScreen(photo: NSManagedObject, router: RouterProtocol) -> UIViewController {
        let view = PhotoScreenViewController()
        let networkService = NetworkService()
        let presenter = PhotoScreenPresenter(view: view, networkService: networkService, router: router, photo: photo)
        view.presenter = presenter
        return view
    }
}

