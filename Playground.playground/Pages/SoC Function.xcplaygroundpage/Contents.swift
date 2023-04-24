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

    init(keychainService: KeychainService, config: MigrationConfig) {
        self.keychainService = keychainService
        self.config = config
    }

    func migrateOld() {
        let defaults = UserDefaults(suiteName: config.name)

        let trackingIdKey = config.target + MigrationKey.trackingId.rawValue

        if let trackingId = defaults?.value(forKey: trackingIdKey) as? String {
            keychainService.set(trackingId, for: .trackingId)
            defaults?.setValue(nil, forKey: trackingIdKey)
        }

        let jwtKey = config.target + MigrationKey.jwt.rawValue
        if let jwt = defaults?.value(forKey: jwtKey) as? String {
            UserDefaults.standard.setValue(jwt, forKey: "jwt")
            defaults?.setValue(nil, forKey: jwtKey)
        }

        let userMailKey = config.target + MigrationKey.userMail.rawValue
        if let userMail = defaults?.value(forKey: userMailKey) as? String {
            keychainService.set(userMail, for: .mail)
            defaults?.setValue(nil, forKey: userMailKey)
        }
    }
}
