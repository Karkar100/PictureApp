//
//  PhotoCell.swift
//  PictureApp
//
//  Created by Diana Princess on 03.03.2022.
//

import UIKit

class APIPhotoCell: UICollectionViewCell {
    lazy var oneImage : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        /*
        let leftConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: backgroundView, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: backgroundView, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: backgroundView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: backgroundView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
        backgroundView?.addConstraints([leftConstraint, rightConstraint, topConstraint, bottomConstraint])
    */
        return imageView
    }()
    let stackView: UIStackView = {
            let sv = UIStackView()
        sv.axis  = NSLayoutConstraint.Axis.horizontal
        sv.alignment = UIStackView.Alignment.center
        sv.distribution = UIStackView.Distribution.fillEqually
            sv.translatesAutoresizingMaskIntoConstraints = false;
            return sv
        }()
    override init(frame: CGRect) {
            super.init(frame: frame)

            addViews()
        }
    func addViews(){
            backgroundColor = .black
            addSubview(oneImage)
        oneImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        oneImage.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        oneImage.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        oneImage.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
    }
    required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}

