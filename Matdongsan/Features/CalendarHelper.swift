//
//  CalendarHelper.swift
//  Matdongsan
//
//  Created by sujeong on 8/8/25.
//

import Foundation

struct CalendarHelper {
    static let shared = CalendarHelper()

    private init() {
    }
    
    let calendar = Calendar.current

    func generateDaysInMonth(for date: Date) -> [Date] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: date),
              let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: monthInterval.start))
        else { return [] }

        let range = calendar.range(of: .day, in: .month, for: date)!
        let offset = calendar.component(.weekday, from: startOfWeek) - 1

        var dates: [Date] = []

        for i in 0..<(range.count + offset) {
            if i < offset {
                dates.append(Date.distantPast) // 빈 칸 채우기용
            } else {
                if let day = calendar.date(byAdding: .day, value: i - offset, to: startOfWeek) {
                    dates.append(day)
                }
            }
        }

        return dates
    }

    func dayString(from date: Date) -> String {
        if date == Date.distantPast { return "" }
        let day = calendar.component(.day, from: date)
        return "\(day)"
    }
}
