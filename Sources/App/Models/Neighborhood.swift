import Vapor
import Fluent

final class Neighborhood: Model, Content, @unchecked Sendable {
    static let schema = "neighborhoods"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String

    @Field(key: "city")
    var city: String

    @Field(key: "description")
    var description: String?

    @Field(key: "latitude")
    var latitude: Double

    @Field(key: "longitude")
    var longitude: Double

    // Rating for students (1-5)
    @Field(key: "student_rating")
    var studentRating: Double?

    // Average rent price per month
    @Field(key: "average_rent")
    var averageRent: Double?

    // Proximity to universities (in km)
    @Field(key: "university_distance")
    var universityDistance: Double?

    // Public transport accessibility (1-5)
    @Field(key: "transport_score")
    var transportScore: Int?

    // Safety rating (1-5)
    @Field(key: "safety_rating")
    var safetyRating: Double?

    // Amenities: supermarkets, restaurants, etc (JSON array as string)
    @Field(key: "amenities")
    var amenities: String?

    // Tags: student-friendly, family-friendly, quiet, vibrant, etc
    @Field(key: "tags")
    var tags: String?

    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?

    init() { }

    init(
        id: UUID? = nil,
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
        amenities: String? = nil,
        tags: String? = nil
    ) {
        self.id = id
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
    }
}
