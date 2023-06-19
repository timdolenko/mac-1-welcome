
//: [Previous](@previous)

import Foundation

struct MigrationConfig {
    let name: String
    let target: String
}

enum MigrationKey: String {
    case trackingId
    case jwt
    case userMail
}

enum KeychainKey {
    case trackingId
    case mail
}

protocol KeychainService {
    func set(_ value: Any?, for key: KeychainKey)
}

final class MigrationServiceLive {
    private let keychainService: KeychainService
    private let config: MigrationConfig
    private lazy var defaults = UserDefaults(suiteName: config.name)

    init(keychainService: KeychainService, config: MigrationConfig) {
        self.keychainService = keychainService
        self.config = config
    }

    func migrate() {
        migrate(.trackingId, .trackingId)

        migrateJwt()

        migrate(.userMail, .mail)
    }

    private func migrate(_ key: MigrationKey, _ keychainKey: KeychainKey) {
        guard let value = defaults?
            .string(forKey: config.targetKey(key)) else { return }
        keychainService.set(value, for: keychainKey)
        defaults?.setValue(nil, forKey: config.targetKey(key))
    }

    private func migrateJwt() {
        let jwtKey = config.target + MigrationKey.jwt.rawValue
        if let jwt = defaults?.value(forKey: jwtKey) as? String {
            UserDefaults.standard.setValue(jwt, forKey: "jwt")
            defaults?.setValue(nil, forKey: jwtKey)
        }
    }

    private func migrate(_ key: MigrationKey, _ keychainKey: KeychainKey) {
        guard let value = defaults?
            .string(forKey: config.targetKey(key)) else { return }
        keychainService.set(value, for: keychainKey)
        defaults?.setValue(nil, forKey: config.targetKey(key))
    }
}

fileprivate extension MigrationConfig {
    func targetKey(_ key: MigrationKey) -> String {
        target + key.rawValue
    }
}
