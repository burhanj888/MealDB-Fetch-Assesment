//
//  MealListView.swift
//  MealDB-Fetch
//
//  Created by Burhanuddin Jinwala on 6/26/24.
//

import SwiftUI

struct MealListView: View {
    @StateObject var viewModel = MealListViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.meals) { meal in
                NavigationLink(destination: MealDetailView(mealID: meal.idMeal)) {
                    HStack {
                        if let urlString = meal.strMealThumb, let url = URL(string: urlString) {
                            AsyncImage(url: url) { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            } placeholder: {
                                ProgressView()
                            }
                        }
                        
                        Text(meal.strMeal)
                    }
                }
            }
            .navigationTitle("Desserts")
            .onAppear {
                Task {
                    await viewModel.loadMeals()
                }
            }
            .alert(isPresented: .constant(viewModel.error != nil)) {
                Alert(title: Text("Error"), message: Text(viewModel.error?.localizedDescription ?? "Unknown error"), dismissButton: .default(Text("OK")))
            }
        }
    }
}
