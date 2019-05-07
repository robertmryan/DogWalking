//
//  DataStoreService.swift
//  DogWalking
//
//  Created by Robert Ryan on 5/7/19.
//  Copyright © 2019 Robert Ryan. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

enum DataStoreServiceError: Error {
    case creationFailed
    case removalFailed
}

class DataStoreService {
    static let shared = DataStoreService()

    init() {
        FirebaseApp.configure()
    }
    
    func save(in path: String, values: [String: Any], completion: @escaping (Result<String, Error>) -> Void) {
        let ref = Database.database().reference()
        let child = ref.child(path).childByAutoId()
        child.updateChildValues(values) { error, reference in
            guard let key = reference.key else {
                completion(.failure(error!))
                return
            }

            completion(.success(key))
        }
    }

    func remove(in path: String, key: String, completion: @escaping (Result<String, Error>) -> Void) {
        let ref = Database.database().reference()
        ref.child(path).child(key).removeValue { error, reference in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(reference.key!))
            }
        }
    }

    func observe(_ event: DataEventType, path: String, with block: @escaping (DataSnapshot) -> Void) {
        let reference = Database.database().reference().child(path)

        reference.observe(event, with: block)
    }
}
