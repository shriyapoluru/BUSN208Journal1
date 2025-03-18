import Foundation

enum CarCondition: String {
    case new = "New"
    case excellent = "Excellent"
    case good = "Good"
    case fair = "Fair"
    case poor = "Poor"
}

struct CarModel {
    let make: String
    let model: String
    let year: Int
    let price: Double
    let mileage: Int
    let condition: CarCondition
    let vin: String
    
    var formattedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: price)) ?? "$0"
    }
    
    var formattedMileage: String {
        return "\(NumberFormatter.localizedString(from: NSNumber(value: mileage), number: .decimal)) miles"
    }
} 