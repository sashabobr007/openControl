//
//  Color.swift
//  ChatFirebaseApp
//
//  Created by Александр Алексеев on 02.05.2023.
//

import Foundation
import SwiftUI
import UIKit


extension Color {
    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0

        let length = hexSanitized.count

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0

        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0

        } else {
            return nil
        }

        self.init(red: r, green: g, blue: b, opacity: a)
    }
}


let mainColorOrange = Color(hex: "E35036")?.opacity(0.4)

let mainColorGray = Color(hex: "DADADA")?.opacity(0.33)

let mainColorOrange1 = Color(hex: "E35036")

let mainColorOrange2 = Color(hex: "FFE0DB")?.opacity(0.31)

let mainColorOrange3 = Color(hex: "FEE0C4")

let mainColorRed = Color(hex: "FAEEEE")

let mainColorRed1 = Color(hex: "D73C41")

let mainColorRed2 = Color(hex: "E35036")


let mainColorBlue = Color(hex: "E6FDFD")

let mainColorBlue1 = Color(hex: "00AEAC")


let mainColorPurple = Color(hex: "A2228F")

let mainColorOrange11 = Color(uiColor: UIColor(red: 0.635, green: 0.133, blue: 0.561, alpha: 0.25))








