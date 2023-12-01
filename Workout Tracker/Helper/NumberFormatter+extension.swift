//
//  NumberFormatter+extension.swift
//  Some Measurement
//
//  Created by William Suryadi Tanil on 20/08/21.
//

import Foundation

extension NumberFormatter {
    
    static let numberFormatterDecimal: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = getPreferredLocale()
        return formatter
    }()
    
    static func getPreferredLocale() -> Locale {
        guard let preferredIdentifier = Locale.preferredLanguages.first else {
            return Locale.current
        }
        return Locale(identifier: preferredIdentifier)
    }
    
}
