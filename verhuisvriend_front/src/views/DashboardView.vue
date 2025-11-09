<template>
  <div class="dashboard">
    <div class="dashboard-header">
      <div class="container">
        <h1>Welcome back, {{ user?.name }}!</h1>
        <p>Manage your move and notes here</p>
      </div>
    </div>

    <div class="container dashboard-content">
      <div class="dashboard-grid">
        <!-- Quick Stats -->
        <div class="stats-section">
          <h2>Quick Stats</h2>
          <div class="stats-grid">
            <div class="stat-card">
              <div class="stat-icon">📝</div>
              <div class="stat-info">
                <div class="stat-value">{{ notes.length }}</div>
                <div class="stat-label">Notes</div>
              </div>
            </div>
            <div class="stat-card">
              <div class="stat-icon">🏠</div>
              <div class="stat-info">
                <div class="stat-value">{{ moves.length }}</div>
                <div class="stat-label">Moves</div>
              </div>
            </div>
            <div class="stat-card">
              <div class="stat-icon">✓</div>
              <div class="stat-info">
                <div class="stat-value">{{ tasks.length }}</div>
                <div class="stat-label">Tasks</div>
              </div>
            </div>
          </div>
        </div>

        <!-- Recent Notes -->
        <div class="notes-section">
          <div class="section-header">
            <h2>Recent Notes</h2>
            <button @click="showNoteModal = true" class="btn btn-primary">
              + New Note
            </button>
          </div>

          <div v-if="loading" class="loading">
            <div class="spinner"></div>
          </div>

          <div v-else-if="notes.length === 0" class="empty-state">
            <p>No notes yet. Create your first one!</p>
          </div>

          <div v-else class="notes-list">
            <div v-for="note in notes" :key="note.id" class="note-card">
              <div class="note-header">
                <h3>{{ note.title }}</h3>
                <span class="note-category">{{ note.category }}</span>
              </div>
              <p class="note-content">{{ note.content }}</p>
              <div class="note-footer">
                <span class="note-date">{{ formatDate(note.createdAt) }}</span>
                <div class="note-actions">
                  <button @click="editNote(note)" class="btn-icon">✏️</button>
                  <button @click="note.id && deleteNote(note.id)" class="btn-icon">🗑️</button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Note Modal -->
    <div v-if="showNoteModal" class="modal-overlay" @click="closeModal">
      <div class="modal" @click.stop>
        <div class="modal-header">
          <h2>{{ editingNote ? 'Edit Note' : 'New Note' }}</h2>
          <button @click="closeModal" class="btn-close">×</button>
        </div>
        <form @submit.prevent="saveNote" class="modal-form">
          <div class="form-group">
            <label for="title">Title</label>
            <input
              id="title"
              v-model="noteForm.title"
              type="text"
              placeholder="Note title"
              required
            />
          </div>

          <div class="form-group">
            <label for="content">Content</label>
            <textarea
              id="content"
              v-model="noteForm.content"
              placeholder="Write your note here..."
              rows="5"
              required
            ></textarea>
          </div>

          <div class="form-group">
            <label for="category">Category</label>
            <select id="category" v-model="noteForm.category">
              <option value="general">General</option>
              <option value="task">Task</option>
              <option value="reminder">Reminder</option>
              <option value="checklist">Checklist</option>
            </select>
          </div>

          <div class="modal-actions">
            <button type="button" @click="closeModal" class="btn btn-secondary">
              Cancel
            </button>
            <button type="submit" class="btn btn-primary" :disabled="saving">
              {{ saving ? 'Saving...' : 'Save' }}
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { noteApi, moveApi, taskApi } from '@/services/api'
import type { Note, Move, Task } from '@/services/api'

const router = useRouter()
const user = ref<any>(null)
const notes = ref<Note[]>([])
const moves = ref<Move[]>([])
const tasks = ref<Task[]>([])
const loading = ref(false)
const saving = ref(false)
const showNoteModal = ref(false)
const editingNote = ref<Note | null>(null)

const noteForm = reactive({
  title: '',
  content: '',
  category: 'general'
})

onMounted(async () => {
  const token = localStorage.getItem('token')
  if (!token) {
    router.push('/auth')
    return
  }

  const userStr = localStorage.getItem('user')
  if (userStr) {
    user.value = JSON.parse(userStr)
  }

  await loadData()
})

const loadData = async () => {
  loading.value = true
  try {
    const [notesData, movesData, tasksData] = await Promise.all([
      noteApi.getAll(),
      moveApi.getAll(),
      taskApi.getAll()
    ])
    notes.value = notesData
    moves.value = movesData
    tasks.value = tasksData
  } catch (error) {
    console.error('Failed to load data:', error)
  } finally {
    loading.value = false
  }
}

const saveNote = async () => {
  saving.value = true
  try {
    if (editingNote.value) {
      await noteApi.update(editingNote.value.id!, noteForm)
    } else {
      await noteApi.create(noteForm)
    }
    await loadData()
    closeModal()
  } catch (error) {
    console.error('Failed to save note:', error)
  } finally {
    saving.value = false
  }
}

const editNote = (note: Note) => {
  editingNote.value = note
  noteForm.title = note.title
  noteForm.content = note.content
  noteForm.category = note.category
  showNoteModal.value = true
}

const deleteNote = async (id: string) => {
  if (!confirm('Are you sure you want to delete this note?')) return

  try {
    await noteApi.delete(id)
    await loadData()
  } catch (error) {
    console.error('Failed to delete note:', error)
  }
}

const closeModal = () => {
  showNoteModal.value = false
  editingNote.value = null
  noteForm.title = ''
  noteForm.content = ''
  noteForm.category = 'general'
}

const formatDate = (date: any) => {
  if (!date) return ''
  return new Date(date).toLocaleDateString('en-US', {
    month: 'short',
    day: 'numeric',
    year: 'numeric'
  })
}
</script>

<style scoped>
.dashboard-header {
  background: linear-gradient(135deg, var(--color-primary) 0%, #005bb5 100%);
  color: white;
  padding: var(--space-3xl) 0;
  margin-bottom: var(--space-2xl);
}

.dashboard-header h1 {
  color: white;
  margin-bottom: var(--space-xs);
}

.dashboard-header p {
  color: rgba(255, 255, 255, 0.9);
}

.dashboard-content {
  padding-bottom: var(--space-3xl);
}

.dashboard-grid {
  display: flex;
  flex-direction: column;
  gap: var(--space-2xl);
}

.stats-section h2,
.section-header h2 {
  font-size: var(--font-size-2xl);
  margin-bottom: var(--space-lg);
}

.stats-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: var(--space-lg);
}

.stat-card {
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-xl);
  padding: var(--space-lg);
  display: flex;
  align-items: center;
  gap: var(--space-md);
}

.stat-icon {
  font-size: var(--font-size-3xl);
}

.stat-value {
  font-size: var(--font-size-3xl);
  font-weight: var(--font-weight-bold);
  color: var(--color-text);
}

.stat-label {
  color: var(--color-text-secondary);
  font-size: var(--font-size-sm);
}

.section-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: var(--space-lg);
}

.notes-list {
  display: grid;
  gap: var(--space-lg);
}

.note-card {
  background: var(--color-surface);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-xl);
  padding: var(--space-lg);
}

.note-header {
  display: flex;
  justify-content: space-between;
  align-items: start;
  margin-bottom: var(--space-sm);
}

.note-header h3 {
  font-size: var(--font-size-lg);
  margin: 0;
}

.note-category {
  background: var(--color-primary);
  color: white;
  padding: var(--space-2xs) var(--space-sm);
  border-radius: var(--radius-full);
  font-size: var(--font-size-xs);
  font-weight: var(--font-weight-medium);
}

.note-content {
  color: var(--color-text-secondary);
  margin-bottom: var(--space-md);
  line-height: 1.6;
}

.note-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-top: var(--space-md);
  border-top: 1px solid var(--color-border);
}

.note-date {
  font-size: var(--font-size-sm);
  color: var(--color-text-secondary);
}

.note-actions {
  display: flex;
  gap: var(--space-sm);
}

.btn-icon {
  background: none;
  border: none;
  font-size: var(--font-size-lg);
  cursor: pointer;
  padding: var(--space-xs);
  border-radius: var(--radius-md);
  transition: background 0.2s;
}

.btn-icon:hover {
  background: var(--color-border);
}

.empty-state {
  text-align: center;
  padding: var(--space-3xl);
  color: var(--color-text-secondary);
}

.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
  padding: var(--space-lg);
}

.modal {
  background: var(--color-background);
  border-radius: var(--radius-2xl);
  width: 100%;
  max-width: 600px;
  max-height: 90vh;
  overflow-y: auto;
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: var(--space-xl);
  border-bottom: 1px solid var(--color-border);
}

.modal-header h2 {
  margin: 0;
}

.btn-close {
  background: none;
  border: none;
  font-size: var(--font-size-3xl);
  cursor: pointer;
  color: var(--color-text-secondary);
  width: 32px;
  height: 32px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: var(--radius-md);
  transition: all 0.2s;
}

.btn-close:hover {
  background: var(--color-border);
}

.modal-form {
  padding: var(--space-xl);
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

.form-group input,
.form-group textarea,
.form-group select {
  padding: var(--space-sm) var(--space-md);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-lg);
  font-size: var(--font-size-base);
  font-family: inherit;
  transition: all 0.2s;
  background: var(--color-background);
  color: var(--color-text);
}

.form-group input:focus,
.form-group textarea:focus,
.form-group select:focus {
  outline: none;
  border-color: var(--color-primary);
  box-shadow: 0 0 0 3px rgba(0, 113, 227, 0.1);
}

.modal-actions {
  display: flex;
  gap: var(--space-md);
  justify-content: flex-end;
  padding-top: var(--space-lg);
  border-top: 1px solid var(--color-border);
}

@media (max-width: 768px) {
  .section-header {
    flex-direction: column;
    align-items: flex-start;
    gap: var(--space-md);
  }

  .section-header .btn {
    width: 100%;
  }
}
</style>
