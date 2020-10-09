//
//  SmallCollectionViewCell.swift
//  CalcND
//
//  Created by mst on 09.10.2020.
//  Copyright © 2020 mst. All rights reserved.
//

import UIKit

class KeyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var circleView: UIView!

    override var isHighlighted: Bool {
        didSet {
            let color = circleView.backgroundColor
            UIView.animate(withDuration: 0.3,
                           delay: 0,
                           options: [.autoreverse],
                           animations: {
                            self.circleView.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                    }, completion: { (_) in
                        self.circleView.backgroundColor = color
            })
        }
    }

    func update(key: Key, cornerRadius: CGFloat) {
        key.delegate = self
        textLabel.text = key.text
        textLabel.textColor = key.textColor
        circleView.backgroundColor = key.color
        circleView.layer.cornerRadius = cornerRadius
        circleView.clipsToBounds = true
        if case .zero = key.type {
            textLabel.textAlignment = .left
        }
        else {
            textLabel.textAlignment = .center
        }
    }
}

extension KeyCollectionViewCell: KeyDelegate {
    func keyUpdate(_ key: Key) {
        textLabel.text = key.text
    }
}
