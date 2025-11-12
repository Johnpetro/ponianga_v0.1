const express = require('express');
const router = express.Router();
// const Post = require('../models/Post');
// const User = require('../models/User');
const { connectDB, prisma } = require('../config/db');
const adminService = require('../services/adminService');
const { verifyAuth } = require('../middleware/authMiddleware');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

const adminLayout = '../views/layouts/admin';
const jwtSecret = process.env.JWT_SECRET;


/**
 * GET /admin/login
 * Admin - Login Page
*/
router.get('/login', async (req, res) => {
  console.log('Accessed /admin/login route');
  try {
    const locals = {
      title: "Login",
      description: "login"
    }

    res.render('admin/login', { locals , layout: adminLayout });
  } catch (error) {
    console.log(error);
    res.status(500).send('Error loading login page');
  }
});


/**
 * POST /admin/login
 * Admin - Check Login
*/
router.post('/login', async (req, res) => {
  try {
    const { email, password } = req.body;

    // Basic validation
    if (!email || !password) {
      return res.render('admin/login', {
        locals: {
          title: "Login",
          description: "Admin login page"
        },
        layout: adminLayout,
        errorMessage: 'Email and password are required.'
      });
    }

    // Get admin from database
    const admin = await adminService.getAdminByEmail(email);

    if (!admin) {
      return res.render('admin/login', {
        locals: {
          title: "Login",
          description: "Admin login page"
        },
        layout: adminLayout,
        errorMessage: 'Invalid email or password.'
      });
    }

    // Verify password
    const isPasswordValid = await adminService.verifyPassword(password, admin.password);

    if (!isPasswordValid) {
      return res.render('admin/login', {
        locals: {
          title: "Login",
          description: "Admin login page"
        },
        layout: adminLayout,
        errorMessage: 'Invalid email or password.'
      });
    }

    // Create JWT token
    const token = jwt.sign({ id: admin.id, email: admin.email }, jwtSecret, { expiresIn: '7d' });

    // Store token in session
    req.session.token = token;
    req.session.adminId = admin.id;
    req.session.adminEmail = admin.email;

    console.log('✓ Admin logged in successfully:', email);

    // Redirect to dashboard
    res.redirect('/dashboard');

  } catch (error) {
    console.log(error);
    res.render('admin/login', {
      locals: {
        title: "Login",
        description: "Admin login page"
      },
      layout: adminLayout,
      errorMessage: 'An error occurred. Please try again.'
    });
  }
});


/**
 * GET /admin
 * Admin - Dashboard (redirect to login if not authenticated)
*/
router.get('/admin', async (req, res) => {
  try {
    // Redirect to login page
    res.redirect('admin/index');
  } catch (error) {
    console.log(error);
  }
});


/**
 * GET /admin/index
 * Admin - Dashboard Index
*/
router.get('/index', async (req, res) => {
  try {
    const locals = {
      title: "Admin",
      description: "Simple Blog created with NodeJs, Express & MongoDb."
    }

    res.render('admin/index', { locals, layout: adminLayout });
  } catch (error) {
    console.log(error);
  }
});


/**
 * GET /admin/dashboard
 * Admin - Dashboard
*/
router.get('/dashboard', verifyAuth, async (req, res) => {
  try {
    const locals = {
      title: 'Dashboard',
      description: 'Simple Blog created with NodeJs, Express & MongoDb.'
    }

    // TODO: Fetch posts from database
    // const data = await Post.find();
    const data = [];

    res.render('admin/dashboard', {
      locals,
      data,
      layout: adminLayout
    });

  } catch (error) {
    console.log(error);
    res.status(500).send('Error loading dashboard');
  }
});



/**
 * GET /admin/logout
 * Admin Logout
*/
router.get('/logout', (req, res) => {
  req.session.destroy((err) => {
    if (err) {
      console.error('Error destroying session:', err);
      return res.status(500).send('Error logging out');
    }
    res.clearCookie('connect.sid');
    console.log('✓ Admin logged out successfully');
    res.redirect('/login');
  });
});


module.exports = router;