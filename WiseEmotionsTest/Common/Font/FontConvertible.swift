//
//  FontConvertible.swift
//  AesyBite
//
//  Created by Filippo Giove on 23/04/2020.
//  Copyright © 2020 Filippo Giove. All rights reserved.
//

import UIKit

public protocol FontConvertible {
    
    var name: String { get }
    var fontName: String { get }
    var pointSize: CGFloat { get }
    
}
