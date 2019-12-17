//
//  StickerCell.swift


import UIKit
import Messages

class StickerCell: UICollectionViewCell {
    
    @IBOutlet weak var stickerView: MSStickerView!
    @IBOutlet weak var lockButton: UIButton!
    
    private var allStickersUnlocked:Bool{
        return UserData().productPurchased
    }
    
    func configure(_ object: StickerObject){
        if let sticker = object.sticker{
            stickerView.sticker = sticker
            stickerView.isUserInteractionEnabled = (object.isFree || allStickersUnlocked)
        }
        lockButton.isHidden = object.isFree || allStickersUnlocked
    }
}
