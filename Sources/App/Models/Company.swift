//
//  Company.swift
//  VerhuisVriend
//
//  Created by Felipe Mourão on 12/10/24.
//

import Vapor
import Fluent

final class Company: Model, Content {
    static let schema = "companies"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String

    @Field(key: "email")
    var email: String?

    @Field(key: "phone")
    var phone: String?

    @Field(key: "address")
    var address: String?

    init() { }

    init(id: UUID? = nil, name: String, email: String? = nil, phone: String? = nil, address: String? = nil) {
        self.id = id
        self.name = name
        self.email = email
        self.phone = phone
        self.address = address
    }
}
