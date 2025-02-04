//
//  Optional+Extension.swift
//  Galaxy
//
//  Created by Sowrirajan Sugumaran on 17/01/25.
//
/// Safely unwraping optional string values.
///  - if it is none the default value will be return.
///  - if it is empty the default value will be return.
///  - if it has a value the actual value will be return.
extension Optional where Wrapped == String {
    func whenNoValue(_ defaultValue: String) -> String {
        switch self {
        case .none:
            return defaultValue
        case .some(let value) where value.isEmpty:
            return defaultValue
        case .some(let value):
            return value
        }
    }
}
