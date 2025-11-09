import axios from 'axios'

const API_BASE_URL = import.meta.env.VITE_API_BASE_URL || 'http://localhost:8080'

const api = axios.create({
  baseURL: API_BASE_URL,
  headers: {
    'Content-Type': 'application/json'
  }
})

// Request interceptor
api.interceptors.request.use(
  (config) => {
    // Add auth token if available
    const token = localStorage.getItem('token')
    if (token) {
      config.headers.Authorization = `Bearer ${token}`
    }
    return config
  },
  (error) => {
    return Promise.reject(error)
  }
)

// Response interceptor
api.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response?.status === 401) {
      // Handle unauthorized
      localStorage.removeItem('token')
      window.location.href = '/login'
    }
    return Promise.reject(error)
  }
)

// Neighborhood types
export interface Neighborhood {
  id?: string
  name: string
  city: string
  description?: string
  latitude: number
  longitude: number
  studentRating?: number
  averageRent?: number
  universityDistance?: number
  transportScore?: number
  safetyRating?: number
  amenities?: string[]
  tags?: string[]
  createdAt?: string
  updatedAt?: string
}

// Company types
export interface Company {
  id?: string
  name: string
  email?: string
  phone?: string
  address?: string
  serviceArea?: string
  servicesOffered?: string
  languagesSpoken?: string
  rating?: number
  createdAt?: string
  updatedAt?: string
}

// Move types
export interface Move {
  id?: string
  moveDate: string
  fromLocation: string
  toLocation: string
  userId: string
  status?: string
  createdAt?: string
  updatedAt?: string
}

// Task types
export interface Task {
  id?: string
  title: string
  description?: string
  isCompleted: boolean
  dueDate?: string
  priority?: string
  userId: string
  createdAt?: string
  updatedAt?: string
}

// Note types
export interface Note {
  id?: string
  title: string
  content: string
  category: string
  userId?: string
  moveId?: string
  createdAt?: string
  updatedAt?: string
}

// User types
export interface User {
  id?: string
  name: string
  email: string
  avatar?: string
  phone?: string
  createdAt?: string
}

export interface AuthResponse {
  user: User
  token: string
}

// Neighborhood API
export const neighborhoodApi = {
  getAll: () => api.get<Neighborhood[]>('/neighborhoods').then(res => res.data),
  getById: (id: string) => api.get<Neighborhood>(`/neighborhoods/${id}`).then(res => res.data),
  getTopRated: (limit?: number) =>
    api.get<Neighborhood[]>('/neighborhoods/top-rated', { params: { limit } }).then(res => res.data),
  getByCity: (city: string) => api.get<Neighborhood[]>(`/neighborhoods/by-city/${city}`).then(res => res.data),
  getNearby: (lat: number, lon: number, radius?: number) =>
    api.get<Neighborhood[]>('/neighborhoods/nearby', { params: { lat, lon, radius } }).then(res => res.data),
  getAffordable: (maxRent: number) =>
    api.get<Neighborhood[]>('/neighborhoods/affordable', { params: { maxRent } }).then(res => res.data),
  create: (data: Neighborhood) => api.post<Neighborhood>('/neighborhoods', data).then(res => res.data),
  update: (id: string, data: Neighborhood) => api.put<Neighborhood>(`/neighborhoods/${id}`, data).then(res => res.data),
  delete: (id: string) => api.delete(`/neighborhoods/${id}`).then(res => res.data)
}

// Company API
export const companyApi = {
  getAll: () => api.get<Company[]>('/companies').then(res => res.data),
  getById: (id: string) => api.get<Company>(`/companies/${id}`).then(res => res.data),
  getTopRated: (limit?: number) =>
    api.get<Company[]>('/companies/top-rated', { params: { limit } }).then(res => res.data),
  getByArea: (area: string) => api.get<Company[]>(`/companies/by-area/${area}`).then(res => res.data),
  create: (data: Company) => api.post<Company>('/companies', data).then(res => res.data),
  update: (id: string, data: Company) => api.put<Company>(`/companies/${id}`, data).then(res => res.data),
  delete: (id: string) => api.delete(`/companies/${id}`).then(res => res.data)
}

// Move API
export const moveApi = {
  getAll: () => api.get<Move[]>('/moves').then(res => res.data),
  getById: (id: string) => api.get<Move>(`/moves/${id}`).then(res => res.data),
  create: (data: Move) => api.post<Move>('/moves', data).then(res => res.data),
  update: (id: string, data: Move) => api.put<Move>(`/moves/${id}`, data).then(res => res.data),
  delete: (id: string) => api.delete(`/moves/${id}`).then(res => res.data)
}

// Task API
export const taskApi = {
  getAll: () => api.get<Task[]>('/tasks').then(res => res.data),
  getById: (id: string) => api.get<Task>(`/tasks/${id}`).then(res => res.data),
  create: (data: Task) => api.post<Task>('/tasks', data).then(res => res.data),
  update: (id: string, data: Task) => api.put<Task>(`/tasks/${id}`, data).then(res => res.data),
  delete: (id: string) => api.delete(`/tasks/${id}`).then(res => res.data)
}

// Note API
export const noteApi = {
  getAll: () => api.get<Note[]>('/notes').then(res => res.data),
  getById: (id: string) => api.get<Note>(`/notes/${id}`).then(res => res.data),
  getByMove: (moveId: string) => api.get<Note[]>(`/notes/move/${moveId}`).then(res => res.data),
  getByCategory: (category: string) => api.get<Note[]>(`/notes/category/${category}`).then(res => res.data),
  create: (data: Partial<Note>) => api.post<Note>('/notes', data).then(res => res.data),
  update: (id: string, data: Partial<Note>) => api.put<Note>(`/notes/${id}`, data).then(res => res.data),
  delete: (id: string) => api.delete(`/notes/${id}`).then(res => res.data)
}

// Auth API
export const authApi = {
  register: (data: { name: string; email: string; password: string; phone?: string }) =>
    api.post<AuthResponse>('/auth/register', data).then(res => res.data),
  login: (data: { email: string; password: string }) =>
    api.post<AuthResponse>('/auth/login', data).then(res => res.data),
  logout: () => api.post('/auth/logout').then(res => res.data),
  getCurrentUser: () => api.get<User>('/auth/me').then(res => res.data)
}

export default api
