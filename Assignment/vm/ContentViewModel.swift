import Foundation

class ContentViewModel : ObservableObject {
    
    private let apiService = ApiService()
    @Published var navigateDetail: DeviceData?
    @Published var data: [DeviceData] = []
    @Published var isLoading: Bool = false

    func fetchAPI() {
        isLoading = true
        
        apiService.fetchDeviceDetails(completion: { item in
            // Bug is here - we have to load the data that needed to display on the main thread issue yet so far is that it isloading on                      Background Thread till now
            DispatchQueue.main.async {
                self.data = item
                // Added a new variable to control the progress view from viewModel
                self.isLoading = false
                print("ViewModel Data : \(self.data)")
            }
        })
    }
    
    func navigateToDetail(navigateDetail: DeviceData) {
        self.navigateDetail = navigateDetail
    }
}
