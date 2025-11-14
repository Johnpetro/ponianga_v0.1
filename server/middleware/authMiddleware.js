/**
 * Authentication Middleware
 * Verifies JWT token from cookies (simple implementation)
 */
const jwt = require('jsonwebtoken');

const JWT_SECRET = process.env.JWT_SECRET || '0621892913';

const verifyAuth = (req, res, next) => {
  try {
    // Get JWT token from cookies
    const token = req.cookies.authToken;

    if (!token) {
      return res.redirect('/login');
    }

    // Verify token
    try {
      const decoded = jwt.verify(token, JWT_SECRET);
      req.admin = decoded; // Store decoded admin info in request
      next();
    } catch (error) {
      if (error.name === 'TokenExpiredError') {
        console.log('Token expired');
        return res.redirect('/admin/login');
      }
      console.error('Token verification error:', error.message);
      return res.redirect('/admin/login');
    }
  } catch (error) {
    console.error('Auth middleware error:', error);
    res.redirect('/login');
  }
};

module.exports = { verifyAuth };
