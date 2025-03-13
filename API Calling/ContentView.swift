//
//  ContentView.swift
//  API Calling
//
//  Created by Tessa Murray on 3/5/25.
//

import SwiftUI

struct Planet: Identifiable, Codable {
    var id: String
    var englishName: String
    var isPlanet: Bool
}

struct SolarSystemResponse: Codable {
    let bodies: [Planet]
}

struct ContentView: View {
    @State private var planets: [Planet] = []
    @State private var showingAlert = false
    var body: some View {
        NavigationView {
            List(planets) { planet in
                NavigationLink(destination: Text(planet.englishName)) {
                    Text(planet.englishName)
                }
            }
            .navigationTitle("Planets")
            .task { await getPlanets() }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Loading Error"),
                      message: Text("An error has occured."),
                      dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func getPlanets() async {
        let query = "https://api.le-systeme-solaire.net/rest/bodies/"
        guard let url = URL(string: query) else { return }
        if let (data, _) = try? await URLSession.shared.data(from: url) {
            if let decodedResponse = try? JSONDecoder().decode(SolarSystemResponse.self, from: data) {
                DispatchQueue.main.async {
                    planets = decodedResponse.bodies.filter { $0.isPlanet
                    }
                }
                return
            }
        }
        DispatchQueue.main.async {
            showingAlert = true
        }
    }
}

#Preview {
    ContentView()
}
