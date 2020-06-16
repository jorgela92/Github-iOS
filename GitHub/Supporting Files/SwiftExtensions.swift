//
//  File.swift
//  GitHub
//
//  Created by Jorge Lapeña Antón on 10/06/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import Foundation
import UIKit

//MARK: - String
extension String {
    private static let LOCALE = "es_ES"
    private static let DATE_FORMAT = "yyyy-MM-dd'T'HH:mm:ssZ"
    private static let DATE_FORMAT_PRINT = "dd MMMM yyyy HH:mm"
    
    public var localized: String {
        get {
            return NSLocalizedString(self, comment: "")
        }
    }
    
    public var getDateFormat: String {
        get {
            let dateFormatter = DateFormatter()
            let tempLocale = dateFormatter.locale
            dateFormatter.locale = Locale(identifier: String.LOCALE)
            dateFormatter.dateFormat = String.DATE_FORMAT
            let date = dateFormatter.date(from: self) ?? Date()
            dateFormatter.dateFormat = String.DATE_FORMAT_PRINT
            dateFormatter.locale = tempLocale
            return dateFormatter.string(from: date)
        }
    }
}

//MARK: - UIView
extension UIView {
    func addRoundCornersView(corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            var maskedCorners = CACornerMask()
            if corners.contains(.bottomLeft) {
                maskedCorners.insert(.layerMinXMaxYCorner)
            }
            if corners.contains(.bottomRight) {
                maskedCorners.insert(.layerMaxXMaxYCorner)
            }
            if corners.contains(.topLeft) {
                maskedCorners.insert(.layerMinXMinYCorner)
            }
            if corners.contains(.topRight) {
                maskedCorners.insert(.layerMaxXMinYCorner)
            }
            clipsToBounds = true
            layer.cornerRadius = radius
            layer.maskedCorners = maskedCorners
        } else {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.frame = bounds
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
}

//MARK: - UIImageView
extension UIImageView {
    private static let PREFIX = "image"
    
    private func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix(UIImageView.PREFIX),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    self.image = nil
                    return
                }
            DispatchQueue.main.async() { [weak self] in
                guard let weakself = self else { return }
                weakself.image = image
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

//MARK: - StructDecodable
public protocol StructDecodable: Decodable {
    static func getModelFrom(_ data: Data) -> Self?
}

extension StructDecodable {
    public static func getModelFrom(_ data: Data) -> Self? {
        do {
            return try JSONDecoder().decode(Self.self, from: data)
        } catch {
            return nil
        }
    }
}
