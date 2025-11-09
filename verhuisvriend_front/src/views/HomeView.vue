<template>
  <div class="home">
    <!-- Hero Section -->
    <section class="hero">
      <div class="container">
        <div class="hero-content">
          <h1 class="hero-title">{{ $t('home.hero.title') }}</h1>
          <p class="hero-subtitle">
            {{ $t('home.hero.subtitle') }}
          </p>
          <div class="hero-actions">
            <button class="btn btn-primary btn-lg" @click="scrollToNeighborhoods">
              {{ $t('home.neighborhoods.viewAll') }}
            </button>
            <button class="btn btn-ghost btn-lg" @click="$router.push('/plan')">
              {{ $t('nav.planMove') }}
            </button>
          </div>
        </div>
      </div>
    </section>

    <!-- Stats Section -->
    <section class="stats">
      <div class="container">
        <div class="stats-grid">
          <div class="stat-card">
            <div class="stat-number">12+</div>
            <div class="stat-label">{{ $t('home.stats.cities') }}</div>
          </div>
          <div class="stat-card">
            <div class="stat-number">100+</div>
            <div class="stat-label">{{ $t('home.stats.companies') }}</div>
          </div>
          <div class="stat-card">
            <div class="stat-number">€550+</div>
            <div class="stat-label">{{ $t('home.stats.from') }}</div>
          </div>
        </div>
      </div>
    </section>

    <!-- Top Neighborhoods -->
    <section class="section" ref="neighborhoodsSection">
      <div class="container">
        <div class="section-header">
          <h2>{{ $t('home.neighborhoods.title') }}</h2>
          <p>{{ $t('neighborhoods.subtitle') }}</p>
        </div>

        <div v-if="loading" class="loading">
          <div class="spinner"></div>
          <p>{{ $t('common.loading') }}</p>
        </div>

        <div v-else-if="error" class="error-message">
          <p>{{ error }}</p>
          <button class="btn btn-primary" @click="fetchNeighborhoods">{{ $t('common.tryAgain') }}</button>
        </div>

        <div v-else class="grid grid-3">
          <div
            v-for="neighborhood in topNeighborhoods"
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
                <span class="stat-value">€{{ neighborhood.averageRent }}{{ $t('common.monthShort') }}</span>
              </div>
              <div class="stat" v-if="neighborhood.universityDistance">
                <span class="stat-icon">🎓</span>
                <span class="stat-value">{{ neighborhood.universityDistance }}{{ $t('common.km') }}</span>
              </div>
            </div>

            <p class="neighborhood-description">{{ neighborhood.description }}</p>

            <div class="neighborhood-tags" v-if="neighborhood.tags && neighborhood.tags.length">
              <span v-for="tag in neighborhood.tags.slice(0, 3)" :key="tag" class="badge badge-primary">
                {{ tag }}
              </span>
            </div>
          </div>
        </div>

        <div class="section-footer" v-if="!loading && !error">
          <button class="btn btn-primary" @click="$router.push('/neighborhoods')">
            {{ $t('home.neighborhoods.viewAll') }}
          </button>
        </div>
      </div>
    </section>

    <!-- Features Section -->
    <section class="section features">
      <div class="container">
        <div class="section-header text-center">
          <h2>{{ $t('home.features.title') }}</h2>
          <p>{{ $t('home.features.subtitle') }}</p>
        </div>

        <div class="grid grid-3">
          <div class="feature-card">
            <div class="feature-icon">🗺️</div>
            <h3>{{ $t('home.features.maps.title') }}</h3>
            <p>{{ $t('home.features.maps.description') }}</p>
          </div>

          <div class="feature-card">
            <div class="feature-icon">🏢</div>
            <h3>{{ $t('home.features.companies.title') }}</h3>
            <p>{{ $t('home.features.companies.description') }}</p>
          </div>

          <div class="feature-card">
            <div class="feature-icon">✅</div>
            <h3>{{ $t('home.features.planning.title') }}</h3>
            <p>{{ $t('home.features.planning.description') }}</p>
          </div>

          <div class="feature-card">
            <div class="feature-icon">💰</div>
            <h3>{{ $t('home.features.budget.title') }}</h3>
            <p>{{ $t('home.features.budget.description') }}</p>
          </div>

          <div class="feature-card">
            <div class="feature-icon">🌍</div>
            <h3>{{ $t('home.features.multilingual.title') }}</h3>
            <p>{{ $t('home.features.multilingual.description') }}</p>
          </div>

          <div class="feature-card">
            <div class="feature-icon">🔒</div>
            <h3>{{ $t('home.features.free.title') }}</h3>
            <p>{{ $t('home.features.free.description') }}</p>
          </div>
        </div>
      </div>
    </section>

    <!-- CTA Section -->
    <section class="cta-section">
      <div class="container">
        <div class="cta-content">
          <h2>{{ $t('home.cta.title') }}</h2>
          <p>{{ $t('home.cta.subtitle') }}</p>
          <button class="cta-button" @click="$router.push('/plan')">
            {{ $t('home.cta.button') }}
          </button>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { neighborhoodApi, type Neighborhood } from '@/services/api'

const router = useRouter()

const topNeighborhoods = ref<Neighborhood[]>([])
const loading = ref(true)
const error = ref<string | null>(null)
const neighborhoodsSection = ref<HTMLElement | null>(null)

const fetchNeighborhoods = async () => {
  loading.value = true
  error.value = null
  try {
    const response = await neighborhoodApi.getTopRated(6)
    topNeighborhoods.value = response
  } catch (err: any) {
    console.error('Error fetching neighborhoods:', err)
    
    // Use mock data when API is not available
    topNeighborhoods.value = [
      {
        id: '1',
        name: 'De Pijp',
        city: 'Amsterdam',
        description: 'Vibrant neighborhood with great nightlife and excellent public transport connections',
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
        description: 'Multicultural area close to university with affordable housing options',
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
        description: 'Green residential area near Erasmus University with parks and lakes',
        latitude: 51.9244,
        longitude: 4.5212,
        studentRating: 4.3,
        averageRent: 680,
        universityDistance: 3.0
      }
    ]
    
    error.value = null  // Don't show error on homepage
  } finally {
    loading.value = false
  }
}

const viewNeighborhood = (id: string) => {
  router.push(`/neighborhoods/${id}`)
}

const scrollToNeighborhoods = () => {
  neighborhoodsSection.value?.scrollIntoView({ behavior: 'smooth' })
}

onMounted(() => {
  fetchNeighborhoods()
})
</script>

<style scoped>
/* Hero Section */
.hero {
  padding: var(--space-3xl) 0;
  text-align: center;
  background: linear-gradient(
    to bottom,
    var(--color-background),
    var(--color-background-soft)
  );
}

.hero-content {
  max-width: 800px;
  margin: 0 auto;
}

.hero-title {
  font-size: clamp(2.5rem, 5vw, 4rem);
  margin-bottom: var(--space-md);
  background: linear-gradient(135deg, var(--color-text) 0%, var(--color-primary) 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.hero-subtitle {
  font-size: var(--font-size-xl);
  color: var(--color-text-soft);
  margin-bottom: var(--space-xl);
  line-height: 1.6;
}

.hero-actions {
  display: flex;
  gap: var(--space-md);
  justify-content: center;
  flex-wrap: wrap;
}

/* Stats Section */
.stats {
  padding: var(--space-2xl) 0;
  background: var(--color-background);
}

.stats-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: var(--space-lg);
}

.stat-card {
  text-align: center;
  padding: var(--space-lg);
}

.stat-number {
  font-size: var(--font-size-4xl);
  font-weight: var(--font-weight-bold);
  color: var(--color-primary);
  margin-bottom: var(--space-xs);
}

.stat-label {
  font-size: var(--font-size-base);
  color: var(--color-text-soft);
}

/* Section */
.section-header {
  text-align: center;
  margin-bottom: var(--space-2xl);
}

.section-header h2 {
  margin-bottom: var(--space-sm);
}

.section-header p {
  font-size: var(--font-size-lg);
  color: var(--color-text-soft);
  max-width: 600px;
  margin: 0 auto;
}

.section-footer {
  text-align: center;
  margin-top: var(--space-2xl);
}

/* Neighborhood Card */
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

/* Features */
.features {
  background: var(--color-background-soft);
}

.feature-card {
  text-align: center;
  padding: var(--space-lg);
}

.feature-icon {
  font-size: 3rem;
  margin-bottom: var(--space-md);
}

.feature-card h3 {
  font-size: var(--font-size-xl);
  margin-bottom: var(--space-sm);
}

.feature-card p {
  color: var(--color-text-soft);
  margin: 0;
}

/* CTA Section */
.cta-section {
  padding: var(--space-3xl) 0;
  background: linear-gradient(135deg, var(--color-primary) 0%, #0059b3 100%);
}

.cta-content {
  text-align: center;
  color: white;
}

.cta-content h2 {
  color: white;
  margin-bottom: var(--space-md);
}

.cta-content p {
  color: rgba(255, 255, 255, 0.9);
  font-size: var(--font-size-lg);
  margin-bottom: var(--space-xl);
  max-width: 600px;
  margin-left: auto;
  margin-right: auto;
}

.cta-button {
  background: white;
  color: var(--color-primary);
  padding: 14px 32px;
  font-size: var(--font-size-md);
  font-weight: 500;
  border-radius: var(--radius-full);
  border: none;
  cursor: pointer;
  transition: all 0.2s ease;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  display: inline-block;
  text-decoration: none;
}

.cta-button:hover {
  background: rgba(255, 255, 255, 0.95);
  transform: translateY(-2px);
  box-shadow: 0 6px 16px rgba(0, 0, 0, 0.15);
}

.cta-content .btn {
  background: white;
  color: var(--color-primary);
  padding: 14px 32px;
  font-size: var(--font-size-md);
  font-weight: 500;
  border-radius: var(--radius-full);
  border: none;
  cursor: pointer;
  transition: all 0.2s ease;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.cta-content .btn:hover {
  background: var(--color-background-soft);
  transform: translateY(-2px);
  box-shadow: 0 6px 16px rgba(0, 0, 0, 0.15);
}

/* Loading & Error */
.loading {
  text-align: center;
  padding: var(--space-3xl) 0;
}

.loading p {
  color: var(--color-text-soft);
  margin-top: var(--space-md);
}

.error-message {
  text-align: center;
  padding: var(--space-3xl) 0;
}

.error-message p {
  color: var(--color-error);
  margin-bottom: var(--space-md);
}
</style>
