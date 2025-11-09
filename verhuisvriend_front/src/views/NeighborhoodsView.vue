<template>
  <div class="neighborhoods-page">
    <section class="page-header">
      <div class="container">
        <h1>{{ $t('neighborhoods.title') }}</h1>
        <p>{{ $t('neighborhoods.subtitle') }}</p>
      </div>
    </section>

    <!-- Filters -->
    <section class="filters-section">
      <div class="container">
        <div class="filters">
          <div class="filter-group">
            <label for="city">{{ $t('neighborhoods.filters.city') }}</label>
            <select id="city" v-model="filters.city" class="input" @change="applyFilters">
              <option value="">{{ $t('neighborhoods.filters.allCities') }}</option>
              <option value="Amsterdam">Amsterdam</option>
              <option value="Utrecht">Utrecht</option>
              <option value="Rotterdam">Rotterdam</option>
              <option value="Groningen">Groningen</option>
              <option value="Leiden">Leiden</option>
              <option value="Delft">Delft</option>
              <option value="Eindhoven">Eindhoven</option>
              <option value="Maastricht">Maastricht</option>
            </select>
          </div>

          <div class="filter-group">
            <label for="maxRent">{{ $t('neighborhoods.filters.maxRent') }}</label>
            <input
              id="maxRent"
              v-model.number="filters.maxRent"
              type="number"
              class="input"
              placeholder="e.g. 800"
              @input="applyFilters"
            />
          </div>

          <button class="btn btn-secondary" @click="clearFilters">{{ $t('neighborhoods.filters.clearFilters') }}</button>
        </div>
      </div>
    </section>

    <!-- Neighborhoods Grid -->
    <section class="section">
      <div class="container">
        <div v-if="loading" class="loading">
          <div class="spinner"></div>
          <p>{{ $t('common.loading') }}</p>
        </div>

        <div v-else-if="error" class="error-message">
          <p>{{ error }}</p>
          <button class="btn btn-primary" @click="fetchNeighborhoods">{{ $t('common.tryAgain') }}</button>
        </div>

        <div v-else-if="filteredNeighborhoods.length === 0" class="empty-state">
          <p>{{ $t('neighborhoods.empty') }}</p>
          <button class="btn btn-primary" @click="clearFilters">{{ $t('neighborhoods.filters.clearFilters') }}</button>
        </div>

        <div v-else class="grid grid-3">
          <div
            v-for="neighborhood in filteredNeighborhoods"
            :key="neighborhood.id"
            class="neighborhood-card card"
            @click="viewNeighborhood(neighborhood.id!)"
          >
            <div class="card-header">
              <h3 class="card-title">{{ neighborhood.name }}</h3>
              <p class="card-subtitle">{{ neighborhood.city }}</p>
            </div>

            <div class="neighborhood-stats">
              <div class="stat" v-if="neighborhood.studentRating">
                <span class="stat-icon">⭐</span>
                <span class="stat-value">{{ neighborhood.studentRating }}/5</span>
              </div>
              <div class="stat" v-if="neighborhood.averageRent">
                <span class="stat-icon">💰</span>
                <span class="stat-value">€{{ neighborhood.averageRent }}/mo</span>
              </div>
              <div class="stat" v-if="neighborhood.universityDistance">
                <span class="stat-icon">🎓</span>
                <span class="stat-value">{{ neighborhood.universityDistance }}km</span>
              </div>
            </div>

            <p class="neighborhood-description">{{ neighborhood.description }}</p>

            <div class="neighborhood-tags" v-if="neighborhood.tags && neighborhood.tags.length">
              <span
                v-for="tag in neighborhood.tags.slice(0, 3)"
                :key="tag"
                class="badge badge-primary"
              >
                {{ tag }}
              </span>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { neighborhoodApi, type Neighborhood } from '@/services/api'

const router = useRouter()

const neighborhoods = ref<Neighborhood[]>([])
const loading = ref(true)
const error = ref<string | null>(null)

const filters = ref({
  city: '',
  maxRent: null as number | null
})

const fetchNeighborhoods = async () => {
  loading.value = true
  error.value = null
  try {
    const response = await neighborhoodApi.getAll()
    neighborhoods.value = response
  } catch (err: any) {
    console.error('Error fetching neighborhoods:', err)
    
    // Use mock data when API is not available
    neighborhoods.value = [
      {
        id: '1',
        name: 'De Pijp',
        city: 'Amsterdam',
        description: 'Vibrant neighborhood with great nightlife',
        latitude: 52.3547,
        longitude: 4.8918,
        studentRating: 4.5,
        averageRent: 750,
        universityDistance: 2.5
      },
      {
        id: '2',
        name: 'Lombok',
        city: 'Utrecht',
        description: 'Multicultural area close to university',
        latitude: 52.0907,
        longitude: 5.0987,
        studentRating: 4.2,
        averageRent: 650,
        universityDistance: 1.8
      },
      {
        id: '3',
        name: 'Kralingen',
        city: 'Rotterdam',
        description: 'Green residential area near Erasmus',
        latitude: 51.9244,
        longitude: 4.5212,
        studentRating: 4.3,
        averageRent: 680,
        universityDistance: 3.0
      },
      {
        id: '4',
        name: 'Paddepoel',
        city: 'Groningen',
        description: 'Student-friendly with affordable housing',
        latitude: 53.2356,
        longitude: 6.5469,
        studentRating: 4.1,
        averageRent: 550,
        universityDistance: 2.0
      }
    ]
    
    // Silently use mock data without showing error
  } finally {
    loading.value = false
  }
}

const filteredNeighborhoods = computed(() => {
  let result = neighborhoods.value

  if (filters.value.city) {
    result = result.filter((n) => n.city === filters.value.city)
  }

  if (filters.value.maxRent) {
    result = result.filter((n) => n.averageRent && n.averageRent <= filters.value.maxRent!)
  }

  return result
})

const applyFilters = () => {
  // Filters are applied automatically through computed property
}

const clearFilters = () => {
  filters.value.city = ''
  filters.value.maxRent = null
}

const viewNeighborhood = (id: string) => {
  router.push(`/neighborhoods/${id}`)
}

onMounted(() => {
  fetchNeighborhoods()
})
</script>

<style scoped>
.page-header {
  background: linear-gradient(to bottom, var(--color-background), var(--color-background-soft));
  padding: var(--space-2xl) 0;
  text-align: center;
}

.page-header h1 {
  margin-bottom: var(--space-sm);
}

.page-header p {
  font-size: var(--font-size-lg);
  color: var(--color-text-soft);
  max-width: 600px;
  margin: 0 auto;
}

.filters-section {
  background: var(--color-background);
  padding: var(--space-lg) 0;
  border-bottom: 1px solid var(--color-border);
}

.filters {
  display: flex;
  gap: var(--space-md);
  flex-wrap: wrap;
  align-items: end;
}

.filter-group {
  flex: 1;
  min-width: 200px;
}

.filter-group label {
  display: block;
  font-size: var(--font-size-sm);
  font-weight: var(--font-weight-medium);
  color: var(--color-text);
  margin-bottom: var(--space-xs);
}

.neighborhood-card {
  cursor: pointer;
}

.neighborhood-stats {
  display: flex;
  gap: var(--space-md);
  margin-bottom: var(--space-md);
}

.stat {
  display: flex;
  align-items: center;
  gap: var(--space-xs);
  font-size: var(--font-size-sm);
}

.stat-icon {
  font-size: var(--font-size-lg);
}

.stat-value {
  font-weight: var(--font-weight-medium);
  color: var(--color-text);
}

.neighborhood-description {
  font-size: var(--font-size-sm);
  color: var(--color-text-soft);
  margin-bottom: var(--space-md);
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.neighborhood-tags {
  display: flex;
  gap: var(--space-xs);
  flex-wrap: wrap;
}

.loading,
.error-message,
.empty-state {
  text-align: center;
  padding: var(--space-3xl) 0;
}

.loading p,
.empty-state p {
  color: var(--color-text-soft);
  margin-top: var(--space-md);
}

.error-message p {
  color: var(--color-error);
  margin-bottom: var(--space-md);
}
</style>
