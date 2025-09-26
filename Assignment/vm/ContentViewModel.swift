//
//  ContentViewModel.swift
//  Assignment
//
//  Created by Kunal on 10/01/25.
//

import Foundation


class ContentViewModel : ObservableObject {
    
    private let apiService = ApiService()
    @Published var navigateDetail: DeviceData?
    @Published var data: [DeviceData]?
    @Published var isLoading:Bool = false

    func fetchAPI() {
        isLoading = true
        apiService.fetchDeviceDetails(completion: { item in
            self.data = item
        })
        print("ViewModel Data : \(data)")
        isLoading = false
    }
    
    func navigateToDetail(navigateDetail: DeviceData) {
        self.navigateDetail = navigateDetail
    }
}
