//
//  UserDefault.swift
//  ShopingAppSwiftUI
//
//  Created by mohamed ahmed on 24/03/2025.
//

import Foundation

/**
 Cache Manager
 - Read
    // Fetch Value
 - Write
    // Save Value
    // Delete Value
 */

protocol ReadableStorage {
    func fetchValue<T: Codable>(for key: StorageKey) throws -> T
}

protocol WritableStorage {
    func save<T: Codable>(_ value: T, for key: StorageKey) throws
    func remove(for key: StorageKey) throws
}

typealias Storage = ReadableStorage & WritableStorage

enum StorageKey: String, CaseIterable {
    case user
    case token

    var suitableStorage: CacheManager.SupportedStorage {
        switch self {
        case .user:
            return .userDefaults
        case .token:
            return .encrypted
        }
    }
}

enum StorageError: Error {
    case notFound
    case cantWrite(Error)
    case cantDelete(StorageKey)
}

final class UserDefaultStorage {
    private let defaults: UserDefaults = UserDefaults.standard
}

extension UserDefaultStorage: ReadableStorage {
    func fetchValue<T: Codable>(for key: StorageKey) throws -> T {
        guard let data = defaults.data(forKey: key.rawValue) else { throw StorageError.notFound }
        let value = try JSONDecoder().decode(T.self, from: data)
        return value
    }
}

extension UserDefaultStorage: WritableStorage {
    func save<T: Codable>(_ value: T, for key: StorageKey) throws {
        let data = try JSONEncoder().encode(value)
        defaults.set(data, forKey: key.rawValue)
    }
    
    func remove(for key: StorageKey) throws {
        defaults.removeObject(forKey: key.rawValue)
    }
}

import KeychainSwift

final class EncryptedStorage {
    private let keychain = KeychainSwift()
}

extension EncryptedStorage: ReadableStorage {
    func fetchValue<T: Codable>(for key: StorageKey) throws -> T {
        guard let data = keychain.getData(key.rawValue) else { throw StorageError.notFound }
        let value = try JSONDecoder().decode(T.self, from: data)
        return value
    }
}

extension EncryptedStorage: WritableStorage {
    func save<T: Codable>(_ value: T, for key: StorageKey) throws {
        let data = try JSONEncoder().encode(value)
        keychain.set(data, forKey: key.rawValue)
    }

    func remove(for key: StorageKey) throws {
        keychain.delete(key.rawValue)
    }
}


final class CacheManager {

    enum SupportedStorage {
        case userDefaults
        case encrypted
    }

    private lazy var userDefaultsStorage = UserDefaultStorage()
    private lazy var encryptedStorage = EncryptedStorage()

    func fetchValue<T: Codable>(for key: StorageKey) throws -> T {
        try getSuitableStorage(from: key.suitableStorage).fetchValue(for: key)
    }

    func save<T: Codable>(_ value: T, for key: StorageKey) throws {
        try getSuitableStorage(from: key.suitableStorage).save(value, for: key)
    }

    func remove(for key: StorageKey) throws {
        try getSuitableStorage(from: key.suitableStorage).remove(for: key)
    }
}

private extension CacheManager {

    func getSuitableStorage(from choice: SupportedStorage) -> Storage {
        switch choice {
        case .userDefaults:
            return userDefaultsStorage
        case .encrypted:
            return encryptedStorage
        }
    }
}
