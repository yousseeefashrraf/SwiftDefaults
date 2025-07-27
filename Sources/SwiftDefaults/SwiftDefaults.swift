import Foundation

/// A protocol that provides a default value and a storage key for types used with `UserDefaults`.
///
/// Conforming types must define a static `defaultValue` and a unique `key` to allow for
/// automatic initialization and retrieval from `UserDefaults`.
///
/// Use this protocol when you want to manage default values and persistent storage
/// in a standardized and type-safe way.

protocol DefaultValue{
    associatedtype defaultType
    static var defaultValue: defaultType {get}
    static var key: String {get}
}

final class UserDefaultsManager: @unchecked Sendable {
    static let shared = UserDefaultsManager()
    private init () {}
    
    /// Initializes a `UserDefaults` entry with a default value if it does not already exist.
    ///
    /// This method checks whether a value for the specified type is already stored in `UserDefaults`.
    /// If no value is found, it stores the type's `defaultValue` using its associated `key`.
    ///
    /// - Parameter type: The type conforming to `DefaultValue` that provides both a `defaultValue` and a `key`.
    func initiate<T: DefaultValue>(forType type: T.Type) where T.defaultType: RawRepresentable, T.defaultType.RawValue == String{
        if !isStored(forKey: type.key) {
            UserDefaults.standard.setValue(type.defaultValue.rawValue, forKey: type.key)
        }
    }

    /// Checks whether a value is already stored in `UserDefaults` for a given key.
    ///
    /// This method returns `true` if a value exists for the specified key,
    /// and `false` otherwise. It does not compare the value itself —
    /// only checks for the presence of any value at the specified key.
    ///
    /// - Parameters:
    ///   - key: The key associated with the stored value in `UserDefaults`.
    /// - Returns: A Boolean value indicating whether a value exists for the given key.
    ///
    func isStored(forKey key: String) -> Bool{
        UserDefaults.standard.object(forKey: key) != nil
    }
    
    /// Stores a value in `UserDefaults` for a given key if it's not already stored.
    ///
    /// - Parameters:
    ///   - type: A type conforming to `DefaultValue` protocol, used to get the key.
    ///   - value: The value to store in `UserDefaults`.
    ///
    func store<T: DefaultValue>(forType type: T.Type,value: T) where T: RawRepresentable, T.RawValue == String {
        if isStored(forKey: type.key) {
            UserDefaults.standard.setValue(value.rawValue, forKey: type.key)
        }
    }
    
    func getStoredValue<T: DefaultValue>(forType type: T.Type)  -> String? where T.defaultType: RawRepresentable, T.defaultType.RawValue == String{

        let result = UserDefaults.standard.string(forKey: type.key)
            return result
        
        
    }
}
