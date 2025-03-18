//
//  ContentView.swift
//  CursorDemo
//
//  Created by Poluru, Shriya on 3/17/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var habitStore = HabitStore()
    @State private var showingAddAnimation = false
    @State private var showingSettings = false
    @State private var showingProfile = false
    
    var body: some View {
        TabView {
            // Home Tab
            NavigationView {
                ScrollView {
                    VStack(alignment: .leading, spacing: 30) {
                        // Greeting
                        Text("good morning.")
                            .font(.system(size: 36, weight: .bold))
                            .padding(.top, 20)
                        
                        // Date Scroll
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(-3...3, id: \.self) { dayOffset in
                                    let date = Calendar.current.date(byAdding: .day, value: dayOffset, to: Date()) ?? Date()
                                    let isToday = Calendar.current.isDateInToday(date)
                                    
                                    VStack {
                                        Text(date.weekdayShortString)
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundColor(isToday ? .black : .gray)
                                        Text(date.dayString)
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundColor(isToday ? .black : .gray)
                                    }
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 12)
                                    .background(isToday ? Color(.systemBackground) : Color.clear)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(isToday ? Color.black : Color.clear, lineWidth: 1)
                                    )
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        // Habit Cards
                        VStack(spacing: 20) {
                            // Streak Card
                            HabitCard(
                                title: "Current Streak",
                                subtitle: "\(habitStore.getCurrentStreak()) days",
                                icon: "circle.fill",
                                isBlack: true
                            )
                            .scaleEffect(showingAddAnimation ? 1.05 : 1.0)
                            
                            // Today's Count Card
                            HabitCard(
                                title: "Today's Progress",
                                subtitle: "\(habitStore.entries.first(where: { Calendar.current.isDate($0.date, inSameDayAs: Date()) })?.count ?? 0) times",
                                icon: "moon.fill",
                                isBlack: false
                            )
                            .scaleEffect(showingAddAnimation ? 1.05 : 1.0)
                        }
                        .padding(.top, 20)
                        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: showingAddAnimation)
                    }
                    .padding()
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: { showingSettings = true }) {
                            Image(systemName: "leaf")
                                .foregroundColor(.gray)
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { showingProfile = true }) {
                            Image(systemName: "person.circle")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .sheet(isPresented: $showingSettings) {
                    SettingsView()
                }
                .sheet(isPresented: $showingProfile) {
                    ProfileView(habitStore: habitStore)
                }
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            
            // Stats Tab
            NavigationView {
                ScrollView {
                    VStack(spacing: 30) {
                        Text("statistics.")
                            .font(.system(size: 36, weight: .bold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 20)
                        
                        // Stats Cards
                        VStack(spacing: 20) {
                            StatCard(title: "Total Days", value: "\(habitStore.entries.count)")
                            StatCard(title: "Best Streak", value: "\(habitStore.getCurrentStreak())")
                            StatCard(title: "Total Count", value: "\(habitStore.entries.reduce(0) { $0 + $1.count })")
                        }
                        
                        // Contribution Graph
                        ContributionGraphView(entries: habitStore.entries)
                            .frame(height: 200)
                    }
                    .padding()
                }
                .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Stats", systemImage: "chart.bar.fill")
            }
        }
        .overlay(
            // Add Habit Button
            VStack {
                Spacer()
                Button(action: {
                    let impactMed = UIImpactFeedbackGenerator(style: .medium)
                    impactMed.impactOccurred()
                    
                    withAnimation {
                        showingAddAnimation = true
                        habitStore.addEntry()
                    }
                    
                    // Reset animation after a short delay
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        showingAddAnimation = false
                    }
                }) {
                    Image(systemName: "plus")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 60, height: 60)
                        .background(Color.black)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                }
                .padding(.bottom, 60)
            }
        )
        .accentColor(.black)
    }
}

struct HabitCard: View {
    let title: String
    let subtitle: String
    let icon: String
    let isBlack: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.system(size: 24, weight: .bold))
                Text(subtitle)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(isBlack ? .white : .gray)
            }
            Spacer()
            Image(systemName: icon)
                .font(.system(size: 30))
        }
        .foregroundColor(isBlack ? .white : .black)
        .padding(20)
        .background(isBlack ? Color.black : Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 10)
    }
}

struct StatCard: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.gray)
            Text(value)
                .font(.system(size: 24, weight: .bold))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.1), radius: 10)
    }
}

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    @AppStorage("notificationsEnabled") private var notificationsEnabled = false
    @AppStorage("reminderTime") private var reminderTime = Date()
    @AppStorage("darkModeEnabled") private var darkModeEnabled = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Preferences")) {
                    Toggle("Enable Notifications", isOn: $notificationsEnabled)
                    
                    if notificationsEnabled {
                        DatePicker("Daily Reminder",
                                 selection: $reminderTime,
                                 displayedComponents: .hourAndMinute)
                    }
                    
                    Toggle("Dark Mode", isOn: $darkModeEnabled)
                }
                
                Section(header: Text("About")) {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.gray)
                    }
                    
                    Button("Privacy Policy") {
                        // Add privacy policy link
                    }
                    
                    Button("Terms of Service") {
                        // Add terms of service link
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct ProfileView: View {
    @Environment(\.dismiss) var dismiss
    let habitStore: HabitStore
    
    var achievements: [(String, Bool)] {
        [
            ("First Step", habitStore.entries.count >= 1),
            ("Week Warrior", habitStore.getCurrentStreak() >= 7),
            ("Month Master", habitStore.getCurrentStreak() >= 30),
            ("Century Club", habitStore.entries.reduce(0) { $0 + $1.count } >= 100),
            ("Early Bird", habitStore.entries.contains { Calendar.current.component(.hour, from: $0.date) < 8 })
        ]
    }
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    VStack(spacing: 16) {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 80))
                            .foregroundColor(.gray)
                        
                        Text("Your Progress")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        HStack(spacing: 20) {
                            StatBox(title: "Current Streak", value: "\(habitStore.getCurrentStreak())")
                            StatBox(title: "Total Days", value: "\(habitStore.entries.count)")
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                }
                
                Section(header: Text("Achievements")) {
                    ForEach(achievements, id: \.0) { achievement in
                        HStack {
                            Image(systemName: achievement.1 ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(achievement.1 ? .green : .gray)
                            
                            Text(achievement.0)
                                .foregroundColor(achievement.1 ? .primary : .gray)
                            
                            if achievement.1 {
                                Spacer()
                                Image(systemName: "trophy.fill")
                                    .foregroundColor(.yellow)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct StatBox: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack {
            Text(value)
                .font(.title)
                .fontWeight(.bold)
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5)
    }
}

// Date Extension for formatting
extension Date {
    var weekdayShortString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(from: self)
    }
    
    var dayString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter.string(from: self)
    }
}

#Preview {
    ContentView()
}
