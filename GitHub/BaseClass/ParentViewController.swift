//
//  ParentViewController.swift
//  GitHub
//
//  Created by Jorge Lapeña Antón on 10/06/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import UIKit

public class ParentViewController: UIViewController {

    private var hudView: HUDView?
    private var shadow: UIView!
    private var alert: CustomAlertViewController?
    private let ALERT_ERROR_IMAGE = "error"
    private let ALERT_ERROR_TITLE_RIGHT_BUTTON = "ok"
    private let MULTIPLIER_NSLAYOUT_CONSTRAINT: CGFloat = 1
    private let CONSTANT_NSLAYOUT_CONSTRAINT: CGFloat = 0
    private let ANIMATE_DURATION = 0.2
    private let ACTIVITY_INDICATOR_CGAFFINE_TRANSFORM: CGFloat = 0.7
    private let ACTIVITY_INDICATOR_CGAFFINE_TRANSFORM_ANIMATION: CGFloat = 1.3
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

//MARK: - public methods -
extension ParentViewController {
    func showHUD(_ text: String? = nil) {
        if !self.view.isUserInteractionEnabled {
            self.view.isUserInteractionEnabled = false
        }
        
        DispatchQueue.main.async {
            guard let window = self.view.window else { return }
            if let text = text, let _ = self.hudView {
                self.updateHUDText(text: text)
                return
            }
            
            if let text = text, self.hudView == nil {
                self.hudView = HUDView.init(text: text)
                
            } else if self.hudView == nil {
                self.hudView = HUDView.init()
            }
            
            if self.shadow == nil {
                self.shadow = UIView()
            }
            
            window.addSubview(self.shadow)
            self.shadow.translatesAutoresizingMaskIntoConstraints = false
            self.shadow.backgroundColor = .clear
            NSLayoutConstraint.activate(
                [NSLayoutConstraint(item: self.shadow!, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: window, attribute: NSLayoutConstraint.Attribute.top, multiplier: self.MULTIPLIER_NSLAYOUT_CONSTRAINT, constant: self.CONSTANT_NSLAYOUT_CONSTRAINT),
                 NSLayoutConstraint(item: self.shadow!, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: window, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: self.MULTIPLIER_NSLAYOUT_CONSTRAINT, constant: self.CONSTANT_NSLAYOUT_CONSTRAINT),
                 NSLayoutConstraint(item: self.shadow!, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: window, attribute: NSLayoutConstraint.Attribute.leading, multiplier: self.MULTIPLIER_NSLAYOUT_CONSTRAINT, constant: self.CONSTANT_NSLAYOUT_CONSTRAINT),
                 NSLayoutConstraint(item: self.shadow!, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: window, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: self.MULTIPLIER_NSLAYOUT_CONSTRAINT, constant: self.CONSTANT_NSLAYOUT_CONSTRAINT)
            ])
            
            self.hudView?.activityIndicator?.transform = CGAffineTransform(scaleX: self.ACTIVITY_INDICATOR_CGAFFINE_TRANSFORM, y: self.ACTIVITY_INDICATOR_CGAFFINE_TRANSFORM)
            window.addSubview(self.hudView!)
            
            UIView.animate(withDuration: self.ANIMATE_DURATION, animations: {
                self.hudView?.activityIndicator?.transform = CGAffineTransform(scaleX: self.ACTIVITY_INDICATOR_CGAFFINE_TRANSFORM_ANIMATION, y: self.ACTIVITY_INDICATOR_CGAFFINE_TRANSFORM_ANIMATION)
            }, completion: { (completed) in
                UIView.animate(withDuration: self.ANIMATE_DURATION, animations: {
                    self.hudView?.activityIndicator?.transform = CGAffineTransform.identity
                })
            })
        }
    }
    
    func hideHUD() {
        if view.isUserInteractionEnabled {
            view.isUserInteractionEnabled = true
        }
        
        DispatchQueue.main.async {
            if let shadow = self.shadow {
                shadow.removeFromSuperview()
                self.shadow = nil
            }
            if let hud = self.hudView {
                hud.hide()
                self.hudView = nil
            }
        }
    }
    
    func alertError(error: String, tag: Int = 0) {
        alert = CustomAlertViewController(imageViewName: ALERT_ERROR_IMAGE, titleText: nil, descriptionText: error, leftButtonTitle: nil, rightButtonTitle: ALERT_ERROR_TITLE_RIGHT_BUTTON.localized, alertTag: tag)
        alert?.delegate = self
        present(alert!, animated: true)
    }
    
    func openURL(url: String) {
        if let navigationController = self.navigationController as? ParentNavigationController {
            navigationController.openURL(url)
        }
    }
    
    func openDetailGenericViewController(manager: RepositorieDetailManager) {
        if let navigationController = self.navigationController as? ParentNavigationController {
            navigationController.openDetailGenericViewController(manager: manager)
        }
    }
}

//MARK: - private methods -
extension ParentViewController {
    private func configureUI() {
        view.backgroundColor = Color().colorBackground
    }
    
    private func updateHUDText(text: String) {
        if let hud = self.hudView {
            hud.label.text = text
        } else {
            showHUD(text)
        }
    }
    
    private func dismissPresentedView() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - CustomAlertViewDelegate
extension ParentViewController: CustomAlertViewDelegate {
    public func leftAlertButtonClicked(tag: Int) {
        
    }
    
    public func rightAlertButtonClicked(tag: Int) {
        alert?.dismiss(animated: true)
        switch tag {
            case 1:
                dismissPresentedView()
                break
            default:
                break
        }
    }
}
