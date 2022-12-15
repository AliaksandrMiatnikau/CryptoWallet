//
//  UIView + Utilities.swift
//  CryptoWallet
//
//  Created by Aliaksandr Miatnikau on 13.12.22.
//

import Foundation
import UIKit

extension UIView {
    func addGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [UIColor.gray.cgColor, UIColor.white.cgColor, UIColor.gray.cgColor, UIColor.white.cgColor]
        gradient.opacity = 0.6   // прозрачность
        gradient.startPoint = CGPoint(x:0.0, y: 0.0)
        gradient.endPoint = CGPoint(x:1.0, y: 1.0)
        self.layer.insertSublayer(gradient, at: 0)
    }
}
