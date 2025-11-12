const { PrismaClient } = require('@prisma/client');

const prisma = new PrismaClient();

const connectDB = async () => {
  try {
    // Test the connection
    await prisma.$connect();
    console.log('✓ Database connected successfully with Prisma');
  } catch (error) {
    console.error('✗ Database connection error:', error.message);
    process.exit(1);
  }
};

module.exports = { connectDB, prisma };
