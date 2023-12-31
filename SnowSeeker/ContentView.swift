//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Ricky David Groner II on 11/3/23.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @State private var sortBy: String = "Default"
    @State private var showingSortByPicker = false
    @StateObject var favorites = Favorites()
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    var sortedResorts: [Resort] {
        switch sortBy {
        case "Alphabetical":
            return resorts.sorted { $0.name < $1.name }
            
        case "Country":
            return resorts.sorted { $0.country < $1.country }
            
        default:
            return resorts
        }
    }
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return sortedResorts
        } else {
            return sortedResorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            List(filteredResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 50)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 5)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .toolbar(content: {
                ToolbarItem {
                    Button("Sort by") {
                        showingSortByPicker.toggle()

                    }
                    .sheet(isPresented: $showingSortByPicker) {
                        Picker("Sort by", selection: $sortBy) {
                            ForEach(["Default", "Alphabetical", "Country"], id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.wheel)
                        .presentationDetents([.medium])
                    }
                }
            })
            .searchable(text: $searchText, prompt: "Search for a resort")
            
            WelcomeView()
        }
        .environmentObject(favorites)
    }
}

#Preview {
    ContentView()
}
