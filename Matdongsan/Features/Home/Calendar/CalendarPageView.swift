//
//  CalendarPageView.swift
//  Matdongsan
//
//  Created by sujeong on 8/8/25.
//

import SwiftUI

struct CalendarPageView: View {
    @State var selectedDate: Date
    @State var displayedMonth: Date
    let recordsByDate: [Date: [String]] // 예: [2025-08-08: ["🍑", "🥒"]]
    
    var body: some View {
        
        VStack {
            // 년월 선택 피커
            DatePicker("", selection: $displayedMonth, displayedComponents: [.date])
                .datePickerStyle(.compact)
                .labelsHidden()

            // 캘린더
            CalendarView(
                selectedDate: $selectedDate,
                displayedMonth: $displayedMonth,
                recordsByDate: recordsByDate,
                days: CalendarHelper.shared.generateDaysInMonth(for: displayedMonth)
            )
            .padding()

            // 선택 날짜의 기록
            if let records = recordsByDate[selectedDate.stripTime()] {
                List(records, id: \.self) {
                    Text($0)
                }
            } else {
                Text("기록이 없어요.")
                    .foregroundColor(.gray)
            }
        }

    }
}

#Preview {
    let dummyRecords: [Date: [String]] = [
        Calendar.current.startOfDay(for: Date()): ["🌽 옥수수 2개 2,000원", "🍑 복숭아 3개 3,600원"],
        Calendar.current.date(byAdding: .day, value: -2, to: Date())!: ["🍉 수박 한 통 12,000원"]
    ]
    CalendarPageView(selectedDate: Date(), displayedMonth: Date(), recordsByDate: dummyRecords)
}
