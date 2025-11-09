import Vapor
import Fluent

struct NeighborhoodController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let neighborhoods = routes.grouped("neighborhoods")
        
        // CRUD endpoints
        neighborhoods.get(use: index)
        neighborhoods.post(use: create)
        neighborhoods.group(":neighborhoodID") { neighborhood in
            neighborhood.get(use: show)
            neighborhood.put(use: update)
            neighborhood.delete(use: delete)
        }
        
        // Special endpoints for students
        neighborhoods.get("top-rated", use: topRated)
        neighborhoods.get("by-city", ":city", use: byCity)
        neighborhoods.get("nearby", use: nearby)
        neighborhoods.get("affordable", use: affordable)
    }

    // Get all neighborhoods
    func index(req: Request) async throws -> [NeighborhoodDTO] {
        let neighborhoods = try await Neighborhood.query(on: req.db).all()
        return neighborhoods.map { NeighborhoodDTO(neighborhood: $0) }
    }

    // Create new neighborhood
    func create(req: Request) async throws -> NeighborhoodDTO {
        let dto = try req.content.decode(NeighborhoodDTO.self)
        
        let neighborhood = Neighborhood(
            name: dto.name,
            city: dto.city,
            description: dto.description,
            latitude: dto.latitude,
            longitude: dto.longitude,
            studentRating: dto.studentRating,
            averageRent: dto.averageRent,
            universityDistance: dto.universityDistance,
            transportScore: dto.transportScore,
            safetyRating: dto.safetyRating,
            amenities: dto.amenitiesString(),
            tags: dto.tagsString()
        )

        try await neighborhood.save(on: req.db)
        return NeighborhoodDTO(neighborhood: neighborhood)
    }

    // Get specific neighborhood
    func show(req: Request) async throws -> NeighborhoodDTO {
        guard let neighborhood = try await Neighborhood.find(
            req.parameters.get("neighborhoodID"),
            on: req.db
        ) else {
            throw Abort(.notFound)
        }
        return NeighborhoodDTO(neighborhood: neighborhood)
    }

    // Update neighborhood
    func update(req: Request) async throws -> NeighborhoodDTO {
        guard let neighborhood = try await Neighborhood.find(
            req.parameters.get("neighborhoodID"),
            on: req.db
        ) else {
            throw Abort(.notFound)
        }
        
        let dto = try req.content.decode(NeighborhoodDTO.self)
        
        neighborhood.name = dto.name
        neighborhood.city = dto.city
        neighborhood.description = dto.description
        neighborhood.latitude = dto.latitude
        neighborhood.longitude = dto.longitude
        neighborhood.studentRating = dto.studentRating
        neighborhood.averageRent = dto.averageRent
        neighborhood.universityDistance = dto.universityDistance
        neighborhood.transportScore = dto.transportScore
        neighborhood.safetyRating = dto.safetyRating
        neighborhood.amenities = dto.amenitiesString()
        neighborhood.tags = dto.tagsString()
        
        try await neighborhood.save(on: req.db)
        return NeighborhoodDTO(neighborhood: neighborhood)
    }

    // Delete neighborhood
    func delete(req: Request) async throws -> HTTPStatus {
        guard let neighborhood = try await Neighborhood.find(
            req.parameters.get("neighborhoodID"),
            on: req.db
        ) else {
            throw Abort(.notFound)
        }
        
        try await neighborhood.delete(on: req.db)
        return .noContent
    }

    // Get top-rated neighborhoods for students
    func topRated(req: Request) async throws -> [NeighborhoodDTO] {
        let limit = req.query[Int.self, at: "limit"] ?? 10
        
        let neighborhoods = try await Neighborhood.query(on: req.db)
            .sort(\.$studentRating, .descending)
            .limit(limit)
            .all()
        
        return neighborhoods.map { NeighborhoodDTO(neighborhood: $0) }
    }

    // Get neighborhoods by city
    func byCity(req: Request) async throws -> [NeighborhoodDTO] {
        guard let city = req.parameters.get("city") else {
            throw Abort(.badRequest)
        }
        
        let neighborhoods = try await Neighborhood.query(on: req.db)
            .filter(\.$city == city)
            .all()
        
        return neighborhoods.map { NeighborhoodDTO(neighborhood: $0) }
    }

    // Get neighborhoods near coordinates
    func nearby(req: Request) async throws -> [NeighborhoodDTO] {
        guard let lat = req.query[Double.self, at: "lat"],
              let lon = req.query[Double.self, at: "lon"] else {
            throw Abort(.badRequest, reason: "Missing lat or lon query parameters")
        }
        
        let radius = req.query[Double.self, at: "radius"] ?? 5.0 // default 5km
        
        // Get all neighborhoods and filter by distance
        let allNeighborhoods = try await Neighborhood.query(on: req.db).all()
        
        let nearbyNeighborhoods = allNeighborhoods.filter { neighborhood in
            let distance = calculateDistance(
                lat1: lat, lon1: lon,
                lat2: neighborhood.latitude, lon2: neighborhood.longitude
            )
            return distance <= radius
        }
        
        return nearbyNeighborhoods.map { NeighborhoodDTO(neighborhood: $0) }
    }

    // Get affordable neighborhoods for students
    func affordable(req: Request) async throws -> [NeighborhoodDTO] {
        let maxRent = req.query[Double.self, at: "maxRent"] ?? 800.0
        
        let neighborhoods = try await Neighborhood.query(on: req.db)
            .filter(\.$averageRent <= maxRent)
            .sort(\.$averageRent, .ascending)
            .all()
        
        return neighborhoods.map { NeighborhoodDTO(neighborhood: $0) }
    }

    // Helper function to calculate distance between two coordinates (Haversine formula)
    private func calculateDistance(lat1: Double, lon1: Double, lat2: Double, lon2: Double) -> Double {
        let earthRadius = 6371.0 // km
        
        let dLat = (lat2 - lat1) * .pi / 180.0
        let dLon = (lon2 - lon1) * .pi / 180.0
        
        let a = sin(dLat / 2) * sin(dLat / 2) +
                cos(lat1 * .pi / 180.0) * cos(lat2 * .pi / 180.0) *
                sin(dLon / 2) * sin(dLon / 2)
        
        let c = 2 * atan2(sqrt(a), sqrt(1 - a))
        
        return earthRadius * c
    }
}
