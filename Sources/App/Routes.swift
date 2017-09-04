import Vapor

extension Droplet {
    func setupRoutes() throws {
        get("hello") { req in
            var json = JSON()
            try json.set("hello", "world")
            return json
        }

        get("hi") { req in
            return "Hello, world!\n"
        }

        // response to requests to /info domain
        // with a description of the request
        get("info") { req in
            return req.description
        }

        get("description") { req in
            return req.description
        }
        
        get("name", ":x") { req in
            if let name = req.parameters["x"]?.string {
                return "Hello \(name)\n"
            }
            return "Error retrieving parameters"
        }
        
        get("greet") { req in
            if let value = req.data["name"]?.string {
                return "Hello \(value)\n"
            }
            return "Error retrieving parameters"
        }
        
        try resource("posts", PostController.self)
    }
}
