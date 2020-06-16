//
//  CustomAlertViewController.swift
//  GitHub
//
//  Created by Jorge Lapeña Antón on 10/06/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import UIKit

public protocol CustomAlertViewDelegate: class {
    func leftAlertButtonClicked(tag: Int)
    func rightAlertButtonClicked(tag: Int)
}

public final class CustomAlertViewController: UIViewController {

    @IBOutlet weak var alphaView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var topToContainerTitleConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingToContainerRightButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingToContainerLeftButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingRightButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var leadingLeftButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleSeparatorView: UIView!
    
    private var imageViewName: String?
    private var titleText: String?
    private var descriptionText: String?
    private var leftButtonTitle: String?
    private var rightButtonTitle: String?
    private var alertTag = 0
    
    private var animator: Transition? = Transition()
    
    private let BORDER_WIDTH_BUTTON: CGFloat = 1
    private let CORNER_RADIUS_BUTTON: CGFloat = 17
    private let CORNER_RADIUS: CGFloat = 5
    private let CONSTRAINT_BUTTON: CGFloat = 70
    private let LAYOUT_PRIORITY: Float = 999
    
    weak var delegate: CustomAlertViewDelegate?

    init(imageViewName: String?, titleText: String?, descriptionText: String?, leftButtonTitle: String?, rightButtonTitle: String?, alertTag: Int = 0) {
        self.imageViewName = imageViewName
        self.titleText = titleText
        self.descriptionText = descriptionText
        self.leftButtonTitle = leftButtonTitle
        self.rightButtonTitle = rightButtonTitle
        self.alertTag = alertTag
        animator?.animationType = .peekAndPop
        
        super.init(nibName: String(describing: CustomAlertViewController.self), bundle: nil)
        
        self.transitioningDelegate = animator
        self.modalPresentationStyle = .custom
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureUI()
    }
    
    
    
    @IBAction func leftButtonAction(_ sender: Any) {
        delegate?.leftAlertButtonClicked(tag: alertTag)
        dismiss(animated: true)
    }
    
    @IBAction func rightButtonAction(_ sender: Any) {
        delegate?.rightAlertButtonClicked(tag: alertTag)
    }
}

//MARK: - private methods -
extension CustomAlertViewController  {
    private func configureUI() {
        DispatchQueue.main.async {
            self.containerView.layer.cornerRadius = self.CORNER_RADIUS
            self.leftButton.layer.cornerRadius = self.CORNER_RADIUS_BUTTON
            self.leftButton.layer.borderWidth = self.BORDER_WIDTH_BUTTON
            self.leftButton.layer.borderColor = Color().colorPrimary.cgColor
            self.rightButton.layer.cornerRadius = self.CORNER_RADIUS_BUTTON
            self.rightButton.layer.borderWidth = self.BORDER_WIDTH_BUTTON
            self.rightButton.layer.borderColor = Color().colorPrimary.cgColor
        }
    }
    
    private func setup() {
        if let imageViewName = imageViewName {
            topImageView.image = UIImage(named: imageViewName)
        } else {
            topImageView.isHidden = true
            topToContainerTitleConstraint.priority = UILayoutPriority(rawValue: LAYOUT_PRIORITY)
        }
        
        if let titleText = titleText {
            titleLabel.text = titleText
        } else {
            titleLabel.text = ""
            titleSeparatorView.isHidden = true
        }
        
        if let descriptionText = descriptionText {
            descriptionLabel.text = descriptionText
        } else {
            descriptionLabel.text = ""
        }
        
        if let leftButtonTitle = leftButtonTitle {
            leftButton.setTitle(leftButtonTitle, for: .normal)
        } else {
            leftButton.isHidden = true
            trailingRightButtonConstraint.constant = CONSTRAINT_BUTTON
            leadingToContainerRightButtonConstraint.priority = UILayoutPriority(rawValue: LAYOUT_PRIORITY)
        }
        
        if let rightButtonTitle = rightButtonTitle {
            rightButton.setTitle(rightButtonTitle, for: .normal)
        } else {
            rightButton.isHidden = true
            leadingLeftButtonConstraint.constant = CONSTRAINT_BUTTON
            trailingToContainerLeftButtonConstraint.priority = UILayoutPriority(rawValue: LAYOUT_PRIORITY)
        }
        view.layoutIfNeeded()
    }
}
