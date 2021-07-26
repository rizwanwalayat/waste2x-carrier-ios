//
//  UIImageView.swift
//  CarrierApp
//
//  Created by Phaedra Solutions  on 19/07/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func setImageColor(color: UIColor) {
      let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
      self.image = templateImage
      self.tintColor = color
    }
}
