//
//  StickerCollectionViewController.swift


import UIKit
import Messages
import StoreKit

class StickerCollectionViewController: UIViewController {

    var dataSource = [StickerObject]()
    var userData = UserData()
    var useBackgroundImage = true
    var backgroundColor = UIColor(hexString: "FBB975")//Set whatever color you need
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func handleUnlockBtnTap(_ sender: UIButton) {
        purchaseProduct()
    }
    
    @IBAction func handleRestoreBtnTap(_ sender: UIButton) {
        ActivityIndicatorManager.shared.startActivityIndicator(on: self)
        IAPHelper.shared.restorePurchases()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObservers()
        configureView()
        loadStickerData()
    }
    
    private func addObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(purchaseSuccessNotificationHandler), name: .SuccessPurchaseNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(purchaseFailedNotificationHandler), name: .FailedPurchaseNotification, object: nil)
    }
    
    private func configureView(){
        collectionView.register(UINib(nibName: Storyboard.bottomCollectionView, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: Storyboard.bottomCollectionViewID)
        
        if useBackgroundImage, let backgroundImage = UIImage(named: "background"){
            backgroundImageView.image = backgroundImage
        }else{
            backgroundImageView.isHidden = true
            view.backgroundColor = backgroundColor
        }
    }
    
    /*
     * Parse data from StickerData.plist and create data source for sticker collection view
     */
    private func loadStickerData(){
        if let path = Bundle.main.path(forResource: "StickerData", ofType: ".plist") {
            if let data = NSArray(contentsOfFile: path) as? [Dictionary<String, Any>]{
                data.forEach { (item) in
                    let id = item["id"] as! Int
                    let name = item["name"] as! String
                    let isFree = item["isFree"] as! Bool
                    
                    let stickerObject = StickerObject(id: id, name: name, isFree: isFree)
                    dataSource.append(stickerObject)
                }
            }
        }
    }
    
    func purchaseProduct(){
        ActivityIndicatorManager.shared.startActivityIndicator(on: self)
        IAPHelper.shared.requestProducts { (success, products) in
            products?.forEach({ (product) in
                IAPHelper.shared.buyProduct(product)
            })
        }
    }
    
    @objc func purchaseSuccessNotificationHandler(){
        ActivityIndicatorManager.shared.stopActivityIndicator()
        unlockAllItems()
    }
    
    @objc func purchaseFailedNotificationHandler(){
        ActivityIndicatorManager.shared.stopActivityIndicator()
    }
    
    func unlockAllItems(){
        userData.productPurchased = true
        collectionView.reloadData()
    }
}


extension StickerCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.cellIdentifier, for: indexPath) as! StickerCell
        
        cell.configure(dataSource[indexPath.row])
        
        return cell
    }
    
    /*
     * Return collection view footer with the "More Apps" collection
    */
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind{
        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Storyboard.bottomCollectionViewID, for: indexPath) as! BottomCollectionView
            footerView.delegate = self
            if MoreAppsDataManager.shared.dataSource.count == 0{
                footerView.frame = CGRect.zero
            }
            return footerView
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !dataSource[indexPath.row].isFree || userData.productPurchased{
            purchaseProduct()
        }
    }
    
}

extension StickerCollectionViewController: MessageExtensionDelegate{
    
    func openStoreApp(id: String){
        if let idNumber = Int(id){
            openStoreProductWithiTunesItemIdentifier(idNumber)
        }
    }
    
    private func openStoreProductWithiTunesItemIdentifier(_ identifier: Int) {
        let storeViewController = SKStoreProductViewController()
        storeViewController.delegate = self
        
        let parameters = [ SKStoreProductParameterITunesItemIdentifier : identifier]
        storeViewController.loadProduct(withParameters: parameters, completionBlock: nil)
        present(storeViewController, animated: true, completion: nil)
    }
}

extension StickerCollectionViewController: SKStoreProductViewControllerDelegate{
    
    func productViewControllerDidFinish(_ viewController: SKStoreProductViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
}
