import SwiftUI

struct HomeView: View {
    @StateObject private var inventory = CarInventory()
    @State private var make = ""
    @State private var model = ""
    @State private var year = Calendar.current.component(.year, from: Date())
    @State private var price = 0.0
    @State private var mileage = 0
    @State private var condition = CarCondition.good
    @State private var vin = ""
    @State private var showingInventory = false
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var isAddingCar = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.95, green: 0.95, blue: 1.0)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // Header
                    Text("CarMax Lite")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(Color(red: 0.1, green: 0.3, blue: 0.8))
                        .padding(.top, 30)
                    
                    // Quick Stats
                    HStack(spacing: 20) {
                        StatCard(title: "Total Cars", value: "\(inventory.getAllCars().count)")
                        StatCard(title: "Newest Car", value: getNewestCarYear())
                    }
                    .padding(.horizontal)
                    
                    // Main Actions
                    VStack(spacing: 15) {
                        Button(action: { isAddingCar = true }) {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                Text("Add New Car")
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 0.1, green: 0.3, blue: 0.8))
                            .cornerRadius(12)
                        }
                        
                        NavigationLink(destination: InventoryView(inventory: inventory)) {
                            HStack {
                                Image(systemName: "car.fill")
                                Text("View Inventory")
                            }
                            .font(.headline)
                            .foregroundColor(Color(red: 0.1, green: 0.3, blue: 0.8))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(red: 0.1, green: 0.3, blue: 0.8), lineWidth: 2)
                            )
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
            }
        }
        .sheet(isPresented: $isAddingCar) {
            NavigationView {
                Form {
                    Section(header: Text("Car Details")) {
                        TextField("Make", text: $make)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("Model", text: $model)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Stepper("Year: \(year)", value: $year, in: 1900...Calendar.current.component(.year, from: Date()) + 1)
                        HStack {
                            Text("Price: $")
                            TextField("0", value: $price, formatter: NumberFormatter())
                                .keyboardType(.decimalPad)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        HStack {
                            Text("Mileage:")
                            TextField("0", value: $mileage, formatter: NumberFormatter())
                                .keyboardType(.numberPad)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        Picker("Condition", selection: $condition) {
                            ForEach([CarCondition.new, .excellent, .good, .fair, .poor]) { condition in
                                Text(condition.rawValue).tag(condition)
                            }
                        }
                        TextField("VIN", text: $vin)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .textInputAutocapitalization(.characters)
                    }
                }
                .navigationTitle("Add New Car")
                .navigationBarItems(
                    leading: Button("Cancel") {
                        isAddingCar = false
                    },
                    trailing: Button("Save") {
                        addCar()
                        isAddingCar = false
                    }
                    .disabled(make.isEmpty || model.isEmpty || vin.isEmpty)
                )
            }
        }
        .alert("Message", isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
    }
    
    private func getNewestCarYear() -> String {
        let cars = inventory.getAllCars()
        if let newestYear = cars.map({ $0.year }).max() {
            return "\(newestYear)"
        }
        return "N/A"
    }
    
    private func addCar() {
        let newCar = CarModel(
            make: make,
            model: model,
            year: year,
            price: price,
            mileage: mileage,
            condition: condition,
            vin: vin
        )
        
        inventory.addCar(newCar)
        alertMessage = "Successfully added \(year) \(make) \(model)"
        showingAlert = true
        
        // Reset form
        make = ""
        model = ""
        year = Calendar.current.component(.year, from: Date())
        price = 0
        mileage = 0
        condition = .good
        vin = ""
    }
}

struct StatCard: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(Color(red: 0.1, green: 0.3, blue: 0.8))
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
} 