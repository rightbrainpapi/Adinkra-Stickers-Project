//
//  FooterDataManager.swift


import UIKit

struct MoreAppsDataManager {
    
    static let shared = MoreAppsDataManager()
    
    let developerId = "R2L48HN2KT"
    let lookupUrl = "https://itunes.apple.com/lookup?id=%@&entity=software"
    
    var dataSource = [[String: UIImage]]()
    
    init() {
        loadDeveloperAppsData()
    }
    
    private mutating func loadDeveloperAppsData(){
        let urlStr = String(format: lookupUrl, developerId)
        let url = URL(string: urlStr)!
        if let data = try? Data(contentsOf: url){
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                if let results = json?["results"] as? [[String: Any]]{
                    if results.count > 0{
                        results.forEach { (result) in
                            if let artworkUrlStr = result["artworkUrl512"] as? String, let artworkUrl = URL(string: artworkUrlStr), let idNumber = result["trackId"] as? Int{
                                
                                if let imageData = try? Data(contentsOf: artworkUrl){
                                    if let artworkImage = UIImage(data: imageData){
                                        let item = [String(idNumber): artworkImage]
                                        self.dataSource.append(item)
                                    }
                                }
                            }
                        }
                    }
                }
                
            } catch {
                print("Error -> \(error)")
            }
        }
    }
}
