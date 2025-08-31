//
//  RecordListView.swift
//  Matdongsan
//
//  Created by sujeong on 8/31/25.
//

import SwiftUI

struct RecordListView: View {
    let records: [String]
    @State var selectedDate: Date
    
    var body: some View {
        
        VStack (alignment: .center, spacing: 8) {
            HStack {
                Text(formattedDate(selectedDate))
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.mdWarmGray70)
                    .padding(.vertical, 6)
                Spacer()

                if !records.isEmpty {
                    Button {
                        
                    } label: {
                        HStack {
                            Text("기록하기")
                                .font(.system(size: 12, weight: .semibold))
                            Image("add-square")
                                .frame(width: 16, height: 16)
                        }
                        .padding(8)
                        .background(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(.mdCoolgray20)
                        )
                        .foregroundStyle(.mdCoolgray60)
                    }
                }
            }
            .frame(height: 32)
            
            VStack(alignment: .center, spacing: 8) {
                if !records.isEmpty {
                    ForEach(records, id: \.self) { record in
                        HStack (alignment: .top) {
                            Text(String(record.first ?? " "))
                                .font(.system(size: 13))
                                .frame(width: 26, height: 26)
                                .background(.mdYellow10)
                                .clipShape(Circle())
                            Text(record.dropFirst())
                                .font(.system(size: 14))
                                .foregroundStyle(.mdGray90)
                                .padding(.vertical, 4)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                            Button {
                                
                            } label: {
                                Image("vertical-ellipsis")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                            }
                        }
                        .padding(.leading, 16)
                    }
                } else {
                    VStack (spacing: 0) {
                        Image("empty6060")
                            .resizable()
                            .frame(width: 60.5, height: 60.5)
                            .padding(.top, 16)
                            .padding(.bottom, 10)
                        Text("아직 기록된 제철음식이 없어요.")
                            .font(.system(size: 14))
                            .padding(.bottom, 2)
                            .foregroundStyle(.mdGray90)
                        Text("제철음식을 기록해보세요.")
                            .font(.system(size: 13))
                            .foregroundStyle(.mdGray50)
                            .padding(.bottom, 10)
                        Button {
                            
                        } label: {
                            HStack {
                                Text("기록하기")
                                    .font(.system(size: 12, weight: .semibold))
                                Image("add-square")
                                    .frame(width: 16, height: 16)
                            }
                            .padding(8)
                            .background(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.mdCoolgray20)
                            )
                            .foregroundStyle(.mdCoolgray60)
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy.MM.dd EEEE"
        return formatter.string(from: date)
    }
}

#Preview {
    let dummyRecords: [String] = ["🌽 옥수수 짱 달다", "🍑 복숭아 3개 3,600원"]
    RecordListView(records: dummyRecords, selectedDate: Date())
}
