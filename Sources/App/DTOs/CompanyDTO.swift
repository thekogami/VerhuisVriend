//
//  CompanyDTO.swift
//  VerhuisVriend
//
//  Created by Felipe on 12/10/24.
//

import Vapor

struct CompanyDTO: Content {
    let id: UUID?
    let name: String
    let email: String?
    let phone: String?
    let address: String?

    // Inicializador para criar um CompanyDTO a partir de uma Company
    init(company: Company) {
        self.id = company.id
        self.name = company.name
        self.email = company.email
        self.phone = company.phone
        self.address = nil
    }

    // Inicializador para criar um CompanyDTO a partir de dados recebidos
    init(name: String, email: String? = nil, phone: String? = nil) {
        self.id = nil
        self.name = name
        self.email = email
        self.phone = phone
        self.address = nil
    }
}
