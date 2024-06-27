//
//  MealListViewModelTests.swift
//  MealDB-FetchTests
//
//  Created by Burhanuddin Jinwala on 6/26/24.
//
import XCTest
@testable import MealDB_Fetch

@MainActor
class MealListViewModelTests: XCTestCase {
    var viewModel: MealListViewModel!
    var mockNetworkManager: MockNetworkManager!
    
    override func setUp() {
        super.setUp()
        mockNetworkManager = MockNetworkManager()
        viewModel = MealListViewModel(networkManager: mockNetworkManager)
    }
    
    override func tearDown() {
        viewModel = nil
        mockNetworkManager = nil
        super.tearDown()
    }
    
    func testLoadMealsSuccess() async {
        mockNetworkManager.meals = [
            Meal(idMeal: "1", strMeal: "Meal 1", strMealThumb: nil),
            Meal(idMeal: "2", strMeal: "Meal 2", strMealThumb: nil)
        ]
        await viewModel.loadMeals()
        
        XCTAssertFalse(viewModel.meals.isEmpty, "Meals should not be empty")
        XCTAssertEqual(viewModel.meals.count, 2, "There should be 2 meals")
    }
    
    func testLoadMealsEmpty() async {
        mockNetworkManager.meals = []
        await viewModel.loadMeals()
        
        XCTAssertTrue(viewModel.meals.isEmpty, "Meals should be empty")
    }
    
    func testLoadMealsFailure() async {
        mockNetworkManager.shouldReturnError = true
        await viewModel.loadMeals()
        
        XCTAssertNotNil(viewModel.error, "Error should not be nil")
    }
    
    func testLoadMealsNetworkFailure() async {
        mockNetworkManager.shouldReturnError = true
        mockNetworkManager.errorType = .networkConnectionLost
        await viewModel.loadMeals()
        
        XCTAssertNotNil(viewModel.error, "Error should not be nil")
        XCTAssertEqual((viewModel.error as? URLError)?.code, .networkConnectionLost, "Error should be networkConnectionLost")
    }
}
