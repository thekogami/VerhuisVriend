#!/bin/bash

# VerhuisVriend - Seed Script for Neighborhoods
# This script seeds the database with popular student neighborhoods in the Netherlands

BASE_URL="http://localhost:8080"

echo "🌱 Starting VerhuisVriend neighborhood seeding..."
echo ""

# Amsterdam - De Pijp
echo "📍 Adding Amsterdam - De Pijp..."
curl -X POST "$BASE_URL/neighborhoods" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "De Pijp",
    "city": "Amsterdam",
    "description": "Vibrant multicultural neighborhood with great food scene and markets",
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
echo -e "\n"

# Amsterdam - Oud-West
echo "📍 Adding Amsterdam - Oud-West..."
curl -X POST "$BASE_URL/neighborhoods" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Oud-West",
    "city": "Amsterdam",
    "description": "Lively neighborhood with excellent accessibility and student atmosphere",
    "latitude": 52.3676,
    "longitude": 4.8732,
    "studentRating": 4.4,
    "averageRent": 780,
    "universityDistance": 2.5,
    "transportScore": 5,
    "safetyRating": 4.2,
    "amenities": ["Supermarkets", "Cafes", "Parks", "Cinemas"],
    "tags": ["student-friendly", "lively", "accessible"]
  }'
echo -e "\n"

# Amsterdam - Noord
echo "📍 Adding Amsterdam - Noord..."
curl -X POST "$BASE_URL/neighborhoods" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Amsterdam Noord",
    "city": "Amsterdam",
    "description": "Upcoming creative area with more affordable rent prices",
    "latitude": 52.3936,
    "longitude": 4.9091,
    "studentRating": 4.1,
    "averageRent": 650,
    "universityDistance": 4.5,
    "transportScore": 4,
    "safetyRating": 4.5,
    "amenities": ["Supermarkets", "Creative Spaces", "Restaurants", "Parks"],
    "tags": ["student-friendly", "affordable", "upcoming", "creative"]
  }'
echo -e "\n"

# Utrecht - Centrum
echo "📍 Adding Utrecht - Centrum..."
curl -X POST "$BASE_URL/neighborhoods" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Utrecht Centrum",
    "city": "Utrecht",
    "description": "Historic city center with excellent student facilities and bike infrastructure",
    "latitude": 52.0907,
    "longitude": 5.1214,
    "studentRating": 4.6,
    "averageRent": 700,
    "universityDistance": 1.5,
    "transportScore": 5,
    "safetyRating": 4.6,
    "amenities": ["Supermarkets", "Libraries", "Cafes", "Restaurants", "Bike Shops"],
    "tags": ["student-friendly", "vibrant", "historic", "bike-friendly"]
  }'
echo -e "\n"

# Utrecht - De Uithof
echo "📍 Adding Utrecht - De Uithof..."
curl -X POST "$BASE_URL/neighborhoods" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Utrecht Science Park (De Uithof)",
    "city": "Utrecht",
    "description": "Campus area with affordable student housing near universities",
    "latitude": 52.0858,
    "longitude": 5.1720,
    "studentRating": 4.2,
    "averageRent": 550,
    "universityDistance": 0.5,
    "transportScore": 4,
    "safetyRating": 4.7,
    "amenities": ["Campus Facilities", "Supermarkets", "Sports Centers"],
    "tags": ["student-friendly", "quiet", "campus-life", "affordable"]
  }'
echo -e "\n"

# Rotterdam - Kralingen
echo "📍 Adding Rotterdam - Kralingen..."
curl -X POST "$BASE_URL/neighborhoods" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Kralingen",
    "city": "Rotterdam",
    "description": "Green and safe neighborhood close to Erasmus University",
    "latitude": 51.9283,
    "longitude": 4.5308,
    "studentRating": 4.3,
    "averageRent": 650,
    "universityDistance": 2.0,
    "transportScore": 5,
    "safetyRating": 4.4,
    "amenities": ["Parks", "Supermarkets", "Cafes", "Sports Facilities"],
    "tags": ["student-friendly", "green", "safe", "family-friendly"]
  }'
echo -e "\n"

# Rotterdam - Centrum
echo "📍 Adding Rotterdam - Centrum..."
curl -X POST "$BASE_URL/neighborhoods" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Rotterdam Centrum",
    "city": "Rotterdam",
    "description": "Modern city center with vibrant nightlife and cultural scene",
    "latitude": 51.9225,
    "longitude": 4.4792,
    "studentRating": 4.4,
    "averageRent": 700,
    "universityDistance": 3.5,
    "transportScore": 5,
    "safetyRating": 4.0,
    "amenities": ["Shopping", "Restaurants", "Bars", "Museums", "Cinema"],
    "tags": ["student-friendly", "vibrant", "modern", "nightlife"]
  }'
echo -e "\n"

# Groningen - Centrum
echo "📍 Adding Groningen - Centrum..."
curl -X POST "$BASE_URL/neighborhoods" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Groningen Centrum",
    "city": "Groningen",
    "description": "The ultimate student city with affordable rent and vibrant atmosphere",
    "latitude": 53.2194,
    "longitude": 6.5665,
    "studentRating": 4.7,
    "averageRent": 550,
    "universityDistance": 1.0,
    "transportScore": 5,
    "safetyRating": 4.8,
    "amenities": ["Supermarkets", "Cafes", "Bars", "Bike Shops", "Libraries"],
    "tags": ["student-friendly", "bike-friendly", "affordable", "vibrant", "young"]
  }'
echo -e "\n"

# Leiden - Centrum
echo "📍 Adding Leiden - Centrum..."
curl -X POST "$BASE_URL/neighborhoods" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Leiden Centrum",
    "city": "Leiden",
    "description": "Historic university city with beautiful canals and cozy atmosphere",
    "latitude": 52.1601,
    "longitude": 4.4970,
    "studentRating": 4.5,
    "averageRent": 680,
    "universityDistance": 1.2,
    "transportScore": 5,
    "safetyRating": 4.7,
    "amenities": ["Supermarkets", "Cafes", "Libraries", "Museums", "Canals"],
    "tags": ["student-friendly", "historic", "cozy", "canal-life"]
  }'
echo -e "\n"

# Delft - Centrum
echo "📍 Adding Delft - Centrum..."
curl -X POST "$BASE_URL/neighborhoods" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Delft Centrum",
    "city": "Delft",
    "description": "Charming tech city with historic center and excellent bike infrastructure",
    "latitude": 52.0116,
    "longitude": 4.3571,
    "studentRating": 4.4,
    "averageRent": 620,
    "universityDistance": 1.5,
    "transportScore": 5,
    "safetyRating": 4.6,
    "amenities": ["Supermarkets", "Cafes", "Tech Hubs", "Bike Shops"],
    "tags": ["student-friendly", "tech-hub", "historic", "bike-friendly"]
  }'
echo -e "\n"

# Eindhoven - Centrum
echo "📍 Adding Eindhoven - Centrum..."
curl -X POST "$BASE_URL/neighborhoods" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Eindhoven Centrum",
    "city": "Eindhoven",
    "description": "Modern tech city with affordable student housing and design focus",
    "latitude": 51.4416,
    "longitude": 5.4697,
    "studentRating": 4.3,
    "averageRent": 600,
    "universityDistance": 2.0,
    "transportScore": 5,
    "safetyRating": 4.3,
    "amenities": ["Tech Facilities", "Supermarkets", "Cafes", "Design Shops"],
    "tags": ["student-friendly", "tech-city", "modern", "design"]
  }'
echo -e "\n"

# Maastricht - Centrum
echo "📍 Adding Maastricht - Centrum..."
curl -X POST "$BASE_URL/neighborhoods" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Maastricht Centrum",
    "city": "Maastricht",
    "description": "International city with historic charm near Belgian and German borders",
    "latitude": 50.8514,
    "longitude": 5.6910,
    "studentRating": 4.5,
    "averageRent": 650,
    "universityDistance": 1.8,
    "transportScore": 4,
    "safetyRating": 4.5,
    "amenities": ["Supermarkets", "International Restaurants", "Cafes", "Museums"],
    "tags": ["student-friendly", "international", "historic", "border-city"]
  }'
echo -e "\n"

echo "✅ Seeding completed!"
echo ""
echo "🔍 To view all neighborhoods, run:"
echo "curl http://localhost:8080/neighborhoods"
echo ""
echo "🌟 To view top-rated neighborhoods, run:"
echo "curl http://localhost:8080/neighborhoods/top-rated"
