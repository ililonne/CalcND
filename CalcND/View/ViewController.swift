//
//  ViewController.swift
//  CalcND
//
//  Created by mst on 09.10.2020.
//  Copyright © 2020 mst. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    private let countOfKeysInRow: CGFloat = 4

    private let manager = CalculationManager()

    private lazy var commonKeysWidth: CGFloat = {
        guard let layout = collectionView.collectionViewLayout as? FlowLayout else {
            return .zero
        }
        let screenWidth = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
        return screenWidth - layout.sectionInset.left - layout.sectionInset.right - layout.minimumInteritemSpacing*(countOfKeysInRow-1)*2
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionViewHeight.constant = collectionView.collectionViewLayout.collectionViewContentSize.height
    }
}

extension MainViewController: CalculationManagerDelegate {
    func showResult(_ result: String) {
        resultLabel.text = result
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 19
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KeyCollectionViewCell", for: indexPath) as? KeyCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.update(key: manager.keys[indexPath.item], cornerRadius: commonKeysWidth/countOfKeysInRow/2)
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let layout = collectionViewLayout as? FlowLayout else {
            return .zero
        }
        let keyWidth: CGFloat
        if case .zero = manager.keys[indexPath.item].type {
            keyWidth = commonKeysWidth/2 + layout.minimumInteritemSpacing*2
        }
        else {
            keyWidth = commonKeysWidth/countOfKeysInRow
        }
        return CGSize(width: keyWidth, height: commonKeysWidth/countOfKeysInRow)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        manager.selectKey(index: indexPath.item)
    }
}
