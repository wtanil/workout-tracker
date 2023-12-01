//
//  DateFormatter+extension.swift
//  Some Measurement
//
//  Created by William Suryadi Tanil on 19/01/21.
//

import Foundation

extension DateFormatter {
    static let dateFormatterMediumMedium: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = getPreferredLocale()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }()
    
    static let dateFormatterMediumShort: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = getPreferredLocale()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    static let dateFormatterMediumNone: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = getPreferredLocale()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    static let dateFormatterShortNone: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = getPreferredLocale()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }()
    
    static let dateFormatterNoneShort: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = getPreferredLocale()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }()
    
    static func getPreferredLocale() -> Locale {
        guard let preferredIdentifier = Locale.preferredLanguages.first else {
            return Locale.current
        }
        return Locale(identifier: preferredIdentifier)
    }
}
