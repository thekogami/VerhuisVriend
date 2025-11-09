# VerhuisVriend - Neighborhood Seed Data

# Popular Student Cities and Neighborhoods in the Netherlands

## Amsterdam

### De Pijp

- **Coordinates**: 52.3547, 4.8918
- **Student Rating**: 4.5/5
- **Average Rent**: €750/month
- **University Distance**: 3.2 km (UvA, VU)
- **Transport Score**: 5/5
- **Safety**: 4.3/5
- **Amenities**: Albert Heijn, Markets, Restaurants, Cafes, Parks
- **Tags**: student-friendly, vibrant, multicultural, trendy

### Oud-West

- **Coordinates**: 52.3676, 4.8732
- **Student Rating**: 4.4/5
- **Average Rent**: 780/month
- **University Distance**: 2.5 km
- **Transport Score**: 5/5
- **Safety**: 4.2/5
- **Tags**: student-friendly, lively, affordable-ish

### Amsterdam Noord

- **Coordinates**: 52.3936, 4.9091
- **Student Rating**: 4.1/5
- **Average Rent**: 650/month
- **University Distance**: 4.5 km
- **Transport Score**: 4/5
- **Safety**: 4.5/5
- **Tags**: student-friendly, affordable, upcoming, creative

## Utrecht

### Utrecht Centrum

- **Coordinates**: 52.0907, 5.1214
- **Student Rating**: 4.6/5
- **Average Rent**: 700/month
- **University Distance**: 1.5 km (UU)
- **Transport Score**: 5/5
- **Safety**: 4.6/5
- **Tags**: student-friendly, vibrant, historic, bike-friendly

### Utrecht Science Park (De Uithof)

- **Coordinates**: 52.0858, 5.1720
- **Student Rating**: 4.2/5
- **Average Rent**: 550/month
- **University Distance**: 0.5 km
- **Transport Score**: 4/5
- **Safety**: 4.7/5
- **Tags**: student-friendly, quiet, campus-life, affordable

## Rotterdam

### Kralingen

- **Coordinates**: 51.9283, 4.5308
- **Student Rating**: 4.3/5
- **Average Rent**: 650/month
- **University Distance**: 2.0 km (EUR)
- **Transport Score**: 5/5
- **Safety**: 4.4/5
- **Tags**: student-friendly, green, safe, family-friendly

### Rotterdam Centrum

- **Coordinates**: 51.9225, 4.4792
- **Student Rating**: 4.4/5
- **Average Rent**: 700/month
- **University Distance**: 3.5 km
- **Transport Score**: 5/5
- **Safety**: 4.0/5
- **Tags**: student-friendly, vibrant, modern, nightlife

## Groningen

### Groningen Centrum

- **Coordinates**: 53.2194, 6.5665
- **Student Rating**: 4.7/5
- **Average Rent**: 550/month
- **University Distance**: 1.0 km (RUG)
- **Transport Score**: 5/5
- **Safety**: 4.8/5
- **Tags**: student-friendly, bike-friendly, affordable, vibrant, young

### Paddepoel

- **Coordinates**: 53.2367, 6.5472
- **Student Rating**: 4.0/5
- **Average Rent**: 500/month
- **University Distance**: 3.5 km
- **Transport Score**: 4/5
- **Safety**: 4.3/5
- **Tags**: student-friendly, quiet, affordable, suburban

## Leiden

### Leiden Centrum

- **Coordinates**: 52.1601, 4.4970
- **Student Rating**: 4.5/5
- **Average Rent**: 680/month
- **University Distance**: 1.2 km (Leiden University)
- **Transport Score**: 5/5
- **Safety**: 4.7/5
- **Tags**: student-friendly, historic, cozy, canal-life

## Delft

### Delft Centrum

- **Coordinates**: 52.0116, 4.3571
- **Student Rating**: 4.4/5
- **Average Rent**: 620/month
- **University Distance**: 1.5 km (TU Delft)
- **Transport Score**: 5/5
- **Safety**: 4.6/5
- **Tags**: student-friendly, tech-hub, historic, bike-friendly

## Eindhoven

### Eindhoven Centrum

- **Coordinates**: 51.4416, 5.4697
- **Student Rating**: 4.3/5
- **Average Rent**: 600/month
- **University Distance**: 2.0 km (TU/e)
- **Transport Score**: 5/5
- **Safety**: 4.3/5
- **Tags**: student-friendly, tech-city, modern, design

## Maastricht

### Maastricht Centrum

- **Coordinates**: 50.8514, 5.6910
- **Student Rating**: 4.5/5
- **Average Rent**: 650/month
- **University Distance**: 1.8 km (Maastricht University)
- **Transport Score**: 4/5
- **Safety**: 4.5/5
- **Tags**: student-friendly, international, historic, border-city

## Tilburg

### Tilburg Centrum

- **Coordinates**: 51.5555, 5.0913
- **Student Rating**: 4.1/5
- **Average Rent**: 550/month
- **University Distance**: 2.0 km (Tilburg University)
- **Transport Score**: 4/5
- **Safety**: 4.2/5
- **Tags**: student-friendly, affordable, relaxed, growing

## Nijmegen

### Nijmegen Centrum

- **Coordinates**: 51.8126, 5.8372
- **Student Rating**: 4.4/5
- **Average Rent**: 580/month
- **University Distance**: 1.5 km (Radboud)
- **Transport Score**: 4/5
- **Safety**: 4.5/5
- **Tags**: student-friendly, historic, oldest-city, vibrant

---

## API Seeding Example

Use this curl command to seed neighborhoods:

```bash
curl -X POST http://localhost:8080/neighborhoods \
  -H "Content-Type: application/json" \
  -d '{
    "name": "De Pijp",
    "city": "Amsterdam",
    "description": "Vibrant multicultural neighborhood with great food scene",
    "latitude": 52.3547,
    "longitude": 4.8918,
    "studentRating": 4.5,
    "averageRent": 750,
    "universityDistance": 3.2,
    "transportScore": 5,
    "safetyRating": 4.3,
    "amenities": ["Albert Heijn", "Markets", "Restaurants", "Cafes", "Parks"],
    "tags": ["student-friendly", "vibrant", "multicultural", "trendy"]
  }'
```

## Free Dutch Mapping Resources

### 1. **PDOK (Publieke Dienstverlening Op de Kaart)**

- URL: https://www.pdok.nl/
- Free tile services and WMS layers
- Official Dutch government geodata

### 2. **Kadaster BAG API**

- URL: https://www.kadaster.nl/zakelijk/producten/adressen-en-gebouwen/bag-api
- Building and address data
- Free tier available

### 3. **OpenStreetMap Netherlands**

- URL: https://www.openstreetmap.org/
- Community-driven maps
- Completely free

### 4. **CBS Open Data**

- URL: https://www.cbs.nl/nl-nl/onze-diensten/open-data
- Statistics Netherlands
- Neighborhood demographics and statistics
- Free access

### 5. **NS API (Dutch Railways)**

- URL: https://www.ns.nl/reisinformatie/ns-api
- Train station locations and schedules
- Useful for transport scores
