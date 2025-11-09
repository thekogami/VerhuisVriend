# VerhuisVriend - Guia de Instalação

## 🚀 Frontend Vue.js - Setup Completo

### ⚠️ Importante: Versão do Node.js

O projeto requer **Node.js versão 22.12+** ou **20.19+**. Sua versão atual é 22.9.0.

### Opção 1: Atualizar Node.js (Recomendado)

#### Usando nvm (Node Version Manager):

```bash
# Instalar nvm se ainda não tiver
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# Instalar Node.js 22.12+
nvm install 22.12.0
nvm use 22.12.0

# Verificar versão
node --version
```

#### Usando Homebrew (macOS):

```bash
brew update
brew upgrade node
```

### Opção 2: Downgrade temporário do Vite

Se não puder atualizar o Node agora, você pode usar uma versão anterior do Vite:

```bash
cd verhuisvriend_front
npm install vite@5 @vitejs/plugin-vue@5 --save-dev
```

---

## 📦 Instalação

### 1. Entre na pasta do frontend

```bash
cd /Users/felipemourao/Desktop/Developer/VerhuisVriend/verhuisvriend_front
```

### 2. Instale as dependências

```bash
npm install
```

### 3. Configure as variáveis de ambiente

O arquivo `.env` já foi criado com:

```
VITE_API_BASE_URL=http://localhost:8080
```

### 4. Inicie o servidor de desenvolvimento

```bash
npm run dev
```

O app estará disponível em: **http://localhost:5173**

---

## 🔧 Estrutura do Projeto

```
verhuisvriend_front/
├── src/
│   ├── assets/
│   │   └── main.css              # Design System (estilo Apple)
│   ├── components/
│   │   ├── AppHeader.vue         # Navegação principal
│   │   └── AppFooter.vue         # Rodapé
│   ├── views/
│   │   ├── HomeView.vue          # Página inicial
│   │   ├── NeighborhoodsView.vue # Lista de bairros
│   │   ├── CompaniesView.vue     # Empresas de mudança
│   │   └── PlanView.vue          # Planejador (em breve)
│   ├── services/
│   │   └── api.ts                # Integração com backend
│   ├── router/
│   │   └── index.ts              # Rotas do Vue Router
│   └── App.vue                    # Componente raiz
├── .env                           # Variáveis de ambiente
└── package.json                   # Dependências
```

---

## 🎨 Design System

### Paleta de Cores (Inspirada na Apple)

- **Primary**: #0071e3 (Apple Blue)
- **Success**: #30d158 (Green)
- **Warning**: #ff9f0a (Orange)
- **Error**: #ff3b30 (Red)
- **Background**: #ffffff / #000000 (Dark mode)

### Tipografia

- **Fonte**: Inter (com fallback para fontes do sistema)
- **Tamanhos**: 12px - 48px (sistema de escala)
- **Pesos**: 300 (Light) - 700 (Bold)

### Espaçamento

Sistema baseado em grade de **8px**:

- xs: 8px
- sm: 16px
- md: 24px
- lg: 32px
- xl: 48px
- 2xl: 64px
- 3xl: 96px

---

## 🌐 Páginas Criadas

### 1. **Home** (`/`)

- Hero section com call-to-action
- Estatísticas do projeto
- Top 6 bairros mais bem avaliados
- Showcase de funcionalidades
- CTA para começar

### 2. **Neighborhoods** (`/neighborhoods`)

- Lista completa de bairros
- Filtros por:
  - Cidade
  - Preço máximo de aluguel
- Cards com:
  - Rating de estudantes
  - Preço médio
  - Distância de universidades
  - Tags (student-friendly, etc.)

### 3. **Companies** (`/companies`)

- Diretório de empresas de mudança
- Informações de contato
- Avaliações
- Áreas de serviço
- Idiomas falados

### 4. **Plan Move** (`/plan`)

- Página "Coming Soon"
- Preview de funcionalidades futuras

---

## 🔌 Integração com Backend

### API Endpoints Utilizados

#### Neighborhoods:

```typescript
GET /neighborhoods              // Listar todos
GET /neighborhoods/top-rated    // Top avaliados
GET /neighborhoods/by-city/:city // Por cidade
GET /neighborhoods/affordable   // Por preço
```

#### Companies:

```typescript
GET / companies // Listar todas
GET / companies / top - rated // Top avaliadas
```

### Exemplo de uso:

```typescript
import { neighborhoodApi } from '@/services/api'

// Buscar top bairros
const response = await neighborhoodApi.getTopRated(6)
const neighborhoods = response.data
```

---

## 🚀 Comandos Disponíveis

```bash
# Desenvolvimento
npm run dev

# Build para produção
npm run build

# Preview do build
npm run preview

# Linting
npm run lint

# Type checking
npm run type-check
```

---

## ✅ Checklist de Conclusão

- ✅ Design system Apple-style implementado
- ✅ Componentes Header e Footer criados
- ✅ Página Home completa com hero e features
- ✅ Página Neighborhoods com filtros
- ✅ Página Companies com diretório
- ✅ Página Plan (placeholder)
- ✅ Integração completa com API backend
- ✅ Responsivo para mobile, tablet e desktop
- ✅ Dark mode automático
- ✅ Smooth scrolling e transitions
- ✅ TypeScript configurado
- ✅ Vue Router com scroll behavior

---

## 🎯 Próximos Passos

### Para iniciar o desenvolvimento:

1. **Atualize o Node.js para 22.12+**
2. **Inicie o backend Swift:**

   ```bash
   cd /Users/felipemourao/Desktop/Developer/VerhuisVriend
   swift run App serve
   ```

3. **Popule o banco com dados:**

   ```bash
   ./seed_neighborhoods.sh
   ```

4. **Inicie o frontend:**

   ```bash
   cd verhuisvriend_front
   npm run dev
   ```

5. **Abra o navegador:**
   - Frontend: http://localhost:5173
   - Backend: http://localhost:8080

---

## 🎨 Features Implementadas

### Design

- ✨ Minimalista e clean (estilo Jony Ive)
- 🎨 Sistema de cores consistente
- 📱 100% responsivo
- 🌙 Dark mode support
- ⚡ Transições suaves
- 🔤 Tipografia profissional

### Funcionalidades

- 🏠 Home page dinâmica
- 🗺️ Explorador de bairros com filtros
- 🏢 Diretório de empresas
- 📊 Estatísticas em tempo real
- 🔍 Busca e filtragem
- ⭐ Sistema de ratings
- 💰 Filtro por orçamento

---

## 📝 Notas

- O projeto está configurado com **TypeScript** para type safety
- **Pinia** está disponível para state management futuro
- **Axios** configurado com interceptors
- **Vue Router** com lazy loading de rotas
- **ESLint** para code quality

---

## 🤝 Desenvolvido com

- Vue.js 3 + Composition API
- TypeScript
- Vite (super rápido!)
- Design inspirado na Apple
- Muito ❤️

---

**Está tudo pronto para você começar! 🎉**

Apenas atualize o Node.js e execute `npm run dev` na pasta `verhuisvriend_front`.
