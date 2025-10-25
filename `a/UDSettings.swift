//
//  UDSettings.swift
//  `a
//
//  Created by 1111 on 23.10.2025.
//

import Foundation

protocol StorageManagerProtocol{
    func set(_ object: Any?, forKey key: StorageManager.Keys)
    
    func string (forKey key: StorageManager.Keys)->String?
    
    func stringArray(forKey key: StorageManager.Keys) -> [String]?
}

final class StorageManager{
    public enum Keys: String{
        case SavedCities
    }
    
    private let userDefaults = UserDefaults.standard

}

extension StorageManager: StorageManagerProtocol{
    func set(_ object: Any?, forKey key: Keys) {
        userDefaults.set(object, forKey: key.rawValue)
    }
    
    func string(forKey key: Keys) -> String? {
        userDefaults.string(forKey: key.rawValue)
    }
    
    func stringArray(forKey key: Keys) -> [String]? {
        userDefaults.stringArray(forKey: key.rawValue)
    }
    
    func remove(forKey key: Keys) {
        userDefaults.removeObject(forKey: key.rawValue)
    }
}
