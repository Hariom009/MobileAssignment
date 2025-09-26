//
//  ContentView.swift
//  Assignment
//
//  Created by Kunal on 03/01/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel() // Use @StateObject instead of private var
    @State private var path: [DeviceData] = [] // Navigation path

    var body: some View {
        NavigationStack(path: $path) {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if viewModel.data.isEmpty {
                    Text("No devices found")
                } else {
                    DevicesList(devices: viewModel.data) { selectedComputer in
                        viewModel.navigateToDetail(navigateDetail: selectedComputer)
                    }
                }
            }
            .onChange(of: viewModel.navigateDetail) { _, newValue in
                if let navigate = newValue {
                    path.append(navigate)
                }
            }
            .navigationTitle("Devices")
            .navigationDestination(for: DeviceData.self) { computer in
                DetailView(device: computer)
            }
            // Loading the ui on appear of view to avoid progress view after landing
            .onAppear {
                // Simplified - just call fetchAPI once
                if viewModel.data.isEmpty {
                    viewModel.fetchAPI()
                }
            }
        }
    }
}
