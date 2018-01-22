//
//  ViewControllerC.swift
//  KeyboardSupport_Example
//
//  Copyright © 2017 Bottle Rocket Studios. All rights reserved.
//

import UIKit
import KeyboardSupport

/// Demonstrates that a collection view with text fields can use KeyboardSupport. However not all configurations are supported.
class ViewControllerC: KeyboardSupportViewController {

    // MARK: - Properties
    
    @IBOutlet private var collectionView: UICollectionView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        let configuration = KeyboardSupportConfiguration(scrollView: collectionView, usesDismissalView: true)
        configureKeyboardSupport(with: configuration)
    }
}

// MARK: - UICollectionViewDataSource

extension ViewControllerC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CollectionViewCell.self), for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
}
