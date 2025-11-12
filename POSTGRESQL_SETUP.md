# PostgreSQL Setup Guide

## Installation

### 1. Install PostgreSQL
- **Windows**: Download from [postgresql.org](https://www.postgresql.org/download/windows/)
- **Mac**: `brew install postgresql`
- **Linux**: `sudo apt-get install postgresql postgresql-contrib`

### 2. Start PostgreSQL Service
```bash
# Windows
net start postgresql-x64-15

# Mac
brew services start postgresql

# Linux
sudo service postgresql start
```

### 3. Create Database
```bash
# Connect to PostgreSQL
psql -U postgres

# Create database
CREATE DATABASE job_app;

# List databases
\l

# Exit
\q
```

## Setup Prisma with PostgreSQL

### 1. Set DATABASE_URL in .env
```bash
cp .env.example .env
```

Edit `.env` and set your PostgreSQL connection:
```env
DATABASE_URL="postgresql://postgres:your_password@localhost:5432/job_app?schema=public"
```

### 2. Install Dependencies
```bash
npm install @prisma/client prisma
```

### 3. Generate Prisma Client
```bash
npx prisma generate
```

### 4. Push Schema to Database
```bash
npx prisma db push
```

This will:
- Create the `admins` table
- Set up indexes
- Configure primary key and unique constraints

### 5. Verify Database
```bash
# Open Prisma Studio
npx prisma studio

# Or check with psql
psql -U postgres -d job_app -c "\dt"
```

## Verify Installation

```bash
# Check if table was created
psql -U postgres -d job_app -c "SELECT * FROM admins;"

# Should return empty table with columns:
# id | full_name | email | password | createdAt
```

## Using the Admin Service

```javascript
const adminService = require('./server/services/adminService');

// Create an admin
const admin = await adminService.createAdmin(
  'John Doe',
  'john@example.com',
  'secure_password_123'
);

// Get admin by email
const user = await adminService.getAdminByEmail('john@example.com');

// Verify password
const isValid = await adminService.verifyPassword('secure_password_123', user.password);
```

## Common Commands

```bash
# View database schema
npx prisma studio

# Sync schema with database
npx prisma db push

# Generate Prisma Client after schema changes
npx prisma generate

# Create a migration
npx prisma migrate dev --name add_field_name

# View migrations
npx prisma migrate status

# Reset database (⚠️ deletes all data)
npx prisma migrate reset
```

## PostgreSQL Connection Issues

### Issue: Connection refused
**Solution:** Ensure PostgreSQL service is running
```bash
# Check status
psql -U postgres -h localhost -d postgres -c "SELECT 1;"
```

### Issue: Database does not exist
**Solution:** Create the database first
```bash
psql -U postgres -c "CREATE DATABASE job_app;"
```

### Issue: Authentication failed
**Solution:** Check username and password in DATABASE_URL
```bash
# Test connection
psql -U postgres -h localhost -d job_app
```

## Database Backup/Restore

```bash
# Backup database
pg_dump -U postgres job_app > backup.sql

# Restore database
psql -U postgres job_app < backup.sql
```

## Next Steps

1. ✅ PostgreSQL installed and running
2. ✅ Database created
3. ✅ Prisma schema configured
4. ✅ Tables created with `npx prisma db push`
5. 📝 Update routes to use adminService
6. 📝 Test authentication flow
