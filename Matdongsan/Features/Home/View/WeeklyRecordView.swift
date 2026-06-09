//
//  WeeklyRecordView.swift
//  Matdongsan
//
//  Created by sujeong on 7/27/25.
//

import Foundation
import SwiftUI

struct WeeklyRecordView: View {
    @EnvironmentObject private var navigationManager: NavigationManager
    @ObservedObject var viewModel: HomeViewModel
    
    // MARK: - Formatter (한 번만 생성)
    private let dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }()
    
    private let weekdayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()
    
    // MARK: - 현재 주 계산
    var currentWeek: [Date] {
        let calendar = Calendar.current
        let today = Date()
        let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: today)?.start ?? today
        
        return (0..<7).compactMap {
            calendar.date(byAdding: .day, value: $0, to: startOfWeek)
        }
    }
    
    // MARK: - 현재 월
    var currentMonth: Int {
        Calendar.current.component(.month, from: Date())
    }
    
    @State private var selectedDate: Date = Date()
    
    var body: some View {
        VStack(spacing: 8) {
            
            // MARK: - Header
            HStack {
                Text("\(currentMonth)월 제철기록장")
                    .foregroundStyle(.white)
                    .font(.system(size: 14, weight: .bold))

                Spacer()

                Button {
                    navigationManager.navigate(to: .calendar)
                } label: {
                    Text("전체보기")
                        .font(.system(size: 12))
                        .foregroundStyle(.white)
                        .padding(4)
                        .background(.mdGray60)
                        .cornerRadius(4)
                }
            }
            .padding(.horizontal, 24)

            // MARK: - Weekly Days
            HStack(spacing: 8) {
                ForEach(currentWeek, id: \.self) { date in
                    
                    let isToday = Calendar.current.isDateInToday(date)
                    let hasRecord = viewModel.hasRecord(on: date)
                    let isSelected = Calendar.current.isDate(date, inSameDayAs: selectedDate)
                    
                    VStack(spacing: 13) {
                        
                        VStack(spacing: 20) {
                            Text(dayFormatter.string(from: date))
                            Text(weekdayFormatter.string(from: date))
                        }
                        .font(.system(size: 13, weight: .semibold))
                        .frame(maxWidth: .infinity)
                        .frame(height: 66)
                        .background(
                            isSelected ? .mdYellow40 : .mdGray70
                        )
                        .cornerRadius(24)
                        .foregroundStyle(
                            isSelected
                            ? .mdGray90
                            : .white
                        )

                        Circle()
                            .frame(width: 4, height: 4)
                            .foregroundStyle(
                                isToday
                                ? .white
                                : (hasRecord ? .mdYellow40 : .clear)
                            )
                    }
                    .onTapGesture {
                        selectedDate = date
                    }
                }
            }
            .padding(.horizontal, 16)

            // MARK: - Bottom Card
            if let record = viewModel.record(on: selectedDate) {
                HStack(spacing: 8) {
                    Image("medal")

                    VStack(alignment: .leading, spacing: 4) {
                        Text(record.subTitle)
                            .foregroundStyle(.mdGray30)
                            .font(.system(size: 12, weight: .semibold))
                        
                        Text(record.foodName)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(.mdYellow40)
                    }

                    Spacer()
                }
                .padding(6)
                .frame(height: 48)
                .background(.mdGray70)
                .cornerRadius(16)
                .padding(.horizontal, 16)
            }
        }
        .padding(.vertical, 16)
        .background(.mdWarmGray80)
        .cornerRadius(24)
    }
}
