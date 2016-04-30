public typealias JSONDictionary = [String: AnyObject]

public protocol DictionaryDeserializable {
    init?(dictionary: JSONDictionary)
}

public protocol DictionarySerializable {
    var dictionary: JSONDictionary { get }
}