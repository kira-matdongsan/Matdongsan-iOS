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
    
    @Published var isLoading: Bool = false
    @Published var hasNext: Bool = false
    
    @Published var selectedFilter: String = "전체"
    @Published var selectedSort: String = "최신순"
    
    private var currentPage: Int = 0
    private var totalPages: Int = 0

    private let provider = FoodDataProvider()
    
    private let foodId: Int64
    
    init(foodId: Int64) {
        self.foodId = foodId
    }
    
    // MARK: - Fetch
    func fetchStories(reset: Bool = true, type: StoryType? = nil) async {
        if reset {
            currentPage = 0
            stories = []
        }
        
        guard !isLoading else { return }
        if !hasNext, !reset { return }
        isLoading = true
        
        defer { isLoading = false }
        
        let page = reset ? 0 : currentPage + 1
        
        do {
            let dto = try await provider.getFoodStories(foodId: foodId, page: page, type: type?.rawValue)
            let mapped = dto.toDomain()
            stories.append(contentsOf: mapped)
            hasNext = dto.hasNext
            print("스토리 fetch 성공")
        } catch {
            print("스토리 fetch 실패:", error)
        }
    }
    
    func updateFilter(_ filter: String) async {
        var selectedStoryType: StoryType? {
            switch filter {
            case "레시피":
                    .recipe
            case "제철기록":
                    .seasonalNote
            default:
                nil
            }
        }
        
        currentPage = 0
        hasNext = true
        stories = []
        
        await fetchStories(reset: true, type: selectedStoryType)
    }
    
    // MARK: - delete
    public func deleteStory(storyId: Int64) async {
        do {
            try await provider.deleteStory(storyId)
            stories.removeAll { $0.id == storyId }
            await fetchStories(reset: true)
            print("스토리 delete 성공")
        } catch {
            print("스토리 delete 실패:", error)
        }
    }
    
    // MARK: - report
    public func reportStory(storyId: Int64, reason: String?) async {
        do {
            try await provider.reportStory(storyId, reason: reason)
            stories.removeAll { $0.id == storyId }
            await fetchStories(reset: true)
            print("스토리 report 성공")
        } catch {
            print("스토리 report 실패:", error)
        }
    }
    
    // MARK: - block user
    public func blockUserOf(storyId: Int64) async {
        do {
            try await provider.blockUserOf(storyId)
            stories.removeAll { $0.id == storyId }
            await fetchStories(reset: true)
            print("스토리 유저 block 성공")
        } catch {
            print("스토리 유저 block 실패:", error)
        }
    }
}
