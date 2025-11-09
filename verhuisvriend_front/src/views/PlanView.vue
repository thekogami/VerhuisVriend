<template>
  <div class="plan-page">
    <section class="page-header">
      <div class="container">
        <h1>Plan Your Move</h1>
        <p>Organize every detail of your relocation</p>
      </div>
    </section>

    <section class="section">
      <div class="container container-narrow">
        <div class="coming-soon">
          <div class="icon">🚀</div>
          <h2>Coming Soon</h2>
          <p>
            We're building an amazing moving planner to help you organize tasks, set reminders, and
            track your progress. Stay tuned!
          </p>
          <div class="features-preview">
            <div class="feature-item">
              <span class="check">✓</span>
              <span>Smart task management</span>
            </div>
            <div class="feature-item">
              <span class="check">✓</span>
              <span>Moving timeline</span>
            </div>
            <div class="feature-item">
              <span class="check">✓</span>
              <span>Document checklist</span>
            </div>
            <div class="feature-item">
              <span class="check">✓</span>
              <span>Budget tracker</span>
            </div>
          </div>
          <button class="btn btn-primary" @click="$router.push('/')">Back to Home</button>
        </div>
      </div>
    </section>
  </div>
</template>

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

.coming-soon {
  text-align: center;
  padding: var(--space-3xl) 0;
}

.icon {
  font-size: 5rem;
  margin-bottom: var(--space-lg);
}

.coming-soon h2 {
  margin-bottom: var(--space-md);
}

.coming-soon p {
  font-size: var(--font-size-lg);
  color: var(--color-text-soft);
  max-width: 500px;
  margin: 0 auto var(--space-xl);
}

.features-preview {
  display: grid;
  gap: var(--space-md);
  max-width: 400px;
  margin: 0 auto var(--space-xl);
  text-align: left;
}

.feature-item {
  display: flex;
  align-items: center;
  gap: var(--space-md);
  font-size: var(--font-size-lg);
  color: var(--color-text);
}

.check {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 32px;
  height: 32px;
  background: var(--color-primary-soft);
  color: var(--color-primary);
  border-radius: 50%;
  font-weight: var(--font-weight-bold);
}
</style>
