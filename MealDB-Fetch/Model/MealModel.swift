import Foundation

struct Meal: Codable, Identifiable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String?

    var id: String { idMeal }
}

struct MealResponse: Decodable {
    let meals: [Meal]
}

struct MealDetailResponse: Decodable {
    let meals: [MealDetail]
}

struct MealDetail: Decodable, Identifiable {
    let idMeal: String
    let strMeal: String
    let strInstructions: String
    let strYoutube: String?
    var ingredients: [String: String] = [:]

    var id: String { idMeal }

    private enum CodingKeys: String, CodingKey {
        case idMeal, strMeal, strInstructions, strYoutube
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        idMeal = try container.decode(String.self, forKey: .idMeal)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strInstructions = try container.decode(String.self, forKey: .strInstructions)
        strYoutube = try container.decodeIfPresent(String.self, forKey: .strYoutube)

        let additionalContainer = try decoder.container(keyedBy: DynamicCodingKeys.self)
        for index in 1...20 {
            let ingredientKey = DynamicCodingKeys(stringValue: "strIngredient\(index)")!
            let measureKey = DynamicCodingKeys(stringValue: "strMeasure\(index)")!

            if let ingredient = try additionalContainer.decodeIfPresent(String.self, forKey: ingredientKey),
               !ingredient.isEmptyOrWhitespace(),
               let measure = try additionalContainer.decodeIfPresent(String.self, forKey: measureKey),
               !measure.isEmptyOrWhitespace() {
                ingredients[ingredient] = measure
            }
        }
    }

    struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }

    init(idMeal: String, strMeal: String, strInstructions: String, strYoutube: String?, ingredients: [String: String]) {
        self.idMeal = idMeal
        self.strMeal = strMeal
        self.strInstructions = strInstructions
        self.ingredients = ingredients
        self.strYoutube = strYoutube
    }
}

extension String {
    func isEmptyOrWhitespace() -> Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

extension MealDetail {
    var orderedInstructions: [String] {
        let sentences = strInstructions.components(separatedBy: CharacterSet(charactersIn: ".\n")).filter { !$0.isEmptyOrWhitespace() }
        return sentences.enumerated().map { "Step \($0 + 1): \($1.trimmingCharacters(in: .whitespacesAndNewlines))" }
    }
}
