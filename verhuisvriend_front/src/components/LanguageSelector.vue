<template>
  <div class="language-selector">
    <button
      @click="toggleDropdown"
      class="language-button"
      :class="{ active: isOpen }"
      aria-label="Select language"
    >
      <span class="flag">{{ currentFlag }}</span>
      <span class="language-code">{{ currentLocale.toUpperCase() }}</span>
      <span class="arrow">{{ isOpen ? '▲' : '▼' }}</span>
    </button>

    <transition name="dropdown">
      <div v-if="isOpen" class="language-dropdown">
        <button
          v-for="lang in languages"
          :key="lang.code"
          @click="changeLanguage(lang.code)"
          class="language-option"
          :class="{ selected: currentLocale === lang.code }"
        >
          <span class="flag">{{ lang.flag }}</span>
          <span class="language-name">{{ lang.name }}</span>
        </button>
      </div>
    </transition>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, onUnmounted } from 'vue'
import { useI18n } from 'vue-i18n'

const { locale } = useI18n()
const isOpen = ref(false)

const languages = [
  { code: 'nl', name: 'Nederlands', flag: '🇳🇱' },
  { code: 'en', name: 'English', flag: '🇬🇧' },
  { code: 'pt', name: 'Português', flag: '🇧🇷' },
  { code: 'es', name: 'Español', flag: '🇪🇸' },
  { code: 'de', name: 'Deutsch', flag: '🇩🇪' },
  { code: 'fr', name: 'Français', flag: '🇫🇷' }
]

const currentLocale = computed(() => locale.value)

const currentFlag = computed(() => {
  const lang = languages.find(l => l.code === locale.value)
  return lang?.flag || '🌐'
})

const toggleDropdown = () => {
  isOpen.value = !isOpen.value
}

const changeLanguage = (code: string) => {
  locale.value = code
  localStorage.setItem('locale', code)
  isOpen.value = false
}

const closeDropdown = (e: MouseEvent) => {
  const target = e.target as HTMLElement
  if (!target.closest('.language-selector')) {
    isOpen.value = false
  }
}

onMounted(() => {
  document.addEventListener('click', closeDropdown)
})

onUnmounted(() => {
  document.removeEventListener('click', closeDropdown)
})
</script>

<style scoped>
.language-selector {
  position: relative;
}

.language-button {
  display: flex;
  align-items: center;
  gap: var(--space-xs);
  padding: var(--space-xs) var(--space-sm);
  background: transparent;
  border: 1px solid var(--color-border);
  border-radius: var(--radius-md);
  color: var(--color-text);
  cursor: pointer;
  transition: all var(--transition-fast);
  font-size: var(--font-size-sm);
}

.language-button:hover,
.language-button.active {
  background: var(--color-surface);
  border-color: var(--color-border-hover);
}

.flag {
  font-size: 1.2em;
  line-height: 1;
}

.language-code {
  font-weight: var(--font-weight-medium);
  letter-spacing: 0.05em;
}

.arrow {
  font-size: 0.7em;
  opacity: 0.6;
}

.language-dropdown {
  position: absolute;
  top: calc(100% + var(--space-xs));
  right: 0;
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-md);
  box-shadow: 0 4px 12px var(--color-shadow);
  min-width: 160px;
  z-index: 1000;
  overflow: hidden;
}

.language-option {
  display: flex;
  align-items: center;
  gap: var(--space-sm);
  width: 100%;
  padding: var(--space-sm) var(--space-md);
  background: transparent;
  border: none;
  color: var(--color-text);
  cursor: pointer;
  transition: background var(--transition-fast);
  text-align: left;
}

.language-option:hover {
  background: var(--color-background-soft);
}

.language-option.selected {
  background: var(--color-primary-soft);
  color: var(--color-primary);
}

.language-name {
  font-size: var(--font-size-sm);
  font-weight: var(--font-weight-medium);
}

/* Dropdown animation */
.dropdown-enter-active,
.dropdown-leave-active {
  transition: all var(--transition-fast);
}

.dropdown-enter-from,
.dropdown-leave-to {
  opacity: 0;
  transform: translateY(-8px);
}
</style>
