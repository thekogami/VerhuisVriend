//
//  CompanyController.swift
//  VerhuisVriend
//
//  Created by Felipe Mourão on 12/10/24.
//

import Vapor

struct CompanyController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let companies = routes.grouped("companies")
        companies.get(use: index)
        companies.post(use: create)
    }

    func index(req: Request) throws -> EventLoopFuture<[CompanyDTO]> {
        return Company.query(on: req.db).all().map { companies in
            companies.map { CompanyDTO(company: $0) }
        }
    }

    func create(req: Request) throws -> EventLoopFuture<CompanyDTO> {
        let companyDTO = try req.content.decode(CompanyDTO.self)
        
        let newCompany = Company(name: companyDTO.name, email: companyDTO.email, phone: companyDTO.phone, address: companyDTO.address)

        return newCompany.save(on: req.db).map {
            CompanyDTO(company: newCompany)
        }
    }
}
