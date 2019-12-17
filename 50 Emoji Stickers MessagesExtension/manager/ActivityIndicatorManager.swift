//
//  ActivityIndicatorManager.swift

import UIKit

class ActivityIndicatorManager{
    
    let indicatorSideLength:CGFloat = 50
    
    private var coverView: UIView!
    
    lazy var nativeIndicatorView: UIActivityIndicatorView = {
        let indicatorFrame = CGRect(x: (UIScreen.main.bounds.width - indicatorSideLength)/2, y: (UIScreen.main.bounds.height - indicatorSideLength)/2, width: indicatorSideLength, height: indicatorSideLength)
        let indicatorView = UIActivityIndicatorView(frame: indicatorFrame)
        indicatorView.style = .whiteLarge
        return indicatorView
    }()
    
    class var shared: ActivityIndicatorManager {
        struct Singleton {
            static let instance = ActivityIndicatorManager()
        }
        return Singleton.instance
    }
    
    func startActivityIndicator(on viewController: UIViewController){
        DispatchQueue.main.async {
            self.addFadeView(controller: viewController)
            viewController.view.addSubview(self.nativeIndicatorView)
            self.nativeIndicatorView.startAnimating()
        }
    }
    
    private func addFadeView(controller: UIViewController) {
        let screenRect = UIScreen.main.bounds
        self.coverView = UIView(frame: screenRect)
        self.coverView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        controller.view.addSubview(self.coverView)
    }
    
    func stopActivityIndicator(){
        coverView?.removeFromSuperview()
        nativeIndicatorView.stopAnimating()
        nativeIndicatorView.removeFromSuperview()
    }
}
