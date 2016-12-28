//
//  ResponseSerializationExtentions.swift
//  LeagueAPI
//
//  Created by Mason Phillips on 27Dec16.
//
//

import UIKit
import Alamofire

public protocol ResponseObjectSerializable {
    init?(response: HTTPURLResponse, representation: Any)
}

extension DataRequest {
    func responseObject<T: ResponseObjectSerializable> (queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        let serializer = DataResponseSerializer<T> { (request, response, data, error) -> Result<T> in
            guard error == nil else { return .failure(MSCoreError.network(e: error!)) }
            
            let jsonSerializer = DataRequest.jsonResponseSerializer(options: .allowFragments)
            let result = jsonSerializer.serializeResponse(request, response, data, error)
            
            guard case let .success(jsonObject) = result else {
                return .failure(MSCoreError.jsonSerialization(e: result.error!))
            }
            
            guard let response = response, let responseObject = T(response: response, representation: jsonObject) else {
                return .failure(MSCoreError.objectSerialization(reason: "Could not be serialized: \(jsonObject)"))
            }
            
            return .success(responseObject)
        }
        
        return response(queue: queue, responseSerializer: serializer, completionHandler: completionHandler)
    }
}

protocol ResponseCollectionSerializable {
    static func collection(from response: HTTPURLResponse, withRepresentation representation: Any) -> [Self]
}

extension ResponseCollectionSerializable where Self: ResponseObjectSerializable {
    static func collection(from response: HTTPURLResponse, withRepresentation representation: Any) -> [Self] {
        var collection: [Self] = []
        
        guard let representation = representation as? Dictionary<String, Any> else {
            debugPrint("Fail")
            return []
        }
        
        guard let drillRep = representation["data"] as? [String: Any] else {
            debugPrint("Fail to drill down")
            return []
        }
        
        for champRepresetation in drillRep.values {
            if let champ = Self(response: response, representation: champRepresetation) {
                collection.append(champ)
            }
        }
        
        return collection
    }
}

extension DataRequest {
    @discardableResult
    func responseCollection<T: ResponseCollectionSerializable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<[T]>) -> Void) -> Self {
        let responseSerializer = DataResponseSerializer<[T]> { request, response, data, error in
            guard error == nil else { return .failure(MSCoreError.network(e: error!)) }
            
            let jsonSerializer = DataRequest.jsonResponseSerializer(options: .allowFragments)
            let result = jsonSerializer.serializeResponse(request, response, data, nil)
            
            guard case let .success(jsonObject) = result else {
                return .failure(MSCoreError.jsonSerialization(e: result.error!))
            }
            
            guard let response = response else {
                let reason = "Response collection could not be serialized due to nil response."
                return .failure(MSCoreError.objectSerialization(reason: reason))
            }
            
            return .success(T.collection(from: response, withRepresentation: jsonObject))
        }
        
        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}

enum MSCoreError: Error {
    case missingValidKey(details: String)
    case network(e: Error)
    case dataSerialization(e: Error)
    case jsonSerialization(e: Error)
    case objectSerialization(reason: String)
}
