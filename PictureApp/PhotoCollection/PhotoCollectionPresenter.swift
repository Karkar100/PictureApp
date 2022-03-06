//
//  PhotoCollectionPresenter.swift
//  PictureApp
//
//  Created by Diana Princess on 03.03.2022.
//

import Foundation
import UIKit
import CoreData

protocol PhotoCollectionViewProtocol: class {
    func reloadCollection()
    func requestFailure(error: Error)
    var activityIndicator: UIActivityIndicatorView { get set }
}

protocol PhotoCollectionPresenterProtocol: class, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var reuseIdentifier: String { get set}
    init(view: PhotoCollectionViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    func fetching()
}

class PhotoCollectionPresenter: NSObject, PhotoCollectionPresenterProtocol {
    
    weak var view: PhotoCollectionViewProtocol?
    let networkService: NetworkServiceProtocol!
    var router: RouterProtocol?
    var photos: [ApiPhotoModel]?
    var savedPhotos: [NSManagedObject] = []
    var photoImages: [NSManagedObject] = []
    var reuseIdentifier = "PhotoCell"
    
    required init(view: PhotoCollectionViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        super.init()
        view.activityIndicator.startAnimating()
        getPhotos()
    }

    func getPhotos(){
        networkService.getPhotos{ [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    for item in response ?? [] {
                        self.networkService.getOnePhoto(from: item.url){ [self] data, response, error in
                            guard let data = data, error == nil else { return }
                            DispatchQueue.main.async {
                                self.savePhoto(photo: item, image: UIImage(data: data)!)
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.fetching()
                        self.view?.reloadCollection()
                    }
                case .failure(let error):
                    self.view?.requestFailure(error: error)
                }
            }
        }
    }
    
    func savePhoto(photo: ApiPhotoModel, image: UIImage){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "PhotoSave", in: managedContext)!
        let savedPhoto = NSManagedObject(entity: entity, insertInto: managedContext)
        let jpegImageData = image.jpegData(compressionQuality: 1.0)
        savedPhoto.setValue(photo.id, forKeyPath: "id")
        savedPhoto.setValue(photo.albumId, forKeyPath: "albumId")
        savedPhoto.setValue(photo.title, forKeyPath: "title")
        savedPhoto.setValue(photo.url, forKeyPath: "url")
        savedPhoto.setValue(photo.thumbnailUrl, forKeyPath: "thumbnailUrl")
        savedPhoto.setValue(jpegImageData, forKeyPath: "downloadedImage")
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY"
        let dateText = dateFormatter.string(from: date)
        savedPhoto.setValue(dateText, forKeyPath: "date")
        do {
            try managedContext.save()
            savedPhotos.append(savedPhoto)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    func fetching() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PhotoSave")
        do {
            savedPhotos = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func openPhoto(photo: NSManagedObject){
        router?.openPhoto(photo: photo)
    }
    
}

extension PhotoCollectionPresenter: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let savedPhoto = savedPhotos[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ApiPhotoCell.reuseId, for: indexPath) as! ApiPhotoCell
        let title = savedPhoto.value(forKeyPath: "title")
        let data = savedPhoto.value(forKeyPath: "downloadedImage")
        let id = savedPhoto.value(forKeyPath: "id")
        cell.configure(title: title as! String, data: data as! Data, id: id as! Int)
        return cell
    }
    
}

extension PhotoCollectionPresenter: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let savedPhoto = savedPhotos[indexPath.row]
        openPhoto(photo: savedPhoto)
    }
}

extension PhotoCollectionPresenter: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         
         return CGSize(width: 250, height: 300)
        }
}
  // 1
  
