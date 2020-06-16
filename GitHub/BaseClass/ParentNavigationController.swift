//
//  ParentNavigationController.swift
//  GitHub
//
//  Created by Jorge Lapeña Antón on 14/06/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import UIKit

class ParentNavigationController: UINavigationController, UIGestureRecognizerDelegate {
    
    private let IMAGE_EDGE_INSETS: CGFloat = 8
    private let STORYBOARD = "Main"
    private let BACK_BUTTON = "backButton"
    private let BACK_BUTTON_IMAGE = "arrowLeft"
    private let BACK_BUTTON_WIDTH: CGFloat = 45
    private let BACK_BUTTON_HEIGT: CGFloat = 40
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        viewController.navigationItem.setHidesBackButton(true, animated: false)
    }
}

//MARK: - public methods -
extension ParentNavigationController {
    
      func openURL(_ url: String) {
          if UIApplication.shared.canOpenURL(URL.init(string: url)!) {
              if #available(iOS 10.0, *) {
                  UIApplication.shared.open(URL.init(string: url)!)
              } else {
                  UIApplication.shared.openURL(URL.init(string: url)!)
              }
          }
      }
      
      func openDetailGenericViewController(manager: DetailGenericViewModelDelegate) {
          let repositorieDetailViewController = UIStoryboard(name: STORYBOARD, bundle: nil).instantiateViewController(withIdentifier: String(describing: DetailGenericViewController.self)) as! DetailGenericViewController
          repositorieDetailViewController.initVM(manager: manager)
          pushViewController(repositorieDetailViewController, animated: true)
      }
}

//MARK: - private methods -
extension ParentNavigationController {
    private func configureNavigationBar() {
        delegate = self
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = Color().colorPrimary
        navigationBar.barStyle = .black
        navigationBar.tintColor = .white
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        interactivePopGestureRecognizer?.delegate = self
        let defaultNavigationBarFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: navigationBar.frame.height + UIApplication.shared.statusBarFrame.height)
        navigationBar.frame = defaultNavigationBarFrame
    }
    
    private func backButtonItem() -> UIBarButtonItem {
        let button = UIButton()
        button.setImage(UIImage(named: BACK_BUTTON_IMAGE), for: .normal)
        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: BACK_BUTTON_WIDTH, height: BACK_BUTTON_HEIGT)
        buttonImageInstets(buttonName: button)
        button.widthAnchor.constraint(equalToConstant: BACK_BUTTON_WIDTH).isActive = true
        button.heightAnchor.constraint(equalToConstant: BACK_BUTTON_HEIGT).isActive = true
        button.accessibilityIdentifier = BACK_BUTTON
        return UIBarButtonItem(customView: button)
    }
    
    @objc private func backAction() {
        popViewController(animated: true)
    }
    
    private func buttonImageInstets(buttonName: UIButton){
        buttonName.imageEdgeInsets.bottom = IMAGE_EDGE_INSETS
        buttonName.imageEdgeInsets.left = IMAGE_EDGE_INSETS
        buttonName.imageEdgeInsets.top = IMAGE_EDGE_INSETS
        buttonName.imageEdgeInsets.right = IMAGE_EDGE_INSETS
    }
}

//MARK: - UINavigationControllerDelegate
extension ParentNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        viewController.modalPresentationStyle = .fullScreen
        if !(viewController is ListViewController) {
            viewController.navigationItem.leftBarButtonItem = backButtonItem()
        }
    }
}
