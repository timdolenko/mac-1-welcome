import Foundation

public protocol PushSettings: AnyObject {
    // MARK: - Properties

    var oldDeviceToken: String? { get }
    var deviceToken: String? { get set }
    var deviceTokenData: Data? { get set }
    var externalId: String? { get set }
    var currentId: PushUserIdentifier? { get }
    var isRegistrationRequired: Bool { get set }

    // MARK: - Methods

    func set(id: PushUserIdentifier)
    func tokenToString(data: Data) -> String
    func deleteData()

    /// This method would remove old device token from storage after successful
    /// acknowledgement from server once we notify about change of token.
    func resetOldDeviceToken()
}

public extension PushSettings {
    func tokenToString(data: Data) -> String {
        // check for simulator
        #if targetEnvironment(simulator)
            "cca351b05e279942ebd9dac4603dca1ffd433e7e7256fa7ec618910ff86cdd25"
        #else
            data.map { String(format: "%02.2hhx", $0) }.joined()
        #endif
    }
}

public final class DefaultPushSettings: PushSettings {
    // MARK: - Public Properties

    public var oldDeviceToken: String? {
        storage.deviceTokenMigrated ?? storage.deviceTokenOld
    }

    @Storage(key: "isRegistrationRequired", defaultValue: true)
    public var isRegistrationRequired: Bool

    public var currentId: PushUserIdentifier? {
        if let id = externalId {
            return .externalId(id)
        } else if let token = deviceToken {
            return .deviceToken(token)
        }

        return nil
    }

    public var deviceTokenData: Data? {
        didSet {
            deviceTokenData.flatMap { deviceToken = tokenToString(data: $0) }
        }
    }

    public var externalId: String? {
        get { storage.externalId }
        set { storage.externalId = newValue }
    }

    public var deviceToken: String? {
        get { storage.deviceToken }
        set {
            // In case user device token is changed we need to send update.
            // Please read here more: https://stackoverflow.com/questions/72645196/does-device-token-change-after-update-ios-os-to-newer-version
            if let oldDeviceToken = deviceToken,
               let updatedDeviceToken = newValue,
               oldDeviceToken != updatedDeviceToken {
                storage.deviceTokenOld = oldDeviceToken
            }

            storage.deviceToken = newValue
        }
    }

    // MARK: - Private properties

    private let storage: PushSettingsStorage = PushSettingsStorageLive()

    // MARK: - Initializer

    public init() {}

    // MARK: - Public Methods

    public func set(id: PushUserIdentifier) {
        switch id {
        case let .externalId(id):
            externalId = id
        case let .deviceToken(token):
            deviceToken = token
        }
    }

    public func deleteData() {
        storage.deviceToken = nil
    }

    public func resetOldDeviceToken() {
        storage.deviceTokenOld = nil
        storage.deviceTokenMigrated = nil
    }
}

#if DEBUG
    public class MockPushSettings: PushSettings {
        public var isRegistrationRequired: Bool = false

        public var currentId: PushUserIdentifier?

        public var oldDeviceToken: String?

        public var deviceToken: String?

        public var deviceTokenData: Data?

        public var externalId: String?

        public init() {}

        public func tokenToString(data: Data) -> String {
            ""
        }

        public func set(id: PushUserIdentifier) {}

        public func deleteData() {}

        public func resetOldDeviceToken() {}
    }
#endif

