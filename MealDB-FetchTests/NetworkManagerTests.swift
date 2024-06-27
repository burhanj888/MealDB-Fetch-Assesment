//
//  NetworkManagerTests.swift
//  MealDB-FetchTests
//
//  Created by Burhanuddin Jinwala on 6/26/24.
//

import Foundation
import XCTest
@testable import MealDB_Fetch

class NetworkManagerTests: XCTestCase {
    var networkManager: MealService!
    
    override func setUp() {
        super.setUp()
        networkManager = MealService.shared
    }
    
    override func tearDown() {
        networkManager = nil
        super.tearDown()
    }
    
    func testFetchMealsSuccess() async {
        do {
            let meals = try await networkManager.fetchMeals()
            XCTAssertFalse(meals.isEmpty, "Meals should not be empty")
            print("Meals: \(meals)")
        } catch {
            XCTFail("Expected to fetch meals successfully, but got error: \(error)")
        }
    }
    
    func testFetchMealDetailsSuccess() async {
        do {
            let mealDetail = try await networkManager.fetchMealDetails(id: "52860")
            XCTAssertEqual(mealDetail.strMeal, "Chocolate Raspberry Brownies", "Meal name should match")
            print("Meal Detail: \(mealDetail)")
        } catch {
            XCTFail("Expected to fetch meal details successfully, but got error: \(error)")
        }
    }
    
    func testFetchMealsFailure() async {
        let invalidURL = URL(string: "https://invalid-url.com")!
        let urlSession = URLSession(configuration: .ephemeral)
        
        let task = URLSession.shared.dataTask(with: invalidURL) { _, _, error in
            XCTAssertNotNil(error, "Error should not be nil")
        }
        task.resume()
    }
    
}
