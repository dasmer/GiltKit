typealias JSONDictionary = [String: AnyObject]

protocol DictionaryDeserializable {
    init?(dictionary: JSONDictionary)
}