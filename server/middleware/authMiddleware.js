/**
 * Authentication Middleware
 * Checks if user is authenticated via JWT token in session
 */
const verifyAuth = (req, res, next) => {
  try {
    const token = req.session.token;
    const adminId = req.session.adminId;

    if (!token || !adminId) {
      return res.redirect('/login');
    }

    // Token is valid if it exists in session
    next();
  } catch (error) {
    console.error('Auth middleware error:', error);
    res.redirect('/login');
  }
};

module.exports = { verifyAuth };
