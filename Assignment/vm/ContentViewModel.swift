import Foundation

class ContentViewModel : ObservableObject {
    
    private let apiService = ApiService()
    @Published var navigateDetail: DeviceData?
    @Published var data: [DeviceData] = []
    @Published var isLoading: Bool = false

    func fetchAPI() {
        isLoading = true
        
        apiService.fetchDeviceDetails(completion: { item in
            DispatchQueue.main.async {
                self.data = item
                self.isLoading = false
                print("ViewModel Data : \(self.data)")
            }
        })
    }
    
    func navigateToDetail(navigateDetail: DeviceData) {
        self.navigateDetail = navigateDetail
    }
}
