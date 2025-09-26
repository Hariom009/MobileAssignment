import Foundation

class ApiService : NSObject {
    private let sourcesURL = URL(string: "https://api.restful-api.dev/objects")!
    
    func fetchDeviceDetails(completion: @escaping ([DeviceData]) -> ()) {
        URLSession.shared.dataTask(with: sourcesURL) { (data, urlResponse, error) in
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                completion([])
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion([])
                return
            }
            
            // Debug: Print raw JSON response
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON Response: \(jsonString)")
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let empData = try jsonDecoder.decode([DeviceData].self, from: data)
                print("Successfully decoded \(empData.count) items")
                print("First item: \(empData.first?.name ?? "No name")")
                completion(empData)
            }catch {
                print(" decoding error: \(error)")
                completion([])
            }
        }.resume()
    }
    
    func fetchData() async -> [DeviceData] {
        await withCheckedContinuation { continuation in
            fetchDeviceDetails { devices in
                continuation.resume(returning: devices)
            }
        }
    }
}
