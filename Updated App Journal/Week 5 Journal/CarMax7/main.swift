import Foundation

// Create inventory
let inventory = CarInventory()

// Add some sample cars
let car1 = CarModel(
    make: "Toyota",
    model: "Camry",
    year: 2020,
    price: 25000,
    mileage: 15000,
    condition: .excellent,
    vin: "1HGCM82633A123456"
)

let car2 = CarModel(
    make: "Honda",
    model: "Civic",
    year: 2019,
    price: 22000,
    mileage: 25000,
    condition: .good,
    vin: "2HGES16575H123456"
)

let car3 = CarModel(
    make: "Tesla",
    model: "Model 3",
    year: 2021,
    price: 45000,
    mileage: 5000,
    condition: .new,
    vin: "5YJ3E1EA1MF123456"
)

// Add cars to inventory
inventory.addCar(car1)
inventory.addCar(car2)
inventory.addCar(car3)

// Demo searches
print("All cars in inventory:")
inventory.getAllCars().forEach { car in
    print("\(car.year) \(car.make) \(car.model)")
    print("Price: \(car.formattedPrice)")
    print("Mileage: \(car.formattedMileage)")
    print("Condition: \(car.condition.rawValue)")
    print("VIN: \(car.vin)\n")
}

print("\nCars under $30,000:")
let affordableCars = inventory.searchCars(maxPrice: 30000)
affordableCars.forEach { car in
    print("\(car.year) \(car.make) \(car.model) - \(car.formattedPrice)")
}

print("\nExcellent condition cars:")
let excellentCars = inventory.searchCars(condition: .excellent)
excellentCars.forEach { car in
    print("\(car.year) \(car.make) \(car.model) - \(car.condition.rawValue)")
}

// Demo removing a car
print("\nRemoving Toyota Camry...")
inventory.removeCar(withVIN: "1HGCM82633A123456")

print("\nUpdated inventory:")
inventory.getAllCars().forEach { car in
    print("\(car.year) \(car.make) \(car.model)")
} 