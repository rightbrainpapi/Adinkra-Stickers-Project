//
//  StringExt.swift


import Foundation

extension String{
    
    var numericAppIdPart: String?{
        get{
            let idString = "id"
            guard self.contains(idString) else{
                return nil
            }
            return self.replacingOccurrences(of: idString, with: "")
        }
    }
}
