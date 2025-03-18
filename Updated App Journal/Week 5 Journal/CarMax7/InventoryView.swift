import SwiftUI

struct InventoryView: View {
    @ObservedObject var inventory: CarInventory
    @State private var searchText = ""
    @State private var showingFilters = false
    @State private var maxPrice: Double?
    @State private var selectedCondition: CarCondition?
    
    var filteredCars: [CarModel] {
        inventory.searchCars(
            make: searchText.isEmpty ? nil : searchText,
            maxPrice: maxPrice,
            condition: selectedCondition
        )
    }
    
    var body: some View {
        List {
            Section {
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search by make", text: $searchText)
                }
                
                Button(action: { showingFilters.toggle() }) {
                    HStack {
                        Text("Filters")
                        Spacer()
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
            
            if showingFilters {
                Section(header: Text("Filters")) {
                    HStack {
                        Text("Max Price:")
                        TextField("No limit", value: $maxPrice, format: .currency(code: "USD"))
                            .keyboardType(.decimalPad)
                    }
                    
                    Picker("Condition", selection: $selectedCondition) {
                        Text("Any").tag(nil as CarCondition?)
                        ForEach([CarCondition.new, .excellent, .good, .fair, .poor]) { condition in
                            Text(condition.rawValue).tag(condition as CarCondition?)
                        }
                    }
                }
            }
            
            Section {
                if filteredCars.isEmpty {
                    Text("No cars found")
                        .foregroundColor(.gray)
                } else {
                    ForEach(filteredCars, id: \.vin) { car in
                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(car.year) \(car.make) \(car.model)")
                                .font(.headline)
                            Text(car.formattedPrice)
                                .foregroundColor(.green)
                            Text("\(car.formattedMileage) • \(car.condition.rawValue)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                inventory.removeCar(withVIN: car.vin)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Inventory")
        .navigationBarTitleDisplayMode(.inline)
    }
} 