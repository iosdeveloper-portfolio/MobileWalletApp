//
// NetworkManager.swift
// MobileWalletDemo
//

import UIKit
import Alamofire
import CodableAlamofire
import AlamofireNetworkActivityIndicator

class NetworkManager {
    
    static let shared = NetworkManager()
    
    static let networkUnavailableCode: Double = 1000
    
    init() {
        NetworkActivityIndicatorManager.shared.isEnabled = true
    }
    
    func makeRequest<T: Decodable>(_ urlRequest: URLRequestConvertible, isShowProgress: Bool = true, completion: @escaping (Swift.Result<T, NetworkError>) -> ()) {
        
        if isShowProgress {
            RappleIndicator.start(message: LocalizedString.Constants.loading)
        }
        
        Alamofire.request(urlRequest)
            .validate()
            .responseDecodableObject(completionHandler: { (response: DataResponse<T>)-> Void in
                
                switch response.result {
                case .success(let JSON):
                    completion(.success(JSON))
                    
                case .failure(let error):
                    completion(.failure(self.generateError(from: error, with: response)))
                }
                RappleIndicator.stop()
            })
    }
    
    fileprivate func generateError<T>(from error: Error, with responseObject: DataResponse<T>) -> NetworkError {
        if let data = responseObject.data, !data.isEmpty {
            do {
                let result = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any]
                debugPrint(result ?? "No any response")
                if let error = result?["message"] as? String {
                    return NetworkError.errorString(error)
                }
                else if let error = result?["message"] as? String {
                    return NetworkError.errorString(error)
                }
            }
            catch {
                return NetworkError.errorString(error.localizedDescription)
            }
        }
        
        let code = (error as NSError).code
        switch code {
        case NSURLErrorNotConnectedToInternet, NSURLErrorCannotConnectToHost, NSURLErrorCannotFindHost:
            return NetworkError.error(code: NetworkManager.networkUnavailableCode, message: LocalizedString.Errors.networkUnreachableError)
        default:
            return NetworkError.errorString(error.localizedDescription)
        }
    }
}
