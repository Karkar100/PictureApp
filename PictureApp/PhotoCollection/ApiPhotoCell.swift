//
//  PhotoCell.swift
//  PictureApp
//
//  Created by Diana Princess on 03.03.2022.
//

import UIKit
import SnapKit

class ApiPhotoCell: UICollectionViewCell {
    static let reuseId = "PhotoCell"
    private let titleLabel: UILabel = UILabel(frame: .zero)
    private let idLabel: UILabel = UILabel(frame: .zero)
    private let imageView: UIImageView = UIImageView(frame: .zero)

    override init(frame: CGRect) {
            super.init(frame: frame)
            setupSubviews()
        }
    
    required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    func setupSubviews(){
        imageView.contentMode = .scaleAspectFit
        titleLabel.contentMode = .scaleAspectFit
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        idLabel.contentMode = .scaleAspectFit
        idLabel.textAlignment = .left
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            
        }
        let stackView = UIStackView(arrangedSubviews: [titleLabel, idLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 4
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.snp.makeConstraints{ make in
            make.top.equalTo(imageView.snp.bottom)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    var isHeightCalculated: Bool = false

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        //Exhibit A - We need to cache our calculation to prevent a crash.
        if !isHeightCalculated {
            setNeedsLayout()
            layoutIfNeeded()
            let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
            var newFrame = layoutAttributes.frame
            newFrame.size.width = CGFloat(ceilf(Float(size.width)))
            layoutAttributes.frame = newFrame
            isHeightCalculated = true
        }
        return layoutAttributes
    }
    
    func configure(title: String, data: Data, id: Int){
        titleLabel.text = title
        imageView.image = UIImage(data: data)
        idLabel.text = "ID: \(id)"
        }
}

