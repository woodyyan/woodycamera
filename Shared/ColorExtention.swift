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
    static let darkModeGray = Color(r: 20, g: 20, b: 20)
    static let lightGray = Color(r: 240, g: 240, b: 240)
    
    init(r: Double, g: Double, b: Double) {
        self.init(red: r/255, green: g/255, blue: b/255)
    }
}
