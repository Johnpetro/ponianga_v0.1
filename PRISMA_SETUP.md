# Prisma Database Setup Guide

## Overview
Your project now uses Prisma ORM with MongoDB for the Admin authentication system.

## Setup Steps

### 1. Install Dependencies
```bash
npm install @prisma/client prisma
```

### 2. Configure Environment Variables
Create a `.env` file in the root directory:

```env
# Database - PostgreSQL
DATABASE_URL="postgresql://username:password@localhost:5432/job_app?schema=public"

# Session
SESSION_SECRET=your_session_secret_key_here

# JWT
JWT_SECRET=your_jwt_secret_key_here
```

**PostgreSQL Connection String Format:**
```
postgresql://[user]:[password]@[host]:[port]/[database]?schema=public
```

**Example with local PostgreSQL:**
```
DATABASE_URL="postgresql://postgres:password@localhost:5432/job_app?schema=public"
```

**Example with remote PostgreSQL (Heroku, AWS RDS, etc):**
```
DATABASE_URL="postgresql://user:password@db.example.com:5432/job_app?schema=public"
```

### 3. Initialize Prisma
The Prisma schema is already created at `/prisma/schema.prisma`

### 4. Generate Prisma Client
```bash
npx prisma generate
```

### 5. Sync Database
```bash
npx prisma db push
```

## Database Schema

### Admin Model
```prisma
model Admin {
  id        Int      @id @default(autoincrement())
  full_name String   @db.VarChar(100)
  email     String   @unique @db.VarChar(100)
  password  String   @db.VarChar(255)
  createdAt DateTime @default(now())

  @@map("admins")
  @@index([email])
}
```

**Columns:**
- `id (PK)`: Unique admin ID (Auto-increment INT)
- `full_name`: Admin name (VARCHAR 100)
- `email`: Admin email (VARCHAR 100, Unique with index)
- `password`: Hashed password (VARCHAR 255)
- `createdAt`: Date created (TIMESTAMP, auto-set to now)

## Usage

### Importing the Service
```javascript
const adminService = require('../services/adminService');
```

### Create Admin
```javascript
const newAdmin = await adminService.createAdmin(
  'John Doe',
  'john@example.com',
  'password123'
);
```

### Get Admin by Email
```javascript
const admin = await adminService.getAdminByEmail('john@example.com');
```

### Get Admin by ID
```javascript
const admin = await adminService.getAdminById(adminId);
```

### Get All Admins
```javascript
const allAdmins = await adminService.getAllAdmins();
```

### Update Admin
```javascript
const updated = await adminService.updateAdmin(adminId, {
  full_name: 'Jane Doe',
  email: 'jane@example.com'
});
```

### Delete Admin
```javascript
const deleted = await adminService.deleteAdmin(adminId);
```

### Verify Password
```javascript
const isValid = await adminService.verifyPassword(plainPassword, hashedPassword);
```

## Database Connection

The database is configured in `/server/config/db.js`:

```javascript
const { connectDB, prisma } = require('./server/config/db');

// Connect to database
await connectDB();

// Use prisma in your routes
const { prisma } = require('./server/config/db');
```

## Prisma Commands

| Command | Description |
|---------|-------------|
| `npx prisma generate` | Generate Prisma Client |
| `npx prisma db push` | Sync schema with database |
| `npx prisma studio` | Open Prisma Studio GUI |
| `npx prisma migrate dev --name migration_name` | Create a migration |
| `npx prisma db seed` | Run seed script |

## Files Created/Modified

- ✅ `/prisma/schema.prisma` - Prisma schema definition
- ✅ `/server/config/db.js` - Updated database config
- ✅ `/server/services/adminService.js` - Admin service with CRUD operations
- 📝 `/app.js` - Need to initialize DB connection
- 📝 `/server/routes/admin.js` - Need to update routes to use Prisma

## Next Steps

1. Update `app.js` to initialize database connection:
   ```javascript
   const { connectDB } = require('./server/config/db');
   await connectDB();
   ```

2. Update admin routes to use the new adminService

3. Test the authentication flow with Prisma

## Troubleshooting

**Issue:** `DATABASE_URL not found`
- Solution: Ensure `.env` file exists with `DATABASE_URL` set

**Issue:** Prisma Client not found
- Solution: Run `npx prisma generate`

**Issue:** Collection doesn't exist
- Solution: Run `npx prisma db push`
