//
//  UserDataCache.swift

import Foundation
struct UserData {
    
    private let userDefaults:UserDefaults

    var productPurchased:Bool{
        get {
            return userDefaults.bool(forKey: IAPHelper.unlockAllProductId)
        }
        set {
            userDefaults.set(newValue, forKey: IAPHelper.unlockAllProductId)
        }
    }
    

    init() {
        self.userDefaults = Foundation.UserDefaults()
        userDefaults.register(defaults: [
                IAPHelper.unlockAllProductId: false])
    }

}
