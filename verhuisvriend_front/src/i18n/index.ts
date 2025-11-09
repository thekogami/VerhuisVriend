import { createI18n } from 'vue-i18n'
import en from './locales/en.json'
import nl from './locales/nl.json'
import de from './locales/de.json'
import fr from './locales/fr.json'
import pt from './locales/pt.json'
import es from './locales/es.json'

const i18n = createI18n({
  legacy: false,
  locale: localStorage.getItem('locale') || 'en',
  fallbackLocale: 'en',
  messages: {
    en,
    nl,
    de,
    fr,
    pt,
    es
  }
})

export default i18n
