//
//  LoadingCell.swift
//  GitHub
//
//  Created by Jorge Lapeña Antón on 10/06/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import UIKit

class LoadingCell: UITableViewCell {

    @IBOutlet weak var loading: UIActivityIndicatorView! {
        didSet {
            loading.color = Color().colorPrimaryVariant
        }
    }
}
