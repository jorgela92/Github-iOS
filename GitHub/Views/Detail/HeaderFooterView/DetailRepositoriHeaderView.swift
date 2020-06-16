//
//  DetailRepositoriHeaderView.swift
//  GitHub
//
//  Created by Jorge Lapeña Antón on 14/06/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import UIKit

class DetailRepositoriHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = Color().colorTextTitle
        }
    }
    @IBOutlet weak var subtitleLabel: UILabel! {
        didSet {
            subtitleLabel.textColor = Color().colorTextSubtitle
        }
    }
    @IBOutlet weak var avatarHeaderImage: UIImageView! {
        didSet {
            avatarHeaderImage.layer.cornerRadius = CORNER_RADIUS_AVATAR_HEADER
        }
    }
    @IBOutlet weak var loginImage: UIImageView!
    @IBOutlet weak var separatorView: UIView! {
        didSet {
            separatorView.backgroundColor = Color().colorSeparatorView
        }
    }
    @IBOutlet weak var envaseView: UIView! {
        didSet {
            envaseView.backgroundColor = UIColor.white
        }
    }
    private let CORNER_RADIUS_AVATAR_HEADER: CGFloat = 5
}
