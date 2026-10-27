# VerhuisVriend

**Moving made simple.**

VerhuisVriend transforms the complex process of relocating in the Netherlands into an effortless experience. For students and new residents, we provide everything needed to plan, organize, and execute a stress-free move.

## ✨ Features

- 🗺️ **Interactive Neighborhood Maps** - Discover the best student-friendly neighborhoods with ratings, prices, and amenities
- 📋 **Smart Task Management** - Organize your move with prioritized tasks and automated reminders
- 🏢 **Trusted Moving Companies** - Connect with rated and reviewed moving services
- 🌍 **Multilingual Support** - Available in multiple languages to break barriers
- 📍 **Location-Based Search** - Find neighborhoods near universities and public transport
- 💰 **Budget Planning** - Filter neighborhoods by rent prices within your budget

## 🗺️ Map Integration

VerhuisVriend integrates with free Dutch mapping services to provide:

### Recommended Free Services:

- **OpenStreetMap** - Free, open-source mapping data for the Netherlands
- **Kadaster BAG API** - Official Dutch building and address data (free tier available)
- **PDOK (Publieke Dienstverlening Op de Kaart)** - Free Dutch government geodata services
- **CBS Open Data** - Statistics Netherlands for neighborhood demographics

### Neighborhood Features:

- Student ratings (1-5 stars)
- Average monthly rent prices
- Distance to universities
- Public transport accessibility scores
- Safety ratings
- Nearby amenities (supermarkets, restaurants, cafes)
- Tags (student-friendly, quiet, vibrant, etc.)

## 🚀 API Endpoints

### Neighborhoods

```
GET    /neighborhoods              # List all neighborhoods
GET    /neighborhoods/top-rated    # Get top-rated neighborhoods
GET    /neighborhoods/by-city/:city # Filter by city
GET    /neighborhoods/nearby       # Find nearby (lat, lon, radius)
GET    /neighborhoods/affordable   # Filter by max rent
POST   /neighborhoods              # Create neighborhood
GET    /neighborhoods/:id          # Get specific neighborhood
PUT    /neighborhoods/:id          # Update neighborhood
DELETE /neighborhoods/:id          # Delete neighborhood
```

### Companies

```
GET    /companies                  # List all companies
GET    /companies/top-rated        # Get top-rated companies
GET    /companies/by-area/:area    # Filter by service area
POST   /companies                  # Create company
GET    /companies/:id              # Get specific company
PUT    /companies/:id              # Update company
DELETE /companies/:id              # Delete company
```

### Users

```
GET    /users                      # List all users
POST   /users                      # Create user
GET    /users/:id                  # Get specific user
PUT    /users/:id                  # Update user
DELETE /users/:id                  # Delete user
```

### Moves

```
GET    /moves                      # List all moves
POST   /moves                      # Create move
GET    /moves/:id                  # Get specific move
PUT    /moves/:id                  # Update move
DELETE /moves/:id                  # Delete move
```

### Tasks

```
GET    /tasks                      # List all tasks
POST   /tasks                      # Create task
GET    /tasks/:id                  # Get specific task
PUT    /tasks/:id                  # Update task
DELETE /tasks/:id                  # Delete task
```

## 🛠️ Technology Stack

- **Backend**: Vapor 4 (Swift)
- **Database**: PostgreSQL with Fluent ORM
- **Architecture**: RESTful API
- **Concurrency**: Swift Async/Await
- **Containerization**: Docker & Docker Compose

## 📦 Installation

### Prerequisites

- Swift 6.0+
- PostgreSQL 14+
- Docker (optional)

### Setup

1. Clone the repository:

```bash
git clone https://github.com/thekogami/VerhuisVriend.git
cd VerhuisVriend
```

2. Configure database (edit `.env` or environment variables):

```bash
DATABASE_HOST=127.0.0.1
DATABASE_PORT=5432
DATABASE_USERNAME=your_username
DATABASE_PASSWORD=your_password
DATABASE_NAME=verhuisvriend_db
```

3. Run migrations:

```bash
swift run App migrate
```

4. Start the server:

```bash
swift run App serve
```

Or use Docker:

```bash
docker-compose up
```

## 🗺️ Integrating Maps in Frontend

### Example: Using OpenStreetMap with Leaflet.js

```javascript
// Initialize map
const map = L.map('map').setView([52.3676, 4.9041], 11) // Amsterdam

// Add OpenStreetMap tiles
L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
  attribution: '© OpenStreetMap contributors'
}).addTo(map)

// Fetch neighborhoods from API
fetch('http://localhost:8080/neighborhoods/top-rated')
  .then(response => response.json())
  .then(neighborhoods => {
    neighborhoods.forEach(hood => {
      // Add marker for each neighborhood
      L.marker([hood.latitude, hood.longitude])
        .bindPopup(
          `
                    <b>${hood.name}</b><br>
                    Rating: ${hood.studentRating} ⭐<br>
                    Avg Rent: €${hood.averageRent}/month<br>
                    ${hood.description}
                `
        )
        .addTo(map)
    })
  })
```

### Example Neighborhood Data Seed

Use Dutch cities and popular student areas:

```json
{
  "name": "De Pijp",
  "city": "Amsterdam",
  "latitude": 52.3547,
  "longitude": 4.8918,
  "studentRating": 4.5,
  "averageRent": 750,
  "universityDistance": 3.2,
  "transportScore": 5,
  "safetyRating": 4.3,
  "amenities": ["Albert Heijn", "Restaurants", "Cafes", "Parks"],
  "tags": ["student-friendly", "vibrant", "multicultural"]
}
```

## 🎯 Roadmap

- [ ] User authentication & authorization
- [ ] Real-time notifications
- [ ] Integration with PDOK and Kadaster APIs
- [ ] Mobile app (iOS & Android)
- [ ] In-app chat with moving companies
- [ ] Document upload and storage
- [ ] Moving cost calculator
- [ ] Community reviews and tips

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License.

## 👥 Contact

- **Developer**: Kogami
- **GitHub**: [@thekogami](https://github.com/thekogami)

---

_Simple. Smart. Stress-free._
