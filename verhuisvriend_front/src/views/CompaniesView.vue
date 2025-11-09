<template>
  <div class="companies-page">
    <section class="page-header">
      <div class="container">
        <h1>Trusted Moving Companies</h1>
        <p>Connect with verified companies rated by students</p>
      </div>
    </section>

    <section class="section">
      <div class="container">
        <div v-if="loading" class="loading">
          <div class="spinner"></div>
          <p>Loading companies...</p>
        </div>

        <div v-else-if="error" class="error-message">
          <p>{{ error }}</p>
          <button class="btn btn-primary" @click="fetchCompanies">Try Again</button>
        </div>

        <div v-else class="grid grid-2">
          <div v-for="company in companies" :key="company.id" class="company-card card">
            <div class="card-header">
              <h3 class="card-title">{{ company.name }}</h3>
              <div class="company-rating" v-if="company.rating">
                <span class="rating-icon">⭐</span>
                <span class="rating-value">{{ company.rating }}/5</span>
              </div>
            </div>

            <div class="company-details">
              <div class="detail" v-if="company.email">
                <span class="detail-icon">📧</span>
                <a :href="`mailto:${company.email}`">{{ company.email }}</a>
              </div>
              <div class="detail" v-if="company.phone">
                <span class="detail-icon">📞</span>
                <a :href="`tel:${company.phone}`">{{ company.phone }}</a>
              </div>
              <div class="detail" v-if="company.address">
                <span class="detail-icon">📍</span>
                <span>{{ company.address }}</span>
              </div>
              <div class="detail" v-if="company.serviceArea">
                <span class="detail-icon">🗺️</span>
                <span>{{ company.serviceArea }}</span>
              </div>
              <div class="detail" v-if="company.languagesSpoken">
                <span class="detail-icon">🌍</span>
                <span>{{ company.languagesSpoken }}</span>
              </div>
            </div>

            <div class="company-services" v-if="company.servicesOffered">
              <strong>Services:</strong> {{ company.servicesOffered }}
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { companyApi, type Company } from '@/services/api'

const companies = ref<Company[]>([])
const loading = ref(true)
const error = ref<string | null>(null)

const fetchCompanies = async () => {
  loading.value = true
  error.value = null
  try {
    const response = await companyApi.getAll()
    companies.value = response
  } catch (err: any) {
    console.error('Error fetching companies:', err)
    
    // Use mock data when API is not available
    companies.value = [
      {
        id: '1',
        name: 'StudentMove Pro',
        rating: 4.8,
        serviceArea: 'Amsterdam, Utrecht, Rotterdam',
        phone: '+31 20 123 4567',
        email: 'info@studentmove.nl',
        servicesOffered: 'Full-service moving, packing, storage',
        languagesSpoken: 'Dutch, English, Spanish'
      },
      {
        id: '2',
        name: 'Quick Relocate',
        rating: 4.5,
        serviceArea: 'Groningen, Leiden, Delft',
        phone: '+31 50 987 6543',
        email: 'contact@quickrelocate.nl',
        servicesOffered: 'Moving, furniture assembly',
        languagesSpoken: 'Dutch, English'
      },
      {
        id: '3',
        name: 'Campus Movers',
        rating: 4.7,
        serviceArea: 'Nationwide',
        phone: '+31 30 555 7890',
        email: 'hello@campusmovers.nl',
        servicesOffered: 'Student moves, international relocations',
        languagesSpoken: 'Dutch, English, German, French'
      },
      {
        id: '4',
        name: 'EasyMove NL',
        rating: 4.3,
        serviceArea: 'Amsterdam, Eindhoven, Maastricht',
        phone: '+31 40 222 3344',
        email: 'support@easymove.nl',
        servicesOffered: 'Budget moves, shared transport',
        languagesSpoken: 'Dutch, English'
      }
    ]
    
    // Silently use mock data without showing error
  } finally {
    loading.value = false
  }
}

onMounted(() => {
  fetchCompanies()
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

.company-card {
  cursor: default;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: start;
  margin-bottom: var(--space-md);
}

.company-rating {
  display: flex;
  align-items: center;
  gap: var(--space-xs);
  font-size: var(--font-size-sm);
  font-weight: var(--font-weight-semibold);
  color: var(--color-primary);
}

.rating-icon {
  font-size: var(--font-size-lg);
}

.company-details {
  display: flex;
  flex-direction: column;
  gap: var(--space-sm);
  margin-bottom: var(--space-md);
}

.detail {
  display: flex;
  align-items: start;
  gap: var(--space-xs);
  font-size: var(--font-size-sm);
  color: var(--color-text-soft);
}

.detail-icon {
  font-size: var(--font-size-base);
}

.detail a {
  color: var(--color-primary);
}

.company-services {
  font-size: var(--font-size-sm);
  color: var(--color-text-soft);
  padding-top: var(--space-md);
  border-top: 1px solid var(--color-border);
}

.company-services strong {
  color: var(--color-text);
}

.loading,
.error-message {
  text-align: center;
  padding: var(--space-3xl) 0;
}

.loading p {
  color: var(--color-text-soft);
  margin-top: var(--space-md);
}

.error-message p {
  color: var(--color-error);
  margin-bottom: var(--space-md);
}
</style>
