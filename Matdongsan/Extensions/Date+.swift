//
//  Date+.swift
//  Matdongsan
//
//  Created by sujeong on 8/8/25.
//

import Foundation

extension Date {
    func stripTime() -> Date {
        Calendar.current.startOfDay(for: self)
    }
}
