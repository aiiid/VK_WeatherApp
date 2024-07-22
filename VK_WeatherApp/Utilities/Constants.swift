//
//  Constants.swift
//  VK_WeatherApp
//
//  Created by Ai Hawok on 22/07/2024.
//

import UIKit

class Constants {
    struct Colors {
        static let backgroundColor = UIColor.systemBackground
        static let primary = UIColor(hex: "#505EF6")
        static let primaryDarker = UIColor(hex: "#3640B0")
        static let secondary = UIColor(hex: "#9A80F7")
        
        static let light = UIColor(hex: "#9A80F7")
        static let sunny = UIColor(hex: "#FFD88B")
        static let blue = UIColor(hex: "#5DBFF6")
        static let darkerBlue = UIColor(hex: "#517ACB")
        
        static let gray: UIColor = .systemGray3
        static let grayish = UIColor(hex: "#C5C8E7") 
        
        static let label = UIColor(hex: "#343434")
        static let textFaded = UIColor(hex: "#666666")
    }
    
    struct Padding {
        static let small: CGFloat = 16
        static let medium: CGFloat = 20
        static let large: CGFloat = 25
    }
    
    struct Fonts {
            static let largeTitle = UIFont.systemFont(ofSize: 60, weight: .bold)
            static let title = UIFont.systemFont(ofSize: 24, weight: .medium)
            static let body = UIFont.systemFont(ofSize: 14, weight: .regular)
        }
}
