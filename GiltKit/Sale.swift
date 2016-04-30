import Foundation

public enum Store: String {
    case Men = "men"
    case Women = "women"
    case Kids = "kids"
    case Home = "home"
}

public struct Sale {

    public enum Kind: String {
        case Upcoming = "upcoming"
        case Active = "active"
    }

    public let name: String
    public let description: String
    public let imageURL: NSURL
    public let size: UInt
    public let store: Store
}


extension Sale: DictionaryDeserializable {

    public init?(dictionary: JSONDictionary) {
        guard let name = dictionary["name"] as? String,
            description = dictionary["description"] as? String,
            imageURLSizes = dictionary["image_urls"] as? JSONDictionary,
            imageURLSizeArray = imageURLSizes["676x686"] as? [JSONDictionary],
            imageURLSize = imageURLSizeArray.first,
            imageURLString = imageURLSize["url"] as? String,
            imageURL = NSURL(string: imageURLString),
            size = dictionary["size"] as? UInt,
            storeString = dictionary["store"] as? String,
            store = Store(rawValue:storeString) else { return nil }

        self.name = name
        self.description = description
        self.imageURL = imageURL
        self.size = size
        self.store = store
    }
}