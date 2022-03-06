//
//  PhotoScreenPresenter.swift
//  PictureApp
//
//  Created by Diana Princess on 03.03.2022.
//

import Foundation
import CoreData
import UIKit

protocol PhotoScreenViewProtocol: class {
    func setInfo(image: UIImage, date: String, title: String, id: Int)
}

protocol PhotoScreenPresenterProtocol: class {
    init(view: PhotoScreenViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, photo: NSManagedObject)
    
}

class PhotoScreenPresenter: PhotoScreenPresenterProtocol {
    
    weak var view: PhotoScreenViewProtocol?
    let networkService: NetworkServiceProtocol!
    var router: RouterProtocol?
    var photo: NSManagedObject?
    required init(view: PhotoScreenViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, photo: NSManagedObject) {
        self.view = view
        self.networkService = networkService
        self.router = router
        self.photo = photo
        decodeInfo(photo: photo)
    }
    
    func decodeInfo(photo: NSManagedObject){
        guard let image = UIImage(data: photo.value(forKeyPath: "downloadedImage") as! Data) else { return }
        let date = photo.value(forKeyPath: "date")
        let title = photo.value(forKeyPath: "title")
        let id = photo.value(forKeyPath: "id")
        view?.setInfo(image: image, date: date as! String, title: title as! String, id: id as! Int)
    }
    
}




