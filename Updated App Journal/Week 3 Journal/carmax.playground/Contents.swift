import UIKit

import Foundation

// Struct that is used to represent a car. They are constants.
struct Car {
    let name: String
    let horsepower: Int
    let mpg: Double
    let price: Double
}

// Struct for user preferences (speed, efficiency, and price)
struct UserPreference {
    let prioritizeSpeed: Double
    let prioritizeFuelEfficiency: Double
    let prioritizePrice: Double
}

// Function that will calculate scores for each car based on different preferences
func scoreCar(car: Car, preferences: UserPreference) -> Double {
    // This is where attributes are normalized for fair scoring.  I think this will be helpful if I //actually start testing
    let maxHorsePower = 500.0   // Maximum expected horsepower
    let maxMPG = 40.0   // Maximum expected MPG
    let maxPrice = 100000.0 // Maximum expected price

    let speedScore = (Double(car.horsepower) / maxHorsePower) * preferences.prioritizeSpeed
    let fuelScore = (car.mpg / maxMPG) * preferences.prioritizeFuelEfficiency
    let priceScore = (1 - (car.price / maxPrice)) * preferences.prioritizePrice

    return speedScore + fuelScore + priceScore
}

// Function that will compare 3 cars
func compareCars(cars: [Car], preferences: UserPreference) -> Car? {
    guard cars.count == 3 else {
        print("What are 3 cars you want to compare?")
        return nil
    }

    // This is where the cars are given scores. Then they are sorted by the scores that they are given.
    let scoredCars = cars.map { ($0, scoreCar(car: $0, preferences: preferences)) }
    let bestCar = scoredCars.max(by: { $0.1 < $1.1 })?.0

    return bestCar
}



//testing

let cars = [
    Car(name: "Sports Car", horsepower: 450, mpg: 16, price: 70000),
    Car(name: "Economy Car", horsepower: 120, mpg: 37, price: 30000),
    Car(name: "Luxury Car", horsepower: 300, mpg: 23, price: 90000)
]

let preferences = UserPreference(prioritizeSpeed: 0.7, prioritizeFuelEfficiency: 0.1, prioritizePrice: 0.2)

if let bestCar = compareCars(cars: cars, preferences: preferences) {
    print("The best car for your preferences is: \(bestCar.name)")
} else {
    print("Comparison failed.")
}

