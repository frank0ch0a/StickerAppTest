//
//  StickersCollectionViewController.swift
//  StickerApp
//
//  Created by Francisco Ochoa on 17/11/17.
//  Copyright © 2017 Francisco Ochoa. All rights reserved.
//

import UIKit

private let stickerReuseIdentifier = "stickerCell"

class StickersCollectionViewController: UICollectionViewController {
    weak var delegate: StickerImageSelectable?
    let stickers = [
        UIImage(named: "lobster")!,
        UIImage(named: "scubabuddy")!,
        UIImage(named: "scubaparrot")!,
        UIImage(named: "shark")!,
        UIImage(named: "wreckdiving")!
    ]
    
    init() {
        super.init(collectionViewLayout: StickersCollectionViewController.provideCollectionViewLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell classes
        if let collectionView = self.collectionView {
            collectionView.register(StickerCollectionViewCell.self, forCellWithReuseIdentifier: stickerReuseIdentifier)
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.backgroundColor = .clear
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    class func provideCollectionViewLayout() -> UICollectionViewFlowLayout {
        let screenWidth = UIScreen.main.bounds.width
        let itemSize = screenWidth * 0.293
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumLineSpacing = 7.0
        layout.minimumInteritemSpacing = 7.0
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 5.0, left: 10.0, bottom: 5.0, right: 10.0)
        return layout
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stickers.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: stickerReuseIdentifier, for: indexPath) as? StickerCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.image = stickers[indexPath.row]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectSticker(image: stickers[indexPath.row])
    }
}

protocol StickerImageSelectable: class {
    func didSelectSticker(image: UIImage)
}

