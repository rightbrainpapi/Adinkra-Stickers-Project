//
//  AlertManager.swift


import UIKit

class AlertManager{
    
    static let shared = AlertManager()
    
    func showInfoAlert(title: String?, message:String?, on viewController: UIViewController, completion: (() -> ())?){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: AppString.ok.capitalized, style: .default, handler: nil)
            alert.addAction(action)
            viewController.present(alert, animated: true, completion: completion)
        }
    }
    
}
