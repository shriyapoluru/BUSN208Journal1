//import UIKit

import SwiftUI


// different types of vehicles
enum CarType: String, CaseIterable {
    case sedan = "Sedan"
    case suv = "SUV"
    case truck = "Truck"
    case sportsCar = "Sports Car"
}

// different fuel types for the cars
enum FuelType: String, CaseIterable {
    case gas = "Gasoline"
    case electric = "Electric"
    case hybrid = "Hybrid"
    case diesel = "Diesel"
}

// the criteira for user preference
enum UserPreference: String, CaseIterable {
    case speed = "Speed"
    case fuelEfficiency = "Fuel Efficiency"
    case price = "Price"
}



// This is a class to track User Selections
@MainActor
class UserSelection {
    // Static variables with @MainActor for safe UI updates
    static var selectedCarType: CarType?
    static var selectedFuelType: FuelType?
    static var selectedPreference: UserPreference?
}


struct CarSelectionView: View {
    // This is tracking the user selections locally?
    @State private var carType: CarType = .sedan
    @State private var fuelType: FuelType = .gas
    @State private var userPreference: UserPreference = .speed
    
    @State private var showRecommendation = false // Controls navigation. this can toggle between true and false

    var body: some View {
        NavigationStack {
            VStack {
                Picker("Car Type", selection: $carType) {
                    ForEach(CarType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(.segmented)
                .padding()

                Picker("Fuel Type", selection: $fuelType) {
                    ForEach(FuelType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(.segmented)
                .padding()

                Picker("Preference", selection: $userPreference) {
                    ForEach(UserPreference.allCases, id: \.self) { preference in
                        Text(preference.rawValue).tag(preference)
                    }
                }
                .pickerStyle(.segmented)
                .padding()

                Button("Find My Car") {
                    // Updating the static properties directly
                    UserSelection.selectedCarType = carType
                    UserSelection.selectedFuelType = fuelType
                    UserSelection.selectedPreference = userPreference
                    
                    showRecommendation.toggle() // moving to next screen
                }
                .buttonStyle(.borderedProminent)
                .padding()

                Spacer()
            }
            .navigationTitle("Car Selection")
            .fullScreenCover(isPresented: $showRecommendation) {
                CarRecommendationView()
            }
        }
    }
}


// View for Displaying Car Recommendations (Similar to GameView)
struct CarRecommendationView: View {
    // Getting Stored User Selections
    let carType = UserSelection.selectedCarType ?? .sedan
    let fuelType = UserSelection.selectedFuelType ?? .gas
    let preference = UserSelection.selectedPreference ?? .speed

    var body: some View {
        VStack {
            Text("Your Recommended Car").font(.title).bold()
            
            // Displaying the selected car details
            Text("Car Type: \(carType.rawValue)").font(.headline)
            Text("Fuel Type: \(fuelType.rawValue)").font(.headline)
            Text("Preference: \(preference.rawValue)").font(.headline)
            
            Image("CarImage") // SP insert; placeholder for actual car images
                .resizable()
                .frame(width: 250, height: 150)
                .padding()
            
            Button("Start Over") {
                UserSelection.selectedCarType = nil
                UserSelection.selectedFuelType = nil
                UserSelection.selectedPreference = nil
            }
            .buttonStyle(.borderedProminent)
            .padding()
            
            Spacer()
        }
        .padding()
    }
}


