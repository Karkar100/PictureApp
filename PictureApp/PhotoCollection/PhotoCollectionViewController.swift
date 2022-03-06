//
//  ViewController.swift
//  PictureApp
//
//  Created by Diana Princess on 03.03.2022.
//

import UIKit
import Network

class PhotoCollectionViewController: UICollectionViewController,  PhotoCollectionViewProtocol {
    
    var presenter: PhotoCollectionPresenterProtocol?
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "InternetConnectionMonitor")
    var activityIndicator = UIActivityIndicatorView(style: .large)
    override func viewDidLoad() {
        super.viewDidLoad()
        monitor.pathUpdateHandler = { pathUpdateHandler in
                    if pathUpdateHandler.status == .satisfied {
                        print("Internet connection is on.")
                    } else {
                        DispatchQueue.main.async {
                            self.showAlert()
                        }
                    }
                }
        monitor.start(queue: queue)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        title = "V for Vendetta"
        collectionView.register(ApiPhotoCell.self, forCellWithReuseIdentifier: ApiPhotoCell.reuseId)
        collectionView.backgroundColor = .white
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        collectionView.dataSource = presenter
        collectionView.delegate = presenter

        
        // Do any additional setup after loading the view.
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).sectionInsetReference = .fromLayoutMargins
        //(collectionView.collectionViewLayout as! CustomViewFlowLayout).shouldInvalidateLayout(forBoundsChange: .zero)
    }

    func reloadCollection() {
        collectionView.reloadData()
        activityIndicator.stopAnimating()
    }
    
    func requestFailure(error: Error) {
        print(error.localizedDescription)
    }
    
    func showAlert() {
            let alert = UIAlertController(title: "Отсутствует соединение с интернетом", message: "Пожалуйста, проверьте подключение и перезапустите приложение.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

}


