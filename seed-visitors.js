const { PrismaClient } = require('@prisma/client');

const prisma = new PrismaClient();

async function seedVisitorData() {
  // console.log('🌱 Seeding visitor data...');

  // Create sample visitor data for the last 7 days
  const today = new Date();
  const visitors = [];

  for (let i = 6; i >= 0; i--) {
    const date = new Date(today);
    date.setDate(date.getDate() - i);
    
    // Generate 20-80 visitors per day
    const dailyVisitors = Math.floor(Math.random() * 60) + 20;
    
    for (let j = 0; j < dailyVisitors; j++) {
      const visitTime = new Date(date);
      visitTime.setHours(Math.floor(Math.random() * 24));
      visitTime.setMinutes(Math.floor(Math.random() * 60));
      
      const pages = ['/', '/job-listing', '/study-abbroad-list', '/about', '/contact', '/blog'];
      const randomPage = pages[Math.floor(Math.random() * pages.length)];
      
      visitors.push({
        ipAddress: `192.168.1.${Math.floor(Math.random() * 255)}`,
        userAgent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
        page: randomPage,
        referrer: Math.random() > 0.5 ? 'https://google.com' : null,
        createdAt: visitTime
      });
    }
  }

  // Insert all visitor data
  for (const visitor of visitors) {
    await prisma.visitor.create({
      data: visitor
    });
  }

  // console.log(`✅ Created ${visitors.length} visitor records`);
  // console.log('🎉 Visitor data seeding completed!');
}

seedVisitorData()
  .catch((e) => {
    console.error('❌ Error seeding visitor data:', e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });