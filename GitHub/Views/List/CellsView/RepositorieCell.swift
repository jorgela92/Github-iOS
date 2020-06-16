//
//  RepositorieCell.swift
//  GitHub
//
//  Created by Jorge Lapeña Antón on 10/06/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import UIKit

class RepositorieCell: UITableViewCell {
    
    @IBOutlet weak var imageType: UIImageView!
    @IBOutlet weak var labelName: UILabel! {
        didSet {
            labelName.textColor = Color().colorTextTitle
        }
    }
    @IBOutlet weak var labelLogin: UILabel! {
        didSet {
            labelLogin.textColor = Color().colorTextSubtitle
        }
    }
    @IBOutlet weak var labelDescription: UILabel! {
        didSet {
            labelDescription.textColor = Color().colorTextDetail
        }
    }
    @IBOutlet weak var envaseView: UIView! {
        didSet {
            envaseView.backgroundColor = UIColor.white
            envaseView.addRoundCornersView(corners: [UIRectCorner.topLeft, UIRectCorner.topRight, UIRectCorner.bottomLeft, UIRectCorner.bottomRight], radius: RADIUS_VIEW)
        }
    }
    @IBOutlet weak var borderView: UIView! {
        didSet {
            borderView.backgroundColor = Color().colorBorderView
            borderView.addRoundCornersView(corners: [UIRectCorner.topLeft, UIRectCorner.topRight, UIRectCorner.bottomLeft, UIRectCorner.bottomRight], radius: RADIUS_VIEW)
        }
    }
    @IBOutlet weak var shadowView: UIView! {
        didSet {
            shadowView.backgroundColor = Color().colorShadowView
            shadowView.addRoundCornersView(corners: [UIRectCorner.topLeft, UIRectCorner.topRight, UIRectCorner.bottomLeft, UIRectCorner.bottomRight], radius: RADIUS_VIEW)
        }
    }
    
    private let RADIUS_VIEW: CGFloat = 5
}
