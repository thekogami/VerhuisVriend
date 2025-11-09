<template>
  <header class="navbar">
    <div class="container">
      <div class="navbar-content">
        <!-- Logo -->
        <RouterLink to="/" class="logo">
          <svg width="32" height="32" viewBox="0 0 32 32" fill="none">
            <rect width="32" height="32" rx="8" fill="currentColor"/>
            <path d="M16 8L22 14H18V22H14V14H10L16 8Z" fill="white"/>
          </svg>
          <span>VerhuisVriend</span>
        </RouterLink>

        <!-- Desktop Navigation -->
        <nav class="nav-links">
          <RouterLink to="/">{{ $t('nav.home') }}</RouterLink>
          <RouterLink to="/neighborhoods">{{ $t('nav.neighborhoods') }}</RouterLink>
          <RouterLink to="/companies">{{ $t('nav.companies') }}</RouterLink>
          <RouterLink to="/plan">{{ $t('nav.planMove') }}</RouterLink>
          <LanguageSelector />
        </nav>

        <!-- CTA Button -->
        <div class="nav-actions">
          <RouterLink v-if="!isLoggedIn" to="/auth" class="btn btn-primary">
            {{ $t('nav.signIn') }}
          </RouterLink>
          <div v-else class="user-menu">
            <RouterLink to="/dashboard" class="btn btn-secondary">
              {{ $t('nav.dashboard') }}
            </RouterLink>
            <button @click="handleLogout" class="btn btn-ghost">
              {{ $t('nav.logout') }}
            </button>
          </div>
        </div>

        <!-- Mobile Menu Toggle -->
        <button class="mobile-toggle" @click="toggleMobileMenu" aria-label="Toggle menu">
          <svg width="24" height="24" fill="none" stroke="currentColor" stroke-width="2">
            <path v-if="!mobileMenuOpen" d="M4 6h16M4 12h16M4 18h16"/>
            <path v-else d="M6 18L18 6M6 6l12 12"/>
          </svg>
        </button>
      </div>

      <!-- Mobile Menu -->
      <Transition name="mobile-menu">
        <nav v-if="mobileMenuOpen" class="mobile-nav">
          <RouterLink to="/" @click="closeMobileMenu">{{ $t('nav.home') }}</RouterLink>
          <RouterLink to="/neighborhoods" @click="closeMobileMenu">{{ $t('nav.neighborhoods') }}</RouterLink>
          <RouterLink to="/companies" @click="closeMobileMenu">{{ $t('nav.companies') }}</RouterLink>
          <RouterLink to="/plan" @click="closeMobileMenu">{{ $t('nav.planMove') }}</RouterLink>
          <div class="mobile-language">
            <LanguageSelector />
          </div>
          <RouterLink v-if="!isLoggedIn" to="/auth" @click="closeMobileMenu" class="btn btn-primary">
            {{ $t('nav.signIn') }}
          </RouterLink>
          <template v-else>
            <RouterLink to="/dashboard" @click="closeMobileMenu" class="btn btn-secondary">
              {{ $t('nav.dashboard') }}
            </RouterLink>
            <button @click="handleLogout" class="btn btn-ghost">
              {{ $t('nav.logout') }}
            </button>
          </template>
        </nav>
      </Transition>
    </div>
  </header>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { RouterLink, useRouter } from 'vue-router'
import { authApi } from '@/services/api'
import LanguageSelector from './LanguageSelector.vue'

const router = useRouter()
const mobileMenuOpen = ref(false)
const isLoggedIn = computed(() => !!localStorage.getItem('token'))

const toggleMobileMenu = () => {
  mobileMenuOpen.value = !mobileMenuOpen.value
}

const closeMobileMenu = () => {
  mobileMenuOpen.value = false
}

const handleLogout = async () => {
  try {
    await authApi.logout()
  } catch (error) {
    console.error('Logout failed:', error)
  } finally {
    localStorage.removeItem('token')
    localStorage.removeItem('user')
    closeMobileMenu()
    router.push('/')
  }
}
</script>

<style scoped>
.navbar {
  position: sticky;
  top: 0;
  z-index: 1000;
  background: rgba(255, 255, 255, 0.8);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border-bottom: 1px solid var(--color-border);
  padding: 1rem 0;
}

.navbar-content {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: var(--space-lg);
}

.logo {
  display: flex;
  align-items: center;
  gap: var(--space-sm);
  font-size: var(--font-size-lg);
  font-weight: var(--font-weight-semibold);
  color: var(--color-text);
}

.logo svg {
  color: var(--color-primary);
}

.nav-links {
  display: none;
  gap: var(--space-lg);
  align-items: center;
}

.nav-links a {
  font-size: var(--font-size-base);
  font-weight: var(--font-weight-medium);
  color: var(--color-text-soft);
  transition: color var(--transition-fast);
}

.nav-links a:hover,
.nav-links a.router-link-active {
  color: var(--color-primary);
}

.nav-actions {
  display: none;
}

.user-menu {
  display: flex;
  align-items: center;
  gap: var(--space-sm);
}

.mobile-toggle {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 40px;
  height: 40px;
  border: none;
  background: transparent;
  color: var(--color-text);
  cursor: pointer;
  border-radius: var(--radius-md);
  transition: background var(--transition-fast);
}

.mobile-toggle:hover {
  background: var(--color-background-mute);
}

.mobile-nav {
  display: flex;
  flex-direction: column;
  gap: var(--space-sm);
  padding: var(--space-lg) 0;
  border-top: 1px solid var(--color-border);
  margin-top: var(--space-md);
}

.mobile-nav a {
  padding: var(--space-sm);
  font-size: var(--font-size-base);
  font-weight: var(--font-weight-medium);
  color: var(--color-text-soft);
  border-radius: var(--radius-md);
  transition: all var(--transition-fast);
}

.mobile-nav a:hover,
.mobile-nav a.router-link-active {
  color: var(--color-primary);
  background: var(--color-primary-soft);
}

.mobile-nav .btn {
  width: 100%;
  margin-top: var(--space-sm);
}

.mobile-language {
  padding: var(--space-md) 0;
  display: flex;
  justify-content: center;
}

/* Mobile menu transitions */
.mobile-menu-enter-active,
.mobile-menu-leave-active {
  transition: all 0.3s ease;
  transform-origin: top;
}

.mobile-menu-enter-from,
.mobile-menu-leave-to {
  opacity: 0;
  transform: scaleY(0.8);
}

/* Desktop styles */
@media (min-width: 768px) {
  .nav-links {
    display: flex;
  }

  .nav-actions {
    display: block;
  }

  .mobile-toggle,
  .mobile-nav {
    display: none;
  }
}

/* Dark mode */
@media (prefers-color-scheme: dark) {
  .navbar {
    background: rgba(0, 0, 0, 0.8);
  }
}
</style>
