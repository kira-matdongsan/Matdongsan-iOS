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
    let daysOfWeek = ["일", "월", "화", "수", "목", "금", "토"]
//    let daysOfWeek = Calendar.current.shortWeekdaySymbols
    
    var body: some View {
        
        VStack {
            HStack {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(.mdGray40)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.bottom, 4)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), alignment: .top), count: 7)) {
                ForEach(days, id: \.self) { day in
                    VStack {
                        Text("\(Calendar.current.component(.day, from: day))")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(
                                Calendar.current.isDate(day, inSameDayAs: selectedDate) ? .white :  // ✅ 선택된 날짜 최우선
                                (Calendar.current.component(.weekday, from: day) == 1 ? .mdMagenta50 : // 일요일
                                (Calendar.current.isDate(day, equalTo: displayedMonth, toGranularity: .month) ? .mdGray90 : .mdGray20))
                            )
                            .onTapGesture {
                                selectedDate = day
                            }
                            .frame(width:32 ,height: 26)
                            .background(Calendar.current.isDate(day, inSameDayAs: selectedDate) ? Color.mdCyan40 : Color.clear)
                            .cornerRadius(8)
                        
                        Spacer()
                        
                        if let records = recordsByDate[day.stripTime()], !records.isEmpty {

                            Text(String(records[0].first ?? " "))
                                .frame(width: 36, height: 36)
                                .background(.mdYellow10)
                                .clipShape(Circle())
                        }
                    }
                    .frame(height: 72)
                }
            }
        }
    }
}
#Preview {
    let dummyRecords: [Date: [String]] = [
        Calendar.current.startOfDay(for: Date()): ["🌽 옥수수 2개 2,000원", "🍑 복숭아 3개 3,600원"],
        Calendar.current.startOfDay(for: Calendar.current.date(byAdding: .day, value: -2, to: Date())!): ["🍉 수박 한 통 12,000원"],
        Calendar.current.startOfDay(for: Calendar.current.date(byAdding: .day, value: -7, to: Date())!): ["🍑 복숭아 3개 3,600원"]
    ]
    let days:[Date] = CalendarHelper.shared.generateDaysInMonth(for: Date())
    
    CalendarView(selectedDate: .constant(Date()), displayedMonth: .constant(Date()), recordsByDate: dummyRecords, days: days)
}
