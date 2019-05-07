//
//  DataStoreService+Availability.swift
//  DogWalking
//
//  Created by Robert Ryan on 5/7/19.
//  Copyright © 2019 Robert Ryan. All rights reserved.
//

import Foundation

private let path = "slots"

extension DataStoreService {
    func save(_ availability: Availability, completion: @escaping (Result<Availability, Error>) -> Void) {
        save(in: path, values: availability.dictionary) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))

            case .success(let key):
                var newAvailability = availability
                newAvailability.id = key
                completion(.success(newAvailability))
            }
        }
    }

    func remove(_ availability: Availability, completion: @escaping (Result<Availability, Error>) -> Void) {
        remove(in: path, key: availability.id!) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))

            case .success:
                completion(.success(availability))
            }
        }
    }

    func observeAddition(with block: @escaping (Result<Availability, Error>) -> Void) {
        observe(.childAdded, path: path) { snapshot in
            var dictionary = snapshot.value as? [String: Any] ?? [:]
            dictionary["id"] = snapshot.key
            guard let availability = Availability(dictionary: dictionary) else {
                block(.failure(DataStoreServiceError.creationFailed))
                return
            }

            block(.success(availability))
        }
    }

    func observeRemoval(with block: @escaping (Result<Availability, Error>) -> Void) {
        observe(.childRemoved, path: path) { snapshot in
            var dictionary = snapshot.value as? [String: Any] ?? [:]
            dictionary["id"] = snapshot.key
            guard let availability = Availability(dictionary: dictionary) else {
                block(.failure(DataStoreServiceError.creationFailed))
                return
            }

            block(.success(availability))
        }
    }
}
