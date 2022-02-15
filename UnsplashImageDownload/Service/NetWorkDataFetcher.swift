



import Foundation

class NetWorkDataFetcher {
    
    var network = NetworkService()
    
    func fetchImage(searchTerm: String, completion: @escaping (SearchResult?) -> () ) {
        network.reguest(searchTerm: searchTerm) { (data, error) in
            if let error = error {
                print("Error received reguesting data: \(error.localizedDescription)")
                completion(nil)
            }
        
            
            let decode = self.decodeJSON(type: SearchResult.self, from: data)
            completion(decode)
            
        }
        
    }
    
    
    func updateData(completion: @escaping ([UnsplashPhooto]?) -> ()) {
        
        network.reguestPhoto { (data, error) in
            if let error = error {
                print("Error received reguesting data: \(error.localizedDescription)")
                completion(nil)
            }
            
            let decode = self.decodeJSON(type: [UnsplashPhooto].self, from: data)
            completion(decode)
        }
        
    }
    
    
    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        
        let decoder = JSONDecoder()
        guard let data = from else {return nil}
        
        do {
            
            let objects = try decoder.decode(type.self, from: data)
            return objects
       
        } catch let errorJSON  {
            print("Failed to dcode JSON", errorJSON)
            return nil
        }
    }
    
    
    
}
