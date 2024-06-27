//
//  MockNetworkManager.swift
//  MealDB-FetchTests
//
//  Created by Burhanuddin Jinwala on 6/26/24.
//

import Foundation
@testable import MealDB_Fetch

class MockNetworkManager: NetworkManaging {
    static let shared = MockNetworkManager()
    var shouldReturnError = false
    var meals: [Meal] = []
    var mealDetail: MealDetail?
    var errorType: URLError.Code?
    
    func fetchMeals() async throws -> [Meal] {
        if shouldReturnError {
            if let errorType = errorType {
                throw URLError(errorType)
            } else {
                throw URLError(.badServerResponse)
            }
        }
        return meals
    }
    
    func fetchMealDetails(id: String) async throws -> MealDetail {
        if shouldReturnError {
            if let errorType = errorType {
                throw URLError(errorType)
            } else {
                throw URLError(.badServerResponse)
            }
        }
        guard let mealDetail = mealDetail else {
            throw URLError(.cannotParseResponse)
        }
        return mealDetail
    }
}
