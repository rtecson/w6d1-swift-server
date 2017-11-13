import Vapor

extension Droplet {
    func setupRoutes() throws {
        get("plaintext") { req in
            return "Hello, world!\n"
        }

        // Respond to curl localhost:8080/hi
        // with "Hello, world!\n"
        get("hello") { req in
            var json = JSON()
            try json.set("hello", "world")
            return json
        }

        // Respond to curl localhost:8080/hi
        // with "Hello, world!\n"
        get("hi") { req in
            return "Hello, world!\n"
        }

        // Respond to curl localhost:8080/description
        // With a description of the URL request
        get("description") { req in
            return req.description
        }

        // Respond to curl localhost:8080/name/Bob
        get("name", ":x") { req in
            guard let name = req.parameters["x"]?.string let {
                return "Error retrieving parameters\n"
            }
            return "Hello \(name)\n"
        }

        // Respond to curl localhost:8080/greet?name=Roland
        get("greet") { req in
            guard let value = req.data["name"]?.string else {
                return "Error retrieving parameters\n"
            }
            return "Hello \(value)\n"
        }
        
        try resource("posts", PostController.self)
    }
}
