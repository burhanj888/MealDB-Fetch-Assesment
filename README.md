
# MealDB-fetch

MealDB-fetch is a SwiftUI application that fetches and displays a list of dessert recipes from TheMealDB API. Users can view detailed information about each recipe, including instructions, ingredients, measurements, and an embedded YouTube video if available.

## Features

- Fetch and display a list of dessert recipes from TheMealDB API.
- View detailed information about each recipe, including:
  - Name
  - Instructions (formatted as ordered steps)
  - Ingredients and measurements
  - Embedded YouTube video
- Handle various states such as loading, error, and empty data gracefully.
- Use of modern Swift Concurrency (async/await) for network requests.
- MVVM architecture for scalable, efficient, and clean code.
- Dependency injection for network manager, allowing easy testing and mock implementations.

## Requirements

- iOS 17.0+
- Xcode 13.0+
- Swift 5.5+

## Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/burhanj888/MealDB-Fetch-Assesment/MealDB-fetch.git
    ```

2. Open the project in Xcode:

    ```bash
    cd MealDB-fetch
    open MealDB-fetch.xcodeproj
    ```

3. Build and run the project in the Xcode simulator or on a physical device.

## Usage

### Home Screen

The home screen displays a list of dessert recipes. Each item in the list shows the name and thumbnail of the recipe.

### Recipe Detail

When you select a recipe from the list, the detail screen displays detailed information about the recipe, including:

- Recipe name
- Step-by-step instructions
- Ingredients and measurements
- Embedded YouTube video (if available)

## Architecture

The application follows the MVVM (Model-View-ViewModel) architecture pattern for better separation of concerns, testability, and scalability.

### Models

- `Meal`: Represents a meal with basic information.
- `MealDetail`: Represents detailed information about a meal.
- `MealResponse`: Represents the response from the meals API.
- `MealDetailResponse`: Represents the response from the meal detail API.

### ViewModels

- `MealListViewModel`: Handles the logic for fetching and managing the list of meals.
- `MealDetailViewModel`: Handles the logic for fetching and managing the details of a selected meal.

### Views

- `MealListView`: Displays the list of meals.
- `MealDetailView`: Displays the detailed information of a selected meal.

### Networking

- `NetworkManager`: Handles network requests to fetch meals and meal details.
- `MockNetworkManager`: A mock implementation of `NetworkManaging` protocol for testing purposes.

## Testing

The project includes unit tests for the view models and network manager to ensure the correctness of data fetching and error handling logic.

### Running Tests

1. Open the project in Xcode.
2. Press `Cmd+U` to run all tests.

### Test Coverage

- `MealListViewModelTests`: Tests for `MealListViewModel`.
- `MealDetailViewModelTests`: Tests for `MealDetailViewModel`.
- `NetworkManagerTests`: Tests for `NetworkManager`.

## Acknowledgments

- [TheMealDB API](https://www.themealdb.com/api.php) for providing the meal data.
