//
//  Color.swift
//  GitHub
//
//  Created by Jorge Lapeña Antón on 16/06/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import UIKit

class Color {
    public var colorPrimary: UIColor {
        get {
            return UIColor(displayP3Red: 36/255, green: 41/255, blue: 46/255, alpha: 1)
        }
    }
    
    public var colorPrimaryVariant: UIColor {
        get {
            return UIColor(displayP3Red: 64/255, green: 68/255, blue: 72/255, alpha: 1)
        }
    }
    
    public var colorSecondary: UIColor {
        get {
            return UIColor(displayP3Red: 105/255, green: 108/255, blue: 112/255, alpha: 1)
        }
    }
    
    public var colorBackground: UIColor {
        get {
            return UIColor(displayP3Red: 250/255, green: 251/255, blue: 252/255, alpha: 1)
        }
    }
    
    public var colorTextTitle: UIColor {
        get {
            return UIColor(displayP3Red: 49/255, green: 130/255, blue: 221/255, alpha: 1)
        }
    }
    
    public var colorTextSubtitle: UIColor {
        get {
            return UIColor(displayP3Red: 137/255, green: 183/255, blue: 235/255, alpha: 1)
        }
    }
    
    public var colorTextDetail: UIColor {
        get {
            return UIColor(displayP3Red: 149/255, green: 155/255, blue: 160/255, alpha: 1)
        }
    }
    
    public var colorTextDetailSecondary: UIColor {
        get {
            return UIColor(displayP3Red: 191/255, green: 195/255, blue: 199/255, alpha: 1)
        }
    }
    
    public var colorTextPlaceholder: UIColor {
        get {
            return UIColor(displayP3Red: 95/255, green: 99/255, blue: 102/255, alpha: 1)
        }
    }
    
    public var colorSeparatorView: UIColor {
        get {
            return UIColor(displayP3Red: 246/255, green: 247/255, blue: 248/255, alpha: 1)
        }
    }
    
    public var colorShadowView: UIColor {
        get {
            return UIColor(displayP3Red: 241/255, green: 242/255, blue: 244/255, alpha: 1)
        }
    }
    
    public var colorBorderView: UIColor {
        get {
            return UIColor(displayP3Red: 227/255, green: 229/255, blue: 232/255, alpha: 1)
        }
    }
}
