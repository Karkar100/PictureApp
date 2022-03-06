//
//  PhotoScreenViewController.swift
//  PictureApp
//
//  Created by Diana Princess on 03.03.2022.
//

import UIKit
import CoreData
import SnapKit

class PhotoScreenViewController: UIViewController, PhotoScreenViewProtocol {

    var presenter: PhotoScreenPresenterProtocol?
    var photo: NSManagedObject?
    private let imageView : UIImageView = {
     let imgView = UIImageView()
     imgView.contentMode = .left
     imgView.clipsToBounds = true
     return imgView
     }()
    private let dateLabel : UILabel = {
     let lbl = UILabel()
     lbl.textColor = .black
     lbl.textAlignment = .left
     return lbl
     }()
    private let titleLabel : UILabel = {
     let lbl = UILabel()
     lbl.textColor = .black
     lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
     return lbl
    }()
    private let idLabel : UILabel = {
     let lbl = UILabel()
     lbl.textColor = .black
     lbl.textAlignment = .left
     return lbl
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews()
        // Do any additional setup after loading the view.
    }
    
    func setupSubviews(){
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.snp.makeConstraints{make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, idLabel, dateLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 5
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.snp.makeConstraints{ make in
            make.top.equalTo(imageView.snp.bottom)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().inset(5)
        }
    }
    
    func setInfo(image: UIImage, date: String, title: String, id: Int){
        imageView.image = image
        titleLabel.text = title
        titleLabel.sizeToFit()
        idLabel.text = "ID: \(id)"
        dateLabel.text = "Загружено "+date
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
