//
//  StickerObject.swift

import Messages

struct StickerObject {
    
    var id:Int
    var name:String
    var isFree: Bool

    var sticker: MSSticker?
    
    init(id: Int, name: String, isFree:Bool) {
        self.id = id
        self.name = name
        self.isFree = isFree
        
        sticker = createSticker(assetName: name, assetDescription: name)
    }
    
    private func createSticker(assetName: String, assetDescription: String) -> MSSticker? {
        guard let path = Bundle.main.path(forResource: assetName, ofType: "") else {
            return nil
        }
        let url = URL(fileURLWithPath: path)
        
        do {
            let sticker = try MSSticker(contentsOfFileURL: url, localizedDescription: assetDescription)
            return sticker
        } catch {
            print(error)
        }
        return nil
    }
}
