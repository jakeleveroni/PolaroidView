//
//  ExtensionMethods.swift
//  UIPolaroid
//
//  Created by Jacob Leveroni on 7/16/17.
//  Copyright © 2017 Jacob Leveroni. All rights reserved.
//

import Foundation
import UIKit


// UILabels center vertically by default. Also, magic numbers are really confusing

// vertically centers text
extension UITextView {
    func centerVertically() {
        if let font = font {
            let height = font.lineHeight
            contentInset = UIEdgeInsetsMake((frame.height - (height * 1.5)), 0, 0, 0)
        }
    }
}
