<template>
  <footer class="footer">
    <div class="container">
      <div class="footer-content">
        <!-- Brand -->
        <div class="footer-brand">
          <div class="logo">
            <svg width="32" height="32" viewBox="0 0 32 32" fill="none">
              <rect width="32" height="32" rx="8" fill="currentColor"/>
              <path d="M16 8L22 14H18V22H14V14H10L16 8Z" fill="white"/>
            </svg>
            <span>VerhuisVriend</span>
          </div>
          <p class="tagline">{{ $t('footer.tagline') }}</p>
        </div>

        <!-- Links -->
        <div class="footer-links">
          <div class="footer-column">
            <h4>{{ $t('footer.product') }}</h4>
            <RouterLink to="/neighborhoods">{{ $t('footer.neighborhoods') }}</RouterLink>
            <RouterLink to="/companies">{{ $t('footer.companies') }}</RouterLink>
            <RouterLink to="/plan">{{ $t('footer.planMove') }}</RouterLink>
          </div>

          <div class="footer-column">
            <h4>{{ $t('footer.resources') }}</h4>
            <a href="https://github.com/thekogami/VerhuisVriend" target="_blank">{{ $t('footer.github') }}</a>
            <a href="#">{{ $t('footer.documentation') }}</a>
            <a href="#">{{ $t('footer.api') }}</a>
          </div>

          <div class="footer-column">
            <h4>{{ $t('footer.company') }}</h4>
            <a href="#">{{ $t('footer.about') }}</a>
            <a href="#">{{ $t('footer.contact') }}</a>
            <a href="#">{{ $t('footer.privacy') }}</a>
          </div>
        </div>
      </div>

      <!-- Bottom -->
      <div class="footer-bottom">
        <p>&copy; {{ currentYear }} VerhuisVriend. {{ $t('footer.copyright') }}</p>
      </div>
    </div>
  </footer>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { RouterLink } from 'vue-router'

const currentYear = computed(() => new Date().getFullYear())
</script>

<style scoped>
.footer {
  background: var(--color-background-soft);
  border-top: 1px solid var(--color-border);
  padding: var(--space-3xl) 0 var(--space-lg);
  margin-top: var(--space-3xl);
}

.footer-content {
  display: grid;
  gap: var(--space-2xl);
  margin-bottom: var(--space-2xl);
}

.footer-brand {
  max-width: 300px;
}

.logo {
  display: flex;
  align-items: center;
  gap: var(--space-sm);
  font-size: var(--font-size-lg);
  font-weight: var(--font-weight-semibold);
  color: var(--color-text);
  margin-bottom: var(--space-sm);
}

.logo svg {
  color: var(--color-primary);
}

.tagline {
  color: var(--color-text-soft);
  font-size: var(--font-size-base);
  margin: 0;
}

.footer-links {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
  gap: var(--space-lg);
}

.footer-column h4 {
  font-size: var(--font-size-sm);
  font-weight: var(--font-weight-semibold);
  text-transform: uppercase;
  letter-spacing: 0.05em;
  color: var(--color-text-mute);
  margin-bottom: var(--space-sm);
}

.footer-column a {
  display: block;
  padding: var(--space-xs) 0;
  color: var(--color-text-soft);
  font-size: var(--font-size-sm);
  transition: color var(--transition-fast);
}

.footer-column a:hover {
  color: var(--color-primary);
}

.footer-bottom {
  padding-top: var(--space-lg);
  border-top: 1px solid var(--color-border);
  text-align: center;
}

.footer-bottom p {
  color: var(--color-text-mute);
  font-size: var(--font-size-sm);
  margin: 0;
}

@media (min-width: 768px) {
  .footer-content {
    grid-template-columns: 2fr 3fr;
  }
}
</style>
