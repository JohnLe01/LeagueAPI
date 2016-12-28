//
//  MSCoreListener.swift
//  Pods
//
//  Created by Mason Phillips on 26Dec16.
//
//

public protocol MSCoreListener {
    var requestTypes: MSInteractionReturnType { get }
    func didReturn(singleObject o: ResponseObjectSerializable)
    func didReturn(collection   c: Array<ResponseObjectSerializable>)
}

public enum MSInteractionReturnType {
    case championData, summonerData
}
