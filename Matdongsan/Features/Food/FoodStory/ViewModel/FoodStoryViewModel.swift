//
//  FoodStoryViewModel.swift
//  Matdongsan
//
//  Created by sujeong on 2/18/26.
//


import SwiftUI

@MainActor
final class FoodStoryViewModel: ObservableObject {
    
    @Published var stories: [StoryModel] = []
    
    var filteredStories: [StoryModel] {
        switch selectedFilter {
        case "레시피":
            return stories.filter { $0.type == .recipe }
        case "제철기록":
            return stories.filter { $0.type == .seasonalNote }
        default:
            return stories
        }
    }
    
    @Published var isLoading: Bool = false
    @Published var hasNext: Bool = false
    
    @Published var selectedFilter: String = "전체"
    @Published var selectedSort: String = "최신순"
    
    private var currentPage: Int = 0
    private let provider = FoodDataProvider()
    
    private let foodId: Int64
    
    init(foodId: Int64) {
        self.foodId = foodId
    }
    
    // MARK: - Fetch
    func fetchStories(reset: Bool = true) async {
        if reset {
            currentPage = 0
            stories = []
        }
        
        guard !isLoading else { return }
        isLoading = true
        
        defer { isLoading = false }
        
        do {
            let dto = try await provider.getFoodStories(foodId)
            let mapped = dto.toDomain()
            stories.append(contentsOf: mapped)
            hasNext = dto.hasNext
        } catch {
            print("스토리 fetch 실패:", error)
        }
    }
    
    // MARK: - delete
    public func deleteStory(storyId: Int64) async {
        do {
            try await provider.deleteStory(storyId)
        } catch {
            print("스토리 delete 실패:", error)
        }
    }

    
}
