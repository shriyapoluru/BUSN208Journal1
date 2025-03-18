import Foundation

class CarInventory {
    private var cars: [CarModel] = []
    
    func addCar(_ car: CarModel) {
        cars.append(car)
    }
    
    func removeCar(withVIN vin: String) {
        cars.removeAll { $0.vin == vin }
    }
    
    func getAllCars() -> [CarModel] {
        return cars
    }
    
    func searchCars(make: String? = nil, 
                   model: String? = nil, 
                   maxPrice: Double? = nil, 
                   condition: CarCondition? = nil) -> [CarModel] {
        return cars.filter { car in
            var matches = true
            
            if let make = make {
                matches = matches && car.make.lowercased().contains(make.lowercased())
            }
            
            if let model = model {
                matches = matches && car.model.lowercased().contains(model.lowercased())
            }
            
            if let maxPrice = maxPrice {
                matches = matches && car.price <= maxPrice
            }
            
            if let condition = condition {
                matches = matches && car.condition == condition
            }
            
            return matches
        }
    }
} 