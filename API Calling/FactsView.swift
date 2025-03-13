//
//  FactsView.swift
//  API Calling
//
//  Created by Tessa Murray on 3/13/25.
//

import SwiftUI

struct FactsView: View {
    var planet: Planet
    //
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            Text(planet.englishName)
                .font(.title)
                .bold()
            Image("\(planet.englishName)")
                .resizable()
                .frame(width: 250, height: 250)
            if let gravity = planet.gravity {
                Text("Gravity: \(gravity) m/s^2")
            }
            
            if let density = planet.density {
                Text("Density: \(density) g/cm^3")
            }
            
            if let mass = planet.mass?.massValue {
                            Text("Mass: \(mass) × 10^\(planet.mass?.massExponent ?? 0) kg")
                        }
            Spacer()
        }
        .padding()
        .navigationTitle(planet.englishName)
    }
}
