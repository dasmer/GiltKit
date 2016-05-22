import Foundation

public struct Client {
    private static let apiKey = "7dad1a60116daa2390bbd389a39ab53ec098f804ab245df84fdd162071a82711"
    private static let baseURL = "https://api.gilt.com/v1"

    let session: NSURLSession

    public init() {
        self.session = NSURLSession.sharedSession()
    }

    init(session: NSURLSession) {
        self.session = session
    }


    public func listSalesForStore(store: Store, kind: Sale.Kind, completion: (([Sale]) -> ())) {
        guard let request = buildRequestWithPath("sales/\(store.rawValue)/\(kind.rawValue).json") else { return }

        let task = session.dataTaskWithRequest(request) { data, response, error in
            guard let data = data,
                json = Client.parseData(data) as? JSONDictionary,
                saleJSONs = json["sales"] as? [JSONDictionary] else {
                    completion([])
                    return
            }

            let sales = saleJSONs.flatMap{ Sale(dictionary: $0) }
            completion(sales)
        }
        task.resume()
    }


    // MARK: - Private

    private func buildRequestWithPath(path: String, parameters: JSONDictionary = [:]) -> NSURLRequest? {
        var parameters = parameters
        parameters["apikey"] = Client.apiKey

        let urlString = "\(Client.baseURL)/\(path)?\(stringFromHttpParameters(parameters))"
        print( urlString)
        guard let url = NSURL(string: urlString) else { return nil }
        let request = NSURLRequest(URL: url)

        return request
    }

    private func stringFromHttpParameters(parameters: JSONDictionary) -> String {
        let parameterArray = parameters.map { (key, value) -> String in
            return "\(key)=\(value)"
        }
        return parameterArray.joinWithSeparator("&")
    }


    private static func parseData(data: NSData) -> AnyObject? {
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: [])
            return json
        } catch {
            return nil
        }
    }
}
