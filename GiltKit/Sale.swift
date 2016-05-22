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

    init?(dictionary: JSONDictionary) {
        guard let name = dictionary["name"] as? String,
            description = dictionary["description"] as? String,
            imageURLSizes = dictionary["image_urls"] as? JSONDictionary,
            imageURL = NSURL(giltImagesDictionary: imageURLSizes),
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


private extension NSURL {

    private static var imageSizes = ["676x686", "624x668", "506x520", "466x247", "315x295"]

    convenience init?(giltImagesDictionary dictionary: JSONDictionary) {
        var urlString: String? = nil

        for imageSize in NSURL.imageSizes {
            if let imageURLSizeArray = dictionary[imageSize] as? [JSONDictionary],
                imageURLSize = imageURLSizeArray.first,
                imageURLString = imageURLSize["url"] as? String where imageURLString != "" {
                urlString = imageURLString
                break
            }
        }

        guard let urlStr = urlString else { return nil }

        self.init(string:urlStr)
    }
}
