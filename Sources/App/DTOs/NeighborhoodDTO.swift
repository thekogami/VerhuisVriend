import Vapor

struct NeighborhoodDTO: Content {
    let id: UUID?
    let name: String
    let city: String
    let description: String?
    let latitude: Double
    let longitude: Double
    let studentRating: Double?
    let averageRent: Double?
    let universityDistance: Double?
    let transportScore: Int?
    let safetyRating: Double?
    let amenities: [String]?
    let tags: [String]?
    let createdAt: Date?
    let updatedAt: Date?

    // Create DTO from Model
    init(neighborhood: Neighborhood) {
        self.id = neighborhood.id
        self.name = neighborhood.name
        self.city = neighborhood.city
        self.description = neighborhood.description
        self.latitude = neighborhood.latitude
        self.longitude = neighborhood.longitude
        self.studentRating = neighborhood.studentRating
        self.averageRent = neighborhood.averageRent
        self.universityDistance = neighborhood.universityDistance
        self.transportScore = neighborhood.transportScore
        self.safetyRating = neighborhood.safetyRating
        
        // Parse JSON strings to arrays
        if let amenitiesString = neighborhood.amenities,
           let data = amenitiesString.data(using: .utf8),
           let array = try? JSONDecoder().decode([String].self, from: data) {
            self.amenities = array
        } else {
            self.amenities = nil
        }
        
        if let tagsString = neighborhood.tags,
           let data = tagsString.data(using: .utf8),
           let array = try? JSONDecoder().decode([String].self, from: data) {
            self.tags = array
        } else {
            self.tags = nil
        }
        
        self.createdAt = neighborhood.createdAt
        self.updatedAt = neighborhood.updatedAt
    }

    // Create DTO from request data
    init(
        name: String,
        city: String,
        description: String? = nil,
        latitude: Double,
        longitude: Double,
        studentRating: Double? = nil,
        averageRent: Double? = nil,
        universityDistance: Double? = nil,
        transportScore: Int? = nil,
        safetyRating: Double? = nil,
        amenities: [String]? = nil,
        tags: [String]? = nil
    ) {
        self.id = nil
        self.name = name
        self.city = city
        self.description = description
        self.latitude = latitude
        self.longitude = longitude
        self.studentRating = studentRating
        self.averageRent = averageRent
        self.universityDistance = universityDistance
        self.transportScore = transportScore
        self.safetyRating = safetyRating
        self.amenities = amenities
        self.tags = tags
        self.createdAt = nil
        self.updatedAt = nil
    }
    
    // Convert arrays to JSON strings for storage
    func amenitiesString() -> String? {
        guard let amenities = amenities,
              let data = try? JSONEncoder().encode(amenities),
              let string = String(data: data, encoding: .utf8) else {
            return nil
        }
        return string
    }
    
    func tagsString() -> String? {
        guard let tags = tags,
              let data = try? JSONEncoder().encode(tags),
              let string = String(data: data, encoding: .utf8) else {
            return nil
        }
        return string
    }
}
