//
//  FooterView.swift

import UIKit

class BottomCollectionView: UICollectionReusableView {
    
    weak var delegate:MessageExtensionDelegate?
    var dataSource = MoreAppsDataManager.shared.dataSource
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        configure()
    }
    
    func configure(){
        collectionView.register(UINib(nibName: Storyboard.bottomCollectionCell, bundle: nil), forCellWithReuseIdentifier: Storyboard.bottomCollectionCellId)
    }
    
}

extension BottomCollectionView: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.bottomCollectionCellId, for: indexPath) as! BottomCollectionCell
        let itemToShow = dataSource[indexPath.row].values.first
        cell.appIconImageView.image = itemToShow
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let appId = dataSource[indexPath.row].keys.first{
            delegate?.openStoreApp(id: appId)
        }
    }
}
