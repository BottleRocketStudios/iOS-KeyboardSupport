//
//  ViewControllerC.swift
//  KeyboardSupport_Example
//
//  Created by Earl Gaspard on 12/19/17.
//  Copyright © 2017 Bottle Rocket Studios. All rights reserved.
//

import UIKit
import KeyboardSupport

/// Demonstrates that a collection view can use KeyboardRespondable.
class ViewControllerC: UIViewController, KeyboardRespondable {

    // MARK: - Properties
    
    @IBOutlet private var collectionView: UICollectionView!
    
    // MARK: - KeyboardRespondable
    
    var keyboardScrollableScrollView: UIScrollView?
    var keyboardWillShowObserver: NSObjectProtocol?
    var keyboardWillHideObserver: NSObjectProtocol?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        keyboardScrollableScrollView = collectionView
        setupKeyboardRespondable()
        collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
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
