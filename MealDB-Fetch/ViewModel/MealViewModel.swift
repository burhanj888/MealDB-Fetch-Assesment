import Foundation

@MainActor
class MealListViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var isLoading = false
    @Published var error: Error?
    
    private let networkManager: NetworkManaging
       
       init(networkManager: NetworkManaging = MealService.shared) {
           self.networkManager = networkManager
       }
    
    func loadMeals() async {
        isLoading = true
        do {
            meals = try await networkManager.fetchMeals()
        } catch {
            self.error = error
        }
        isLoading = false
    }
}

@MainActor
class MealDetailViewModel: ObservableObject {
    @Published var mealDetails: MealDetail?
    @Published var isLoading = false
    @Published var error: Error?
    
    private let networkManager: NetworkManaging
       
       init(networkManager: NetworkManaging = MealService.shared) {
           self.networkManager = networkManager
       }
    
    func loadMealDetails(id: String) async {
        isLoading = true
        do {
            let details = try await networkManager.fetchMealDetails(id: id)
            mealDetails = details
        } catch {
            self.error = error
            print("Error fetching meal details: \(error)")
        }
        isLoading = false
    }
}
