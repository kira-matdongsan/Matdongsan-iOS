//
//  CalendarPageView.swift
//  Matdongsan
//
//  Created by sujeong on 8/8/25.
//

import SwiftUI

struct CalendarPageView: View {
    @EnvironmentObject private var navigationManager:NavigationManager

    @State var selectedDate: Date
    @State var displayedMonth: Date
    @State var showSheet: Bool = false
    
    let recordsByDate: [Date: [String]] = [
        Calendar.current.startOfDay(for: Date()): ["🌽 옥수수 2개 2,000원", "🍑 복숭아 3개 3,600원"],
        Calendar.current.startOfDay(for: Calendar.current.date(byAdding: .day, value: -2, to: Date())!): ["🍉 수박 한 통 12,000원"],
        Calendar.current.startOfDay(for: Calendar.current.date(byAdding: .day, value: -7, to: Date())!): ["🍑 복숭아 3개 3,600원"]
    ]
    
    @State private var showPicker = false
    
    private func monthYearString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 M월"
        return formatter.string(from: date)
    }
    
    private func updateDate(year: Int, month: Int) {
        if let newDate = Calendar.current.date(from: DateComponents(year: year, month: month, day: 1)) {
            displayedMonth = newDate
        }
    }
    
    private let years = Array(2000...3000)
    private let months = Array(1...12)
    
    var body: some View {
        ScrollView {
            // 년월 선택 피커
            HStack (spacing: 8) {
                Text(monthYearString(from: displayedMonth))
                    .font(.system(size: 18, weight: .semibold))
                Image("arrow-circle-down-b")
                    .resizable()
                    .frame(width: 22, height: 22)
            }
            .onTapGesture {
                withAnimation {
                    showPicker.toggle()
                }
            }
            
            // 캘린더
            CalendarView(
                selectedDate: $selectedDate,
                displayedMonth: $displayedMonth,
                recordsByDate: recordsByDate,
                days: CalendarHelper.shared.generateDaysInMonth(for: displayedMonth)
            )
            .padding()
            
            CustomDivider(opacity: 0.5)
                .padding(.vertical, 8)

            RecordListView(records: recordsByDate[selectedDate] ?? [], selectedDate: selectedDate, showSheet: $showSheet)
                .padding(.horizontal, 16)
            
        }
        .padding(.top, 24)
        .navigationBarBackButtonHidden()
        .navigationTitle("캘린더")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    navigationManager.pop()
                } label: {
                    Image("close-circle")
                        .frame(width: 24, height: 24)
                }
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .sheet(isPresented: $showPicker) {
            VStack {
                HStack {
                    // 연도 선택
                    Picker("연도", selection: Binding(
                        get: { Calendar.current.component(.year, from: displayedMonth) },
                        set: { newYear in
                            updateDate(year: newYear,
                                       month: Calendar.current.component(.month, from: displayedMonth))
                        }
                    )) {
                        ForEach(years, id: \.self) { year in
                            Text("\(String(year))년").tag(year)
                        }
                    }
                    .pickerStyle(.wheel)
                    
                    // 월 선택
                    Picker("월", selection: Binding(
                        get: { Calendar.current.component(.month, from: displayedMonth) },
                        set: { newMonth in
                            updateDate(year: Calendar.current.component(.year, from: displayedMonth),
                                       month: newMonth)
                        }
                    )) {
                        ForEach(months, id: \.self) { month in
                            Text("\(month)월").tag(month)
                        }
                    }
                    .pickerStyle(.wheel)
                }
                .frame(height: 150)
                
                Button("선택") {
                    showPicker = false
                }
                .padding()
            }
            .presentationDetents([.height(300)]) // bottom sheet 높이
        }
        .sheet(isPresented: $showSheet) {
            RecordBottomSheetView()
                .presentationDetents([.height(484)]) // bottom sheet 높이
                .presentationDragIndicator(.hidden) // 직접 만든 indicator 사용
                .presentationBackground(Color.white)
        }
        .scrollIndicators(.hidden)
    }
}

#Preview {
    let dummyRecords: [Date: [String]] = [
        Calendar.current.startOfDay(for: Date()): ["🌽 옥수수 2개 2,000원", "🍑 복숭아 3개 3,600원"],
        Calendar.current.startOfDay(for: Calendar.current.date(byAdding: .day, value: -2, to: Date())!): ["🍉 수박 한 통 12,000원"],
        Calendar.current.startOfDay(for: Calendar.current.date(byAdding: .day, value: -7, to: Date())!): ["🍑 복숭아 3개 3,600원"]
    ]
    CalendarPageView(selectedDate: Date(), displayedMonth: Date())
}
