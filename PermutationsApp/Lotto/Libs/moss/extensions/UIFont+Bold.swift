//
//  UIFont+Bold.swift
//  Created by Exey Panteleev on 10/04/15.
//

import UIKit

extension UIFont {
    func bold() -> UIFont {
        let descriptor = self.fontDescriptor().fontDescriptorWithSymbolicTraits(UIFontDescriptorSymbolicTraits.TraitBold)
        return UIFont(descriptor: descriptor, size: 0)
    }
}