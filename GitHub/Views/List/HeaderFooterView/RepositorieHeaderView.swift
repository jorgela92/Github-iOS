//
//  RepositorieHeaderView.swift
//  GitHub
//
//  Created by Jorge Lapeña Antón on 11/06/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import UIKit

protocol RepositorieHeaderViewDelegate {
    func closeSearch()
    func search(text: String?)
}

class RepositorieHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var searchText: UITextField!{
        didSet {
            searchText.attributedPlaceholder = NSAttributedString(string: PLACEHOLDER_TEXT.localized.capitalized, attributes: [NSAttributedString.Key.foregroundColor: Color().colorTextPlaceholder])
            searchText.textColor = UIColor.white
        }
    }
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var closeImage: UIImageView! {
        didSet {
            closeImage.tintColor = UIColor.white
        }
    }
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchImage: UIImageView! {
        didSet {
            searchImage.tintColor = UIColor.white
        }
    }
    @IBOutlet weak var envaseView: UIView! {
        didSet {
            envaseView.backgroundColor = Color().colorPrimaryVariant
            envaseView.addRoundCornersView(corners: [UIRectCorner.bottomRight, UIRectCorner.bottomLeft], radius: RADIUS_VIEW)
        }
    }
    @IBOutlet weak var shadowView: UIView! {
        didSet {
            shadowView.backgroundColor = Color().colorPrimaryVariant
            shadowView.addRoundCornersView(corners: [UIRectCorner.bottomRight, UIRectCorner.bottomLeft], radius: RADIUS_VIEW)
        }
    }
    
    var delegate: RepositorieHeaderViewDelegate?
    private let RADIUS_VIEW: CGFloat = 5
    private let PLACEHOLDER_TEXT = "search"
    
    @IBAction func searchAction(_ sender: UIButton) {
        delegate?.search(text: searchText.text)
    }
    
    @IBAction func clseAction(_ sender: UIButton) {
        delegate?.closeSearch()
    }
}
