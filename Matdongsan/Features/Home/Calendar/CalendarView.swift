//
//  CalendarView.swift
//  Matdongsan
//
//  Created by sujeong on 8/8/25.
//

import SwiftUI

struct CalendarView: View {
    @Binding var selectedDate: Date
    @Binding var displayedMonth: Date
    let recordsByDate: [Date: [String]]
    // 예: [2025-08-08: ["🍑", "🥒"]]
        
    var days:[Date]
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), alignment: .top), count: 7)) {
            ForEach(days, id: \.self) { day in
                VStack {
                    Text("\(Calendar.current.component(.day, from: day))")
                        .foregroundColor(Calendar.current.isDate(day, equalTo: displayedMonth, toGranularity: .month) ? .primary : .gray)
                        .onTapGesture {
                            selectedDate = day
                        }
                        .frame(width:32 ,height: 26)
                        .background(Calendar.current.isDate(day, inSameDayAs: selectedDate) ? Color.blue.opacity(0.2) : Color.clear)
                        .cornerRadius(8)

                    if let records = recordsByDate[day.stripTime()], !records.isEmpty {
                        Text("✅")
                            .frame(width: 36, height: 36)
                            .background(.mdYellow10)
                            .clipShape(Circle())
                    }
                }
            }
        }
    }
}
#Preview {
    let dummyRecords: [Date: [String]] = [
        Calendar.current.startOfDay(for: Date()): ["🌽 옥수수 2개 2,000원", "🍑 복숭아 3개 3,600원"],
        Calendar.current.date(byAdding: .day, value: -2, to: Date())!: ["🍉 수박 한 통 12,000원"]
    ]
    
    let days:[Date] = CalendarHelper.shared.generateDaysInMonth(for: Date())
    
    CalendarView(selectedDate: .constant(Date()), displayedMonth: .constant(Date()), recordsByDate: dummyRecords, days: days)
}
