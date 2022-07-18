//
//  ColorExtention.swift
//  woodycamera
//
//  Created by 颜松柏 on 2022/7/18.
//

import SwiftUI

extension Color {
    static let themeColor = Color(r: 72, g: 96, b: 79)
    static let darkGray = Color(r: 60, g: 60, b: 60)
    
    init(r: Double, g: Double, b: Double) {
        self.init(red: r/255, green: g/255, blue: b/255)
    }
}
