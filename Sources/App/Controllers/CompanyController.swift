import Vapor
import Fluent

struct CompanyController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let companies = routes.grouped("companies")
        companies.get(use: index)
        companies.post(use: create)
        companies.group(":companyID") { company in
            company.get(use: show)
            company.put(use: update)
            company.delete(use: delete)
        }
        
        // Special endpoints
        companies.get("top-rated", use: topRated)
        companies.get("by-area", ":area", use: byServiceArea)
    }

    func index(req: Request) async throws -> [CompanyDTO] {
        let companies = try await Company.query(on: req.db).all()
        return companies.map { CompanyDTO(company: $0) }
    }

    func create(req: Request) async throws -> CompanyDTO {
        let companyDTO = try req.content.decode(CompanyDTO.self)
        
        let newCompany = Company(
            name: companyDTO.name,
            email: companyDTO.email,
            phone: companyDTO.phone,
            address: companyDTO.address,
            serviceArea: companyDTO.serviceArea,
            servicesOffered: companyDTO.servicesOffered,
            languagesSpoken: companyDTO.languagesSpoken,
            rating: companyDTO.rating
        )

        try await newCompany.save(on: req.db)
        return CompanyDTO(company: newCompany)
    }

    func show(req: Request) async throws -> CompanyDTO {
        guard let company = try await Company.find(
            req.parameters.get("companyID"),
            on: req.db
        ) else {
            throw Abort(.notFound)
        }
        return CompanyDTO(company: company)
    }

    func update(req: Request) async throws -> CompanyDTO {
        guard let company = try await Company.find(
            req.parameters.get("companyID"),
            on: req.db
        ) else {
            throw Abort(.notFound)
        }
        
        let updatedCompanyDTO = try req.content.decode(CompanyDTO.self)
        
        company.name = updatedCompanyDTO.name
        company.email = updatedCompanyDTO.email
        company.phone = updatedCompanyDTO.phone
        company.address = updatedCompanyDTO.address
        company.serviceArea = updatedCompanyDTO.serviceArea
        company.servicesOffered = updatedCompanyDTO.servicesOffered
        company.languagesSpoken = updatedCompanyDTO.languagesSpoken
        company.rating = updatedCompanyDTO.rating
        
        try await company.save(on: req.db)
        return CompanyDTO(company: company)
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let company = try await Company.find(
            req.parameters.get("companyID"),
            on: req.db
        ) else {
            throw Abort(.notFound)
        }
        
        try await company.delete(on: req.db)
        return .noContent
    }

    func topRated(req: Request) async throws -> [CompanyDTO] {
        let limit = req.query[Int.self, at: "limit"] ?? 10
        
        let companies = try await Company.query(on: req.db)
            .sort(\.$rating, .descending)
            .limit(limit)
            .all()
        
        return companies.map { CompanyDTO(company: $0) }
    }

    func byServiceArea(req: Request) async throws -> [CompanyDTO] {
        guard let area = req.parameters.get("area") else {
            throw Abort(.badRequest)
        }
        
        let companies = try await Company.query(on: req.db)
            .filter(\.$serviceArea == area)
            .all()
        
        return companies.map { CompanyDTO(company: $0) }
    }
}
