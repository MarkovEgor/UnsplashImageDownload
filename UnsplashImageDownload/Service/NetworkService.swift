



import Foundation

class NetworkService {
    
    func reguest(searchTerm: String, completion: @escaping (Data?, Error?) -> Void) {
        
        let parameters = self.prepareParametrs(searchTerm: searchTerm)
        let url = self.url(params: parameters)
        var reguest = URLRequest(url: url)
        reguest.allHTTPHeaderFields = prepareHeader()
        reguest.httpMethod = "get"
        let task = createDataTask(form: reguest, completion: completion)
        print("url" , url)
        task.resume()
    }
    
    private func prepareHeader() -> [String: String]? {
        var headers = [String: String]()
        headers["Authorization"] = "Client-ID ONG6ms2rWDoOqeKVx6xHATp5EM34ExcCHa0XOgIlNIM"
        return headers
    }
    
    private func prepareParametrs(searchTerm: String)  -> [String: String] {
        var parameters = [String: String]()
        parameters["query"] = searchTerm
        parameters["page"] = String(1)
        parameters["per_page"] = String(30)
        
        return parameters
    }
    
    private func url(params: [String: String]) -> URL {
        var componets = URLComponents()
        componets.scheme = "https"
        componets.host = "api.unsplash.com"
        componets.path = "/search/photos"
        componets.queryItems = params.map {URLQueryItem(name: $0, value: $1)}
        
        return componets.url!
    }
    
  
    private func createDataTask(form reguest: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        
        return URLSession.shared.dataTask(with: reguest, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        })
    }
    
    
    private func urlPhoto(params: [String: String]) -> URL {
        var componets = URLComponents()
        componets.scheme = "https"
        componets.host = "api.unsplash.com"
        componets.path = "/photos/random/"
        componets.queryItems = params.map {URLQueryItem(name: $0, value: $1)}
        
        return componets.url!
    }
    
    private func prepareParametrsPhoto()  -> [String: String] {
        var parameters = [String: String]()
        parameters["count"] = String(30)
        return parameters
    }
    
    func reguestPhoto(completion: @escaping (Data?, Error?) -> Void) {
        
        let parameters = self.prepareParametrsPhoto()
        let url = self.urlPhoto(params: parameters)
        var reguest = URLRequest(url: url)
        reguest.allHTTPHeaderFields = prepareHeader()
        reguest.httpMethod = "get"
        let task = createDataTask(form: reguest, completion: completion)
        print("url" , url)
        task.resume()
    }

}



