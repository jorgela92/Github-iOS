//
//  DetailBaseCell.swift
//  GitHub
//
//  Created by Jorge Lapeña Antón on 14/06/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import UIKit

class DetailBaseCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = Color().colorTextDetailSecondary
        }
    }
    @IBOutlet weak var subtitleLable: UILabel! {
        didSet {
            subtitleLable.textColor = Color().colorTextDetail
        }
    }
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
}
