//
//  FooterCollectionViewCell.swift


import UIKit

class BottomCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var appIconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureView()
    }
    
    private func configureView(){
        appIconImageView.layer.cornerRadius = 15.0
        appIconImageView.layer.borderWidth = 1.0
        appIconImageView.layer.borderColor = UIColor.clear.cgColor
        appIconImageView.layer.masksToBounds = true
        
        appIconImageView.layer.shadowColor = UIColor.lightGray.cgColor
        appIconImageView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        appIconImageView.layer.shadowRadius = 2.0
        appIconImageView.layer.shadowOpacity = 1.0
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        appIconImageView.clipsToBounds = true
    }
    
}
