<template>
  <div class="neighborhood-detail">
    <div v-if="loading" class="loading-container">
      <div class="spinner"></div>
      <p>{{ $t('neighborhoodDetail.loading') }}</p>
    </div>

    <div v-else-if="error" class="error-container">
      <p class="error-message">{{ error }}</p>
      <button @click="$router.push('/neighborhoods')" class="btn btn-primary">
        {{ $t('neighborhoodDetail.backToList') }}
      </button>
    </div>

    <div v-else-if="neighborhood" class="neighborhood-content">
      <!-- Header -->
      <div class="neighborhood-header">
        <div class="container">
          <button @click="$router.back()" class="btn btn-ghost back-button">
            ← {{ $t('neighborhoodDetail.back') }}
          </button>
          <h1>{{ neighborhood.name }}</h1>
          <p class="city">{{ neighborhood.city }}, Netherlands</p>
          <div class="rating" v-if="neighborhood.studentRating">
            ⭐ {{ neighborhood.studentRating }}/5.0 {{ $t('neighborhoodDetail.studentRating') }}
          </div>
        </div>
      </div>

      <!-- Map Section -->
      <div class="map-section">
        <div class="container">
          <h2>{{ $t('neighborhoodDetail.location') }}</h2>
          <div id="map" class="map-container"></div>
        </div>
      </div>

      <!-- Details Section -->
      <div class="details-section">
        <div class="container">
          <div class="details-grid">
            <div class="detail-card">
              <h3>📍 {{ $t('neighborhoodDetail.locationDetails') }}</h3>
              <p v-if="neighborhood.description">{{ neighborhood.description }}</p>
              <ul>
                <li v-if="neighborhood.universityDistance">
                  <strong>{{ $t('neighborhoodDetail.universityDistance') }}:</strong> {{ neighborhood.universityDistance }} {{ $t('common.km') }}
                </li>
                <li>
                  <strong>{{ $t('neighborhoodDetail.coordinates') }}:</strong> {{ neighborhood.latitude.toFixed(4) }}, {{ neighborhood.longitude.toFixed(4) }}
                </li>
              </ul>
            </div>

            <div class="detail-card" v-if="neighborhood.averageRent">
              <h3>💰 {{ $t('neighborhoodDetail.housing') }}</h3>
              <p class="rent-price">€{{ neighborhood.averageRent }}{{ $t('common.month') }}</p>
              <p class="rent-label">{{ $t('neighborhoodDetail.averageRent') }}</p>
            </div>

            <div class="detail-card">
              <h3>📊 {{ $t('neighborhoodDetail.studentRating') }}</h3>
              <div class="rating-large">
                {{ neighborhood.studentRating || 'N/A' }}/5.0
              </div>
              <p class="rating-label">{{ $t('neighborhoodDetail.basedOnReviews') }}</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import L from 'leaflet'
import 'leaflet/dist/leaflet.css'
import type { Neighborhood } from '@/services/api'

// Corrigir ícones do Leaflet
delete (L.Icon.Default.prototype as any)._getIconUrl
L.Icon.Default.mergeOptions({
  iconRetinaUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.9.4/images/marker-icon-2x.png',
  iconUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.9.4/images/marker-icon.png',
  shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.9.4/images/marker-shadow.png',
})

const route = useRoute()
const router = useRouter()
const neighborhood = ref<Neighborhood | null>(null)
const loading = ref(true)
const error = ref<string | null>(null)
let map: L.Map | null = null

// Mock data para quando não tiver backend
const mockNeighborhoods: Record<string, Neighborhood> = {
  '1': {
    id: '1',
    name: 'De Pijp',
    city: 'Amsterdam',
    description: 'Vibrant neighborhood in South Amsterdam known for its diverse community, Albert Cuyp Market, and excellent nightlife. Close to Sarphatipark and well-connected by tram.',
    latitude: 52.3547,
    longitude: 4.8918,
    studentRating: 4.5,
    averageRent: 750,
    universityDistance: 2.5
  },
  '2': {
    id: '2',
    name: 'Lombok',
    city: 'Utrecht',
    description: 'Multicultural neighborhood in west Utrecht with affordable housing options. Close to Utrecht Science Park and Utrecht University. Great for international students.',
    latitude: 52.0907,
    longitude: 5.0987,
    studentRating: 4.2,
    averageRent: 650,
    universityDistance: 1.8
  },
  '3': {
    id: '3',
    name: 'Kralingen',
    city: 'Rotterdam',
    description: 'Green residential area in east Rotterdam, home to Kralingse Bos park and lake. Popular with Erasmus University students, offering a mix of housing options.',
    latitude: 51.9244,
    longitude: 4.5212,
    studentRating: 4.3,
    averageRent: 680,
    universityDistance: 3.0
  },
  '4': {
    id: '4',
    name: 'Paddepoel',
    city: 'Groningen',
    description: 'Student-friendly neighborhood in north Groningen with the most affordable housing in the city. Close to Zernike Campus and well-served by public transport.',
    latitude: 53.2356,
    longitude: 6.5469,
    studentRating: 4.1,
    averageRent: 550,
    universityDistance: 2.0
  }
}

const fetchNeighborhood = async () => {
  loading.value = true
  error.value = null
  
  try {
    const id = route.params.id as string
    
    // Simular busca da API com mock data
    await new Promise(resolve => setTimeout(resolve, 500))
    
    if (mockNeighborhoods[id]) {
      neighborhood.value = mockNeighborhoods[id]
    } else {
      throw new Error('Neighborhood not found')
    }
  } catch (err: any) {
    error.value = err.message || 'Failed to load neighborhood'
    console.error('Error fetching neighborhood:', err)
  } finally {
    loading.value = false
  }
}

const initMap = () => {
  if (!neighborhood.value) return

  // Aguardar o DOM estar pronto
  setTimeout(() => {
    const mapElement = document.getElementById('map')
    if (!mapElement) return

    // Criar o mapa
    map = L.map('map').setView(
      [neighborhood.value!.latitude, neighborhood.value!.longitude],
      14
    )

    // Adicionar tiles do OpenStreetMap
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      attribution: '© OpenStreetMap contributors',
      maxZoom: 19
    }).addTo(map)

    // Adicionar marcador
    const marker = L.marker([
      neighborhood.value!.latitude,
      neighborhood.value!.longitude
    ]).addTo(map)

    marker.bindPopup(`
      <strong>${neighborhood.value!.name}</strong><br>
      ${neighborhood.value!.city}<br>
      ${neighborhood.value!.averageRent ? `€${neighborhood.value!.averageRent}/month` : ''}
    `).openPopup()
  }, 100)
}

onMounted(async () => {
  await fetchNeighborhood()
  if (neighborhood.value) {
    initMap()
  }
})
</script>

<style scoped>
.neighborhood-detail {
  min-height: 100vh;
  padding-bottom: var(--space-3xl);
}

.loading-container,
.error-container {
  min-height: 60vh;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: var(--space-lg);
}

.neighborhood-header {
  background: linear-gradient(135deg, var(--color-primary) 0%, #005bb5 100%);
  color: white;
  padding: var(--space-3xl) 0 var(--space-2xl);
  margin-bottom: var(--space-2xl);
}

.back-button {
  margin-bottom: var(--space-md);
  color: white !important;
  border-color: rgba(255, 255, 255, 0.3) !important;
}

.back-button:hover {
  background: rgba(255, 255, 255, 0.1) !important;
  border-color: rgba(255, 255, 255, 0.5) !important;
}

.neighborhood-header h1 {
  color: white;
  margin-bottom: var(--space-xs);
}

.city {
  color: rgba(255, 255, 255, 0.9);
  font-size: var(--font-size-lg);
  margin-bottom: var(--space-sm);
}

.rating {
  display: inline-block;
  background: rgba(255, 255, 255, 0.2);
  padding: var(--space-xs) var(--space-md);
  border-radius: var(--radius-full);
  font-size: var(--font-size-sm);
  font-weight: var(--font-weight-medium);
}

.map-section {
  margin-bottom: var(--space-2xl);
}

.map-section h2 {
  margin-bottom: var(--space-lg);
}

.map-container {
  width: 100%;
  height: 500px;
  border-radius: var(--radius-xl);
  overflow: hidden;
  border: 1px solid var(--color-border);
  background: var(--color-surface);
}

.details-section {
  margin-bottom: var(--space-2xl);
}

.details-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: var(--space-lg);
}

.detail-card {
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-xl);
  padding: var(--space-xl);
}

.detail-card h3 {
  font-size: var(--font-size-xl);
  margin-bottom: var(--space-md);
  color: var(--color-text);
}

.detail-card ul {
  list-style: none;
  padding: 0;
}

.detail-card li {
  padding: var(--space-sm) 0;
  border-bottom: 1px solid var(--color-border);
}

.detail-card li:last-child {
  border-bottom: none;
}

.rent-price {
  font-size: var(--font-size-4xl);
  font-weight: var(--font-weight-bold);
  color: var(--color-primary);
  margin-bottom: var(--space-xs);
}

.rent-label {
  color: var(--color-text-secondary);
  font-size: var(--font-size-sm);
}

.rating-large {
  font-size: var(--font-size-4xl);
  font-weight: var(--font-weight-bold);
  color: var(--color-success);
  margin-bottom: var(--space-xs);
}

.rating-label {
  color: var(--color-text-secondary);
  font-size: var(--font-size-sm);
}

@media (max-width: 768px) {
  .map-container {
    height: 350px;
  }

  .details-grid {
    grid-template-columns: 1fr;
  }
}
</style>
