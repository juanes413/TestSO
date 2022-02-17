//
//  APIService.swift
//  TestSO
//
//  Created by Juan Esteban Pelaez on 16/02/22.
//
import Foundation

class APIService {
    
    static let baseUrl = "restcountries-v1.p.rapidapi.com"
    static let apiKey = "97c89c5cb5mshc73d0c89c3c72d8p12b0d4jsn0aac3b88c286"
    static let method = "all"
    
    private let session: URLSession
    
    // By using a default argument (in this case .shared) we can add dependency
    // injection without making our app code more complicated.
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    //Invocacion del servicio
    func downloadCountries(completion: @escaping (_ success: Bool, _ results: [Country]?) -> ()) {
        
        /*
        guard let request = getURLRequestRapiDapi(method: APIService.method) else {
            completion(false, nil)
            return
        }
        */
        
        guard let request = getURLRequestRest() else {
            completion(false, nil)
            return
        }
        
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(false, nil)
                return
            }
            
            guard let data = data, error == nil else {
                completion(false, nil)
                return
            }
            
            do {//Mapear el resultado del servicio al objeto minimo requerido para esta prueba
                let model = try JSONDecoder().decode([Country].self, from: data)
                completion(true, model)
            } catch {
                completion(false, nil)
            }
            
        }
        task.resume()
    }
    
    private func getURLRequestRapiDapi(method: String) -> URLRequest? {
        let headers = [
            "x-rapidapi-host": APIService.baseUrl,
            "x-rapidapi-key": APIService.apiKey
        ]
        
        guard let url = URL(string: ("https://\(APIService.baseUrl)/\(method)")) else {
            return nil
        }
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        return request
    }
    
    private func getURLRequestRest() -> URLRequest? {
        
        guard let url = URL(string: ("https://restcountries.com/v2/all")) else {
            return nil
        }
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        
        return request
    }
    
    
}
