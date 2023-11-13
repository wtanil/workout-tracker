//
//  Binding+extension.swift
//  Some Measurement
//
//  Created by William Suryadi Tanil on 08/02/22.
//

import SwiftUI

// from https://forums.swift.org/t/promoting-binding-value-to-binding-value/31055/2
extension Binding {
    
    func withDefaultValue<T>(_ fallback: T) -> Binding<T> where Optional<T> == Value {
        return Binding<T>(
            get: {
                self.wrappedValue ?? fallback
            }, set: {
                self.wrappedValue = $0
            }
        )
    }
}

