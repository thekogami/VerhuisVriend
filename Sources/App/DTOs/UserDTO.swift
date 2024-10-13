//
//  UserDTO.swift
//  VerhuisVriend
//
//  Created by Felipe Mourão on 12/10/24.
//

import Vapor

struct UserDTO: Content {
    let id: UUID?
    let name: String
    let email: String
    
    // Inicializador para criar um UserDTO a partir de um User
    init(user: User) {
        self.id = user.id
        self.name = user.name
        self.email = user.email
    }
    
    // Inicializador para criar um UserDTO a partir de dados recebidos
    init(name: String, email: String) {
        self.id = nil
        self.name = name
        self.email = email
    }
}
