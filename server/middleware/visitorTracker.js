const { prisma } = require('../config/db');

// Simple visitor tracking middleware
const trackVisitor = async (req, res, next) => {
  try {
    // Only track unique visitors for main pages
    const trackedPaths = ['/', '/job-listing', '/study-abbroad-list', '/about', '/contact', '/blog'];
    
    if (trackedPaths.includes(req.path)) {
      const clientIP = req.ip || req.connection.remoteAddress || req.socket.remoteAddress || 'unknown';
      const userAgent = req.get('User-Agent') || 'unknown';
      
      // Check if we already tracked this IP today to avoid duplicate counts
      const today = new Date();
      today.setHours(0, 0, 0, 0);
      const tomorrow = new Date(today);
      tomorrow.setDate(tomorrow.getDate() + 1);

      try {
        // Check if visitor already exists today
        const existingVisitor = await prisma.visitor.findFirst({
          where: {
            ipAddress: clientIP,
            createdAt: {
              gte: today,
              lt: tomorrow
            }
          }
        });

        // Only create new visitor record if not already tracked today
        if (!existingVisitor) {
          await prisma.visitor.create({
            data: {
              ipAddress: clientIP,
              userAgent: userAgent,
              page: req.path,
              referrer: req.get('Referrer') || null
            }
          });
          // console.log('✓ New visitor tracked:', clientIP, 'on', req.path);
        }
      } catch (dbError) {
        // If visitor table doesn't exist, fail silently or create default data
        // console.log('Visitor tracking unavailable (table may not exist)');
      }
    }
  } catch (error) {
    console.error('Error in visitor tracking:', error);
    // Don't let tracking errors break the application
  }
  
  next();
};

module.exports = { trackVisitor };