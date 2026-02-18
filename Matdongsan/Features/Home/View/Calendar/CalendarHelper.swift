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
              // 달 시작 주의 시작일
              let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: monthInterval.start)),
              // 달 끝(=다음달 1일)이 속한 주의 시작 → 그 주의 시작일
              let endOfWeekStart = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: monthInterval.end)),
              // 거기서 +6일 해서 그 주의 "끝" 계산
              let endOfWeek = calendar.date(byAdding: .day, value: 6, to: endOfWeekStart)
        else { return [] }

        var dates: [Date] = []
        var current = startOfWeek

        while current <= endOfWeek {
            dates.append(current)
            current = calendar.date(byAdding: .day, value: 1, to: current)!
        }

        return dates
    }

}
