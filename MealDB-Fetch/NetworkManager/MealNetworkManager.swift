import Foundation

protocol NetworkManaging {
    func fetchMeals() async throws -> [Meal]
    func fetchMealDetails(id: String) async throws -> MealDetail
}
class MealService : NetworkManaging {
    static let shared = MealService()
    
    private init() {}
    
    func fetchMeals() async throws -> [Meal] {
        let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")!
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let mealResponse = try JSONDecoder().decode(MealResponse.self, from: data)
        
        return mealResponse.meals.sorted { $0.strMeal < $1.strMeal }
    }
    
    func fetchMealDetails(id: String) async throws -> MealDetail {
        let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)")!
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let mealDetailResponse = try JSONDecoder().decode(MealDetailResponse.self, from: data)
        guard let mealDetail = mealDetailResponse.meals.first else {
            throw URLError(.cannotParseResponse)
        }
        
        print("Fetched Meal Detail: \(mealDetail)")
        
        return mealDetail
    }
}
