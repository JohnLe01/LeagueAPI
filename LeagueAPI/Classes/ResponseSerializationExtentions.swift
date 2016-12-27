//
//  ResponseSerializationExtentions.swift
//  Pods
//
//  Created by Mason Phillips on 27Dec16.
//
//

import UIKit
import Alamofire

protocol ResponseObjectSerializable {
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

enum MSCoreError: Error {
    case network(e: Error)
    case dataSerialization(e: Error)
    case jsonSerialization(e: Error)
    case objectSerialization(reason: String)
}
