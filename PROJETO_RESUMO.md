# VerhuisVriend - Resumo do Projeto

## 📱 O Que É?

**VerhuisVriend** = "Amigo da Mudança" em holandês

Uma plataforma inteligente que simplifica o processo de mudança na Holanda para estudantes e novos residentes.

---

## ✨ Funcionalidades Principais

### 1. 🗺️ Mapa Interativo de Bairros

- Descubra os melhores bairros para estudantes
- Visualize preços de aluguel, avaliações e comodidades
- Filtros por: cidade, orçamento, distância de universidades
- Busca por proximidade usando coordenadas GPS

### 2. 📋 Gerenciamento de Tarefas

- Lista de tarefas com prioridades
- Datas de vencimento
- Status de conclusão
- Lembretes automáticos

### 3. 🏢 Empresas de Mudança Confiáveis

- Catálogo de empresas verificadas
- Avaliações de usuários
- Filtros por área de serviço e idiomas falados
- Informações de contato direto

### 4. 📍 Planejamento de Mudança

- Organize sua mudança completa
- Acompanhamento de status
- Histórico de mudanças

---

## 🛠️ Tecnologias

- **Backend**: Swift + Vapor 4
- **Database**: PostgreSQL
- **API**: RESTful com async/await
- **Container**: Docker

---

## 🗺️ Integrações de Mapa Gratuitas

### Serviços Holandeses Oficiais:

1. **PDOK** (Publieke Dienstverlening Op de Kaart)

   - Dados geográficos do governo holandês
   - Tiles de mapas gratuitos
   - https://www.pdok.nl/

2. **Kadaster BAG API**

   - Dados oficiais de endereços e edifícios
   - API gratuita (tier básico)
   - https://www.kadaster.nl/

3. **CBS Open Data**

   - Estatísticas da Holanda
   - Demografia de bairros
   - https://www.cbs.nl/

4. **OpenStreetMap**
   - Mapas colaborativos
   - Totalmente gratuito
   - https://www.openstreetmap.org/

---

## 📊 Estrutura de Dados

### Neighborhoods (Bairros)

```swift
- id: UUID
- name: String (ex: "De Pijp")
- city: String (ex: "Amsterdam")
- latitude, longitude: Double
- studentRating: Double (1-5)
- averageRent: Double (€/mês)
- universityDistance: Double (km)
- transportScore: Int (1-5)
- safetyRating: Double (1-5)
- amenities: [String] (JSON)
- tags: [String] (JSON)
```

### Companies (Empresas)

```swift
- id: UUID
- name: String
- email, phone, address: String?
- serviceArea: String?
- servicesOffered: String?
- languagesSpoken: String?
- rating: Double?
```

### Moves (Mudanças)

```swift
- id: UUID
- moveDate: Date
- fromLocation, toLocation: String
- user: User (relacionamento)
- status: String (pending/in-progress/completed)
```

### Tasks (Tarefas)

```swift
- id: UUID
- title, description: String
- isCompleted: Bool
- dueDate: Date?
- priority: String (low/medium/high)
- user: User (relacionamento)
```

---

## 🚀 Como Usar

### 1. Iniciar o Servidor

```bash
# Com Swift
swift run App serve

# Com Docker
docker-compose up
```

### 2. Popular Bairros

```bash
./seed_neighborhoods.sh
```

### 3. Testar API

```bash
# Listar todos os bairros
curl http://localhost:8080/neighborhoods

# Top bairros para estudantes
curl http://localhost:8080/neighborhoods/top-rated

# Bairros acessíveis (máx €700/mês)
curl http://localhost:8080/neighborhoods/affordable?maxRent=700

# Bairros em Amsterdam
curl http://localhost:8080/neighborhoods/by-city/Amsterdam

# Bairros próximos (5km de Amsterdam centro)
curl http://localhost:8080/neighborhoods/nearby?lat=52.3676&lon=4.9041&radius=5
```

---

## 🎯 Endpoints da API

### Neighborhoods

- `GET /neighborhoods` - Listar todos
- `GET /neighborhoods/top-rated` - Top avaliados
- `GET /neighborhoods/by-city/:city` - Por cidade
- `GET /neighborhoods/nearby?lat=&lon=&radius=` - Proximidade
- `GET /neighborhoods/affordable?maxRent=` - Por orçamento
- `POST /neighborhoods` - Criar
- `PUT /neighborhoods/:id` - Atualizar
- `DELETE /neighborhoods/:id` - Deletar

### Companies

- `GET /companies` - Listar todas
- `GET /companies/top-rated` - Top avaliadas
- `GET /companies/by-area/:area` - Por área
- `POST /companies` - Criar
- `PUT /companies/:id` - Atualizar
- `DELETE /companies/:id` - Deletar

### Users, Moves, Tasks

- CRUD completo disponível

---

## 📈 Roadmap

- [ ] Autenticação de usuários (JWT)
- [ ] Upload de documentos
- [ ] Notificações em tempo real
- [ ] App móvel (iOS/Android)
- [ ] Chat com empresas
- [ ] Calculadora de custos de mudança
- [ ] Reviews da comunidade
- [ ] Sistema de favoritos

---

## 🌟 Diferenciais

✅ **Focado no mercado holandês** - Dados e recursos específicos da Holanda
✅ **Para estudantes** - Filtros e informações pensadas para estudantes
✅ **Gratuito** - Usa apenas APIs e serviços gratuitos
✅ **Open Source** - Código aberto para a comunidade
✅ **Moderno** - Swift async/await, arquitetura limpa
✅ **Completo** - Do planejamento à execução da mudança

---

## 🎨 Design Philosophy (estilo Apple)

**Simples. Inteligente. Sem Estresse.**

- Interface minimalista
- Foco na experiência do usuário
- Dados confiáveis e verificados
- Processo guiado passo a passo
- Suporte multilíngue

---

## 📝 Melhorias Implementadas

### Correções de Código

✅ Adicionado `@unchecked Sendable` a todos os Models
✅ Migrado de `EventLoopFuture` para `async/await`
✅ Atualizadas todas as Migrations para `AsyncMigration`
✅ Adicionados campos `createdAt` e `updatedAt`
✅ Corrigidos nomes de campos no banco de dados
✅ Adicionados novos campos úteis (rating, status, priority, etc.)

### Novas Features

✅ **Modelo Neighborhood completo** com geolocalização
✅ **Endpoints especializados** para busca de bairros
✅ **Cálculo de distância** usando fórmula Haversine
✅ **Sistema de avaliações** para empresas e bairros
✅ **Filtros avançados** por preço, localização, ratings
✅ **Script de seeding** com dados reais de cidades holandesas
✅ **Documentação completa** em README e NEIGHBORHOODS_GUIDE

---

## 🎓 Principais Cidades Universitárias Suportadas

1. **Amsterdam** - UvA, VU Amsterdam
2. **Utrecht** - Utrecht University
3. **Rotterdam** - Erasmus University
4. **Groningen** - University of Groningen
5. **Leiden** - Leiden University
6. **Delft** - TU Delft
7. **Eindhoven** - TU Eindhoven
8. **Maastricht** - Maastricht University
9. **Tilburg** - Tilburg University
10. **Nijmegen** - Radboud University

---

Desenvolvido com ❤️ para facilitar a vida de estudantes na Holanda
