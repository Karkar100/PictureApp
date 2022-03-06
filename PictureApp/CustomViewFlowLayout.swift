//
//  CustomViewLayout.swift
//  PictureApp
//
//  Created by Diana Princess on 05.03.2022.
//

import UIKit

class CustomViewFlowLayout: UICollectionViewFlowLayout {
    //override var estimatedItemSize: CGSize { return .zero}
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
