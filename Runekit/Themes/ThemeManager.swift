//
//  ThemeManager.swift
//  Runekit
//
//  Created by David Cruz on 3/12/18.
//  Copyright © 2018 AppShuttle.io. All rights reserved.
//

import Foundation
import UIKit

class ThemeManager: NSObject {
    
    private let ThemeMainColorHEXKey = "ThemeMainColorHEX"
    private let ThemeMainColorDefaultHex = "#FF015D"
    
    // MARK: - Initialization Methods
    override init() {
        super.init()
    }
    static let shared: ThemeManager = {
        let instance = ThemeManager()
        return instance
    }()
    
    func loadTheme() {
        if UserDefaults.standard.string(forKey: ThemeMainColorHEXKey) == nil {
            setThemeColor(ThemeMainColorDefaultHex)
        }
        setUpNewThemeMainColor(UIColor(hexString: UserDefaults.standard.string(forKey: ThemeMainColorHEXKey)!))
    }
    
    private func setUpNewThemeMainColor(_ color: UIColor) {
        UINavigationBar.appearance().largeTitleTextAttributes =
            [NSAttributedStringKey.foregroundColor: color]
        UITabBar.appearance().tintColor = color
    }
    
}


extension ThemeManager {
    func getThemeColor() -> UIColor {
        return UIColor(hexString: (UserDefaults.standard.string(forKey: ThemeMainColorHEXKey) ?? ThemeMainColorDefaultHex))
    }
    func setThemeColor(_ colorHex: String) {
        var mutableHex = colorHex
        if !mutableHex.contains("#") {
            mutableHex = "#" + mutableHex
        }
        UserDefaults.standard.set(mutableHex, forKey: ThemeMainColorHEXKey)
    }
}
