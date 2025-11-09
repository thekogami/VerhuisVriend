import Vapor

struct CompanyDTO: Content {
    let id: UUID?
    let name: String
    let email: String?
    let phone: String?
    let address: String?
    let serviceArea: String?
    let servicesOffered: String?
    let languagesSpoken: String?
    let rating: Double?
    let createdAt: Date?
    let updatedAt: Date?

    // Inicializador para criar um CompanyDTO a partir de uma Company
    init(company: Company) {
        self.id = company.id
        self.name = company.name
        self.email = company.email
        self.phone = company.phone
        self.address = company.address
        self.serviceArea = company.serviceArea
        self.servicesOffered = company.servicesOffered
        self.languagesSpoken = company.languagesSpoken
        self.rating = company.rating
        self.createdAt = company.createdAt
        self.updatedAt = company.updatedAt
    }

    // Inicializador para criar um CompanyDTO a partir de dados recebidos
    init(name: String, email: String? = nil, phone: String? = nil, address: String? = nil, serviceArea: String? = nil, servicesOffered: String? = nil, languagesSpoken: String? = nil, rating: Double? = nil) {
        self.id = nil
        self.name = name
        self.email = email
        self.phone = phone
        self.address = address
        self.serviceArea = serviceArea
        self.servicesOffered = servicesOffered
        self.languagesSpoken = languagesSpoken
        self.rating = rating
        self.createdAt = nil
        self.updatedAt = nil
    }
}
