import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView
    },
    {
      path: '/neighborhoods',
      name: 'neighborhoods',
      component: () => import('../views/NeighborhoodsView.vue')
    },
    {
      path: '/neighborhoods/:id',
      name: 'neighborhood-detail',
      component: () => import('../views/NeighborhoodDetailView.vue')
    },
    {
      path: '/companies',
      name: 'companies',
      component: () => import('../views/CompaniesView.vue')
    },
    {
      path: '/plan',
      name: 'plan',
      component: () => import('../views/PlanView.vue')
    },
    {
      path: '/auth',
      name: 'auth',
      component: () => import('../views/AuthView.vue')
    },
    {
      path: '/dashboard',
      name: 'dashboard',
      component: () => import('../views/DashboardView.vue'),
      meta: { requiresAuth: true }
    }
  ],
  scrollBehavior(to, from, savedPosition) {
    if (savedPosition) {
      return savedPosition
    } else {
      return { top: 0 }
    }
  },
})

// Navigation guard for protected routes
router.beforeEach((to, from, next) => {
  const token = localStorage.getItem('token')
  
  if (to.meta.requiresAuth && !token) {
    next('/auth')
  } else if (to.path === '/auth' && token) {
    next('/dashboard')
  } else {
    next()
  }
})

export default router
