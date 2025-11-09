<template>
  <div class="auth-container">
    <div class="auth-card">
      <div class="auth-header">
        <h1>{{ isLogin ? 'Welcome Back' : 'Create Account' }}</h1>
        <p>{{ isLogin ? 'Sign in to continue your moving journey' : 'Join thousands of students finding their perfect home' }}</p>
      </div>

      <form @submit.prevent="handleSubmit" class="auth-form">
        <div v-if="error" class="error-message">
          {{ error }}
        </div>

        <div v-if="!isLogin" class="form-group">
          <label for="name">Full Name</label>
          <input
            id="name"
            v-model="form.name"
            type="text"
            placeholder="John Doe"
            required
          />
        </div>

        <div class="form-group">
          <label for="email">Email</label>
          <input
            id="email"
            v-model="form.email"
            type="email"
            placeholder="john@example.com"
            required
          />
        </div>

        <div class="form-group">
          <label for="password">Password</label>
          <input
            id="password"
            v-model="form.password"
            type="password"
            :placeholder="isLogin ? 'Enter your password' : 'At least 6 characters'"
            required
          />
        </div>

        <div v-if="!isLogin" class="form-group">
          <label for="phone">Phone (optional)</label>
          <input
            id="phone"
            v-model="form.phone"
            type="tel"
            placeholder="+31 6 12345678"
          />
        </div>

        <button type="submit" class="btn btn-primary btn-full" :disabled="loading">
          <span v-if="!loading">{{ isLogin ? 'Sign In' : 'Create Account' }}</span>
          <span v-else class="spinner"></span>
        </button>
      </form>

      <div class="auth-footer">
        <p>
          {{ isLogin ? "Don't have an account?" : 'Already have an account?' }}
          <button @click="toggleMode" class="link-button">
            {{ isLogin ? 'Sign up' : 'Sign in' }}
          </button>
        </p>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive } from 'vue'
import { useRouter } from 'vue-router'
import { authApi } from '@/services/api'

const router = useRouter()
const isLogin = ref(true)
const loading = ref(false)
const error = ref('')

const form = reactive({
  name: '',
  email: '',
  password: '',
  phone: ''
})

const toggleMode = () => {
  isLogin.value = !isLogin.value
  error.value = ''
}

const handleSubmit = async () => {
  error.value = ''
  loading.value = true

  try {
    if (isLogin.value) {
      const response = await authApi.login({
        email: form.email,
        password: form.password
      })
      
      localStorage.setItem('token', response.token)
      localStorage.setItem('user', JSON.stringify(response.user))
      
      router.push('/dashboard')
    } else {
      const response = await authApi.register({
        name: form.name,
        email: form.email,
        password: form.password,
        phone: form.phone || undefined
      })
      
      localStorage.setItem('token', response.token)
      localStorage.setItem('user', JSON.stringify(response.user))
      
      router.push('/dashboard')
    }
  } catch (err: any) {
    error.value = err.response?.data?.reason || 'An error occurred. Please try again.'
  } finally {
    loading.value = false
  }
}
</script>

<style scoped>
.auth-container {
  min-height: calc(100vh - 140px);
  display: flex;
  align-items: center;
  justify-content: center;
  padding: var(--space-xl);
  background: linear-gradient(135deg, var(--color-surface) 0%, var(--color-background) 100%);
}

.auth-card {
  width: 100%;
  max-width: 440px;
  background: var(--color-background);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-2xl);
  padding: var(--space-2xl);
  box-shadow: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
}

.auth-header {
  text-align: center;
  margin-bottom: var(--space-xl);
}

.auth-header h1 {
  font-size: var(--font-size-3xl);
  font-weight: var(--font-weight-bold);
  margin-bottom: var(--space-xs);
  color: var(--color-text);
}

.auth-header p {
  color: var(--color-text-secondary);
  font-size: var(--font-size-sm);
}

.auth-form {
  display: flex;
  flex-direction: column;
  gap: var(--space-lg);
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: var(--space-xs);
}

.form-group label {
  font-size: var(--font-size-sm);
  font-weight: var(--font-weight-medium);
  color: var(--color-text);
}

.form-group input {
  padding: var(--space-sm) var(--space-md);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-lg);
  font-size: var(--font-size-base);
  transition: all 0.2s;
  background: var(--color-background);
  color: var(--color-text);
}

.form-group input:focus {
  outline: none;
  border-color: var(--color-primary);
  box-shadow: 0 0 0 3px rgba(0, 113, 227, 0.1);
}

.error-message {
  padding: var(--space-md);
  background: rgba(255, 59, 48, 0.1);
  border: 1px solid var(--color-error);
  border-radius: var(--radius-lg);
  color: var(--color-error);
  font-size: var(--font-size-sm);
  text-align: center;
}

.btn-full {
  width: 100%;
  margin-top: var(--space-md);
}

.auth-footer {
  margin-top: var(--space-xl);
  text-align: center;
  color: var(--color-text-secondary);
  font-size: var(--font-size-sm);
}

.link-button {
  background: none;
  border: none;
  color: var(--color-primary);
  font-weight: var(--font-weight-medium);
  cursor: pointer;
  padding: 0;
  margin-left: var(--space-xs);
}

.link-button:hover {
  text-decoration: underline;
}
</style>
