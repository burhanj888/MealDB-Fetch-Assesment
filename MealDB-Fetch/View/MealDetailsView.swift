//
//  MealDetailsView.swift
//  MealDB-Fetch
//
//  Created by Burhanuddin Jinwala on 6/26/24.
//

import SwiftUI

struct MealDetailView: View {
    @StateObject var viewModel = MealDetailViewModel()
    let mealID: String
    
    var body: some View {
        VStack {
            if let mealDetails = viewModel.mealDetails {
                Text(mealDetails.strMeal)
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                ScrollView {
                    if let youtubeURL = mealDetails.strYoutube, let videoID = extractYoutubeID(from: youtubeURL) {
                                            Text("Watch on YouTube")
                                                .font(.headline)
                                                .padding(.top)
                                            
                                            YTWebView(url: URL(string: "https://www.youtube.com/embed/\(videoID)")!)
                                                .frame(height: 200)
                                                .cornerRadius(8)
                                                .padding(.horizontal)
                                        }
                    Text("Ingredients and Measurements")
                        .font(.headline)
                        .padding(.top)
                    
                    ForEach(mealDetails.ingredients.sorted(by: >), id: \.key) { ingredient, measurement in
                        HStack {
                            Text(ingredient)
                            Spacer()
                            Text(measurement)
                        }
                        .padding(.horizontal)
                    }
                    
                    Text("Instructions")
                                            .font(.headline)
                                            .padding(.top)
                                        
                                        VStack(alignment: .leading) {
                                            ForEach(mealDetails.orderedInstructions, id: \.self) { instruction in
                                                let components = instruction.split(separator: ":", maxSplits: 1).map { String($0) }
                                                if components.count == 2 {
                                                    HStack {
                                                        Text(components[0])
                                                            .fontWeight(.bold)
                                                        Text(components[1])
                                                            .multilineTextAlignment(.leading)
                                                    }
                                                    .padding(.vertical, 2)
                                                } else {
                                                    Text(instruction)
                                                        .padding(.vertical, 2)
                                                }
                                            }
                                        }
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .padding(.horizontal)
                    
                    
                }
            } else if viewModel.isLoading {
                ProgressView()
            } else {
                Text("No details available")
            }
        }
        .onAppear {
            Task {
                await viewModel.loadMealDetails(id: mealID)
            }
        }
        .alert(isPresented: .constant(viewModel.error != nil)) {
            Alert(title: Text("Error"), message: Text(viewModel.error?.localizedDescription ?? "Unknown error"), dismissButton: .default(Text("OK")))
        }
        .navigationTitle("Meal Details")
    }
    
    func extractYoutubeID(from url: String) -> String? {
            let pattern = #"(?:(?:youtu\.be/|v/|u/\w/|embed/|watch\?v=|&v=)([^#\&\?]*))"#
            let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            let nsString = url as NSString
            let results = regex?.matches(in: url, options: [], range: NSMakeRange(0, nsString.length))
            return results?.first.map { nsString.substring(with: $0.range(at: 1)) }
        }
}
