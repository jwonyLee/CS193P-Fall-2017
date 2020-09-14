//
//  Theme.swift
//  Concentration
//
//  Created by 이지원 on 2020/09/04.
//  Copyright © 2020 JiWon Lee. All rights reserved.
//

import Foundation

struct Theme {
    private static let themes: [String:[String]] = [
        "halloween" : ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍎", "🍭", "🍬"],
        "animals": ["🐶", "🐹", "🐰", "🦊", "🐻", "🐼", "🐷", "🐯", "🐵"],
        "sports": ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🎱"],
        "moon": ["🌕", "🌖", "🌗", "🌘", "🌑", "🌒", "🌓", "🌔", "🌙"],
        "weather": ["☀️", "🌦", "🌧", "⛈", "🌩", "❄️", "☔️", "☃️", "💨"],
        "country": ["🇰🇷", "🇩🇪", "🇬🇳", "🇺🇸", "🇧🇪", "🇧🇷", "🇨🇭", "🇬🇧", "🇯🇵"]]
    
    
    // key: theme
    // value: [background color, card color]
    private static let themesColor: [String:[String]] = [
        "halloween" : ["Black", "Orange"],
        "animals" : ["Green", "Brown"],
        "sports" : ["White", "SkyBlue"],
        "moon" : ["Black", "Yellow"],
        "weather": ["SkyBlue", "White"],
        "country": ["Green", "SkyBlue"]
    ]
    
    static func chooseTheme() -> ((key: String, value: [String]), [String]) {
        let theme = themes.randomElement()!
        let themeColor = themesColor[theme.key]!
        return (theme, themeColor)
    }
}
