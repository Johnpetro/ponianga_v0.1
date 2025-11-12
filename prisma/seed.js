const { PrismaClient } = require('@prisma/client');
const bcrypt = require('bcrypt');

const prisma = new PrismaClient();

async function main() {
  try {
    // Check if admin already exists
    const existingAdmin = await prisma.admin.findUnique({
      where: { email: 'admin@example.com' }
    });

    if (existingAdmin) {
      console.log('✓ Admin user already exists (admin@example.com)');
      return;
    }

    // Hash the password
    const hashedPassword = await bcrypt.hash('admin123', 10);

    // Create the admin user
    const admin = await prisma.admin.create({
      data: {
        full_name: 'Admin User',
        email: 'admin@example.com',
        password: hashedPassword
      }
    });

    console.log('✓ Admin user created successfully!');
    console.log(`  Email: ${admin.email}`);
    console.log(`  Full Name: ${admin.full_name}`);
    console.log(`  ID: ${admin.id}`);
  } catch (error) {
    console.error('✗ Error seeding admin user:', error.message);
    process.exit(1);
  }
}

main()
  .catch(error => {
    console.error(error);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
