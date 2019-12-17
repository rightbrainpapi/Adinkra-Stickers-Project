//
//  MessagesViewController.swift


import UIKit
import Messages

protocol MessageExtensionDelegate: class {
    func openStoreApp(id: String)
}

class MessagesViewController: MSMessagesAppViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    // MARK: - Conversation Handling
    
    override func willBecomeActive(with conversation: MSConversation) {
        super.willBecomeActive(with: conversation)
        let _ = MoreAppsDataManager.shared
        
        let _ = IAPHelper.shared
        
        setAppTheme()
        
        present(with: self.presentationStyle)
    }
    
    private func setAppTheme(){
        UILabel.appearance().substituteFontColor = UIColor(hexString: "000000")
        UIButton.appearance().substituteFontColor = UIColor(hexString: "000000")
        UIFont.overrideInitialize()
    }
    
    override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        super.didTransition(to: presentationStyle)
        
        present(with: presentationStyle)
    }
    
    private func present(with presentationStyle:MSMessagesAppPresentationStyle) {
        // Remove any existing child controllers.
        let viewController = UIStoryboard(name: Storyboard.mainInterface, bundle: nil).instantiateViewController(withIdentifier: Storyboard.stickerVCIdentifier) as! StickerCollectionViewController
        
        for child in children {
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
        // Embed the new controller.
        addChild(viewController)
        
        viewController.view.frame = view.bounds
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewController.view)
        
        viewController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        viewController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        viewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        viewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        viewController.didMove(toParent: self)
    }
    
}
