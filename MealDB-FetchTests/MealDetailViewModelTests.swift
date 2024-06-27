//
//  MealDetailViewModelTests.swift
//  MealDB-FetchTests
//
//  Created by Burhanuddin Jinwala on 6/26/24.
//

import XCTest
@testable import MealDB_Fetch

@MainActor
class MealDetailViewModelTests: XCTestCase {
    var viewModel: MealDetailViewModel!
    var mockNetworkManager: MockNetworkManager!
    
    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        viewModel = MealDetailViewModel(networkManager: mockNetworkManager)
    }
    
    override func tearDown() {
        viewModel = nil
        mockNetworkManager = nil
        super.tearDown()
    }
    
    func testLoadMealDetailsSuccess() async {
        mockNetworkManager.mealDetail = MealDetail(
            idMeal: "1",
            strMeal: "Meal 1",
            strInstructions: "Instructions",
            strYoutube: "https://www.youtube.com/watch?v=example",
            ingredients: ["Ingredient": "Measurement"]
        )
        await viewModel.loadMealDetails(id: "1")
        
        XCTAssertNotNil(viewModel.mealDetails, "Meal details should not be nil")
        XCTAssertEqual(viewModel.mealDetails?.strMeal, "Meal 1", "Meal name should match")
        XCTAssertEqual(viewModel.mealDetails?.ingredients.count, 1, "There should be 1 ingredient")
    }
    
    func testLoadMealDetailsEmptyIngredients() async {
        mockNetworkManager.mealDetail = MealDetail(
            idMeal: "1",
            strMeal: "Meal 1",
            strInstructions: "Instructions",
            strYoutube: "https://www.youtube.com/watch?v=example",
            ingredients: [:]
        )
        await viewModel.loadMealDetails(id: "1")
        
        XCTAssertNotNil(viewModel.mealDetails, "Meal details should not be nil")
        XCTAssertTrue(viewModel.mealDetails?.ingredients.isEmpty ?? false, "Ingredients should be empty")
    }
    
    func testLoadMealDetailsFailure() async {
        mockNetworkManager.shouldReturnError = true
        await viewModel.loadMealDetails(id: "1")
        
        XCTAssertNotNil(viewModel.error, "Error should not be nil")
    }
    
    func testLoadMealDetailsNetworkFailure() async {
        mockNetworkManager.shouldReturnError = true
        mockNetworkManager.errorType = .networkConnectionLost
        await viewModel.loadMealDetails(id: "1")
        
        XCTAssertNotNil(viewModel.error, "Error should not be nil")
        XCTAssertEqual((viewModel.error as? URLError)?.code, .networkConnectionLost, "Error should be networkConnectionLost")
    }
}
