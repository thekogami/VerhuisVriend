import Vapor

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
    }

    func index(req: Request) throws -> EventLoopFuture<[CompanyDTO]> {
        return Company.query(on: req.db).all().map { companies in
            companies.map { CompanyDTO(company: $0) }
        }
    }

    func create(req: Request) throws -> EventLoopFuture<CompanyDTO> {
        let companyDTO = try req.content.decode(CompanyDTO.self)
        
        let newCompany = Company(name: companyDTO.name, email: companyDTO.email, phone: companyDTO.phone, address: companyDTO.address, serviceArea: companyDTO.serviceArea, servicesOffered: companyDTO.servicesOffered, languagesSpoken: companyDTO.languagesSpoken)

        return newCompany.save(on: req.db).map {
            CompanyDTO(company: newCompany)
        }
    }

    func show(req: Request) throws -> EventLoopFuture<CompanyDTO> {
        return Company.find(req.parameters.get("companyID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .map { CompanyDTO(company: $0) }
    }

    func update(req: Request) throws -> EventLoopFuture<CompanyDTO> {
        let updatedCompanyDTO = try req.content.decode(CompanyDTO.self)
        
        return Company.find(req.parameters.get("companyID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { company in
                company.name = updatedCompanyDTO.name
                company.email = updatedCompanyDTO.email
                company.phone = updatedCompanyDTO.phone
                company.address = updatedCompanyDTO.address
                company.serviceArea = updatedCompanyDTO.serviceArea
                company.servicesOffered = updatedCompanyDTO.servicesOffered
                company.languagesSpoken = updatedCompanyDTO.languagesSpoken
                
                return company.save(on: req.db).map {
                    CompanyDTO(company: company)
                }
            }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Company.find(req.parameters.get("companyID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { company in
                company.delete(on: req.db).transform(to: .noContent)
            }
    }
}
