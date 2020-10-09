//
//  FlowLayout.swift
//  CalcND
//
//  Created by mst on 09.10.2020.
//  Copyright © 2020 mst. All rights reserved.
//

import UIKit

class FlowLayout: UICollectionViewFlowLayout {
    private var cellOffset: CGFloat = 0

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect) ?? []
        let attributesCount = attributes.count
        //  при добавлении широкой ячейки для следующих в ряду ломался minimumInteritemSpacing
        for i in 0..<attributesCount {
            if i > 0, attributes[i].frame.origin.x != sectionInset.left {
                let currentX = attributes[i].frame.origin.x
                let nesessaryX = attributes[i-1].frame.origin.x + attributes[i-1].frame.width + 2*minimumInteritemSpacing
                let difference = nesessaryX - currentX
                if difference > 1 {
                    attributes[i].frame.origin.x += difference
                }
            }
        }
        return attributes
    }
    
}
