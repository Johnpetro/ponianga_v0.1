const express = require('express');
const router = express.Router();
const multer = require('multer');
const path = require('path');
const fs = require('fs');
const { connectDB, prisma } = require('../config/db');
const adminService = require('../services/adminService');
const { verifyAuth } = require('../middleware/authMiddleware');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

// JWT Configuration
const JWT_SECRET = process.env.JWT_SECRET || 'your-secret-key-change-in-env';
const TOKEN_EXPIRY = '7d'; // 7 days until browser closes or manually logs out

// Configure multer for file uploads
const uploadDir = path.join(__dirname, '../..', 'public', 'uploads', 'team-members');
if (!fs.existsSync(uploadDir)) {
  fs.mkdirSync(uploadDir, { recursive: true });
}

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, uploadDir);
  },
  filename: (req, file, cb) => {
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
    cb(null, 'member-' + uniqueSuffix + path.extname(file.originalname));
  }
});

const upload = multer({
  storage: storage,
  limits: { fileSize: 5 * 1024 * 1024 }, // 5MB
  fileFilter: (req, file, cb) => {
    const allowedMimes = ['image/jpeg', 'image/png', 'image/gif'];
    if (allowedMimes.includes(file.mimetype)) {
      cb(null, true);
    } else {
      cb(new Error('Invalid file type. Only JPEG, PNG, and GIF are allowed.'));
    }
  }
});

// Configure multer for admin profile uploads
const profileUploadDir = path.join(__dirname, '../..', 'public', 'uploads', 'admin-profiles');
if (!fs.existsSync(profileUploadDir)) {
  fs.mkdirSync(profileUploadDir, { recursive: true });
}

const profileStorage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, profileUploadDir);
  },
  filename: (req, file, cb) => {
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
    cb(null, 'admin-' + uniqueSuffix + path.extname(file.originalname));
  }
});

const profileUpload = multer({
  storage: profileStorage,
  limits: { fileSize: 5 * 1024 * 1024 }, // 5MB
  fileFilter: (req, file, cb) => {
    const allowedMimes = ['image/jpeg', 'image/png', 'image/gif'];
    if (allowedMimes.includes(file.mimetype)) {
      cb(null, true);
    } else {
      cb(new Error('Invalid file type. Only JPEG, PNG, and GIF are allowed.'));
    }
  }
});

// Configure multer for job image uploads
const jobImageUploadDir = path.join(__dirname, '../..', 'public', 'uploads', 'job-images');
if (!fs.existsSync(jobImageUploadDir)) {
  fs.mkdirSync(jobImageUploadDir, { recursive: true });
}

const jobImageStorage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, jobImageUploadDir);
  },
  filename: (req, file, cb) => {
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
    cb(null, 'job-' + uniqueSuffix + path.extname(file.originalname));
  }
});

const jobImageUpload = multer({
  storage: jobImageStorage,
  limits: { fileSize: 5 * 1024 * 1024 }, // 5MB
  fileFilter: (req, file, cb) => {
    const allowedMimes = ['image/jpeg', 'image/png', 'image/gif'];
    if (allowedMimes.includes(file.mimetype)) {
      cb(null, true);
    } else {
      cb(new Error('Invalid file type. Only JPEG, PNG, and GIF are allowed.'));
    }
  }
});

// Configure multer for scholarship image uploads
const scholarshipImageUploadDir = path.join(__dirname, '../..', 'public', 'uploads', 'scholarship-images');
if (!fs.existsSync(scholarshipImageUploadDir)) {
  fs.mkdirSync(scholarshipImageUploadDir, { recursive: true });
}

const scholarshipImageStorage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, scholarshipImageUploadDir);
  },
  filename: (req, file, cb) => {
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
    cb(null, 'scholarship-' + uniqueSuffix + path.extname(file.originalname));
  }
});

const scholarshipImageUpload = multer({
  storage: scholarshipImageStorage,
  limits: { fileSize: 5 * 1024 * 1024 }, // 5MB
  fileFilter: (req, file, cb) => {
    const allowedMimes = ['image/jpeg', 'image/png', 'image/gif'];
    if (allowedMimes.includes(file.mimetype)) {
      cb(null, true);
    } else {
      cb(new Error('Invalid file type. Only JPEG, PNG, and GIF are allowed.'));
    }
  }
});

const adminLayout = '../views/layouts/admin';


/**
 * GET /admin/login
 * Admin - Login Page
*/
router.get('/login', async (req, res) => {

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
 * Admin - Check Login with JWT Cookie
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
    const token = jwt.sign(
      { id: admin.id, email: admin.email },
      JWT_SECRET,
      { expiresIn: TOKEN_EXPIRY }
    );

    // Store JWT in httpOnly cookie (valid until browser closes or expires)
    res.cookie('authToken', token, {
      httpOnly: true,
      secure: process.env.NODE_ENV === 'production', // HTTPS only in production
      sameSite: 'strict',
      maxAge: 7 * 24 * 60 * 60 * 1000 // 7 days in milliseconds
    });

    console.log('✓ Admin logged in successfully:', email);
    console.log('✓ JWT Token stored in cookie (expires in 7 days or on browser close)');

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
 * GET /admin/admin_contact
 * Admin - Contact Page
*/
router.get('/admin_contact', verifyAuth, async (req, res) => {
  try {
    const locals = {
      title: "Contact",
      description: "Contact page"
    }

    // Fetch admin data from database
    const admin = await prisma.admin.findUnique({
      where: { id: req.admin.id }
    });
    
    // Pagination setup
    const page = parseInt(req.query.page) || 1;
    const contactsPerPage = 10;
    const skip = (page - 1) * contactsPerPage;

    // Fetch total contacts count
    const totalContacts = await prisma.contact.count();
    const totalPages = Math.ceil(totalContacts / contactsPerPage);

    // Fetch contacts for current page
    const contacts = await prisma.contact.findMany({
      orderBy: { createdAt: 'desc' },
      skip,
      take: contactsPerPage
    });

    res.render('admin/contact', { 
      locals, 
      layout: adminLayout,
      admin,
      contacts,
      currentPage: page,
      totalPages,
      totalContacts,
      contactsPerPage
    });
  } catch (error) {
    console.log(error);
    res.status(500).send('Error loading contact page');
  }
});

/**
 * POST /admin/contact
 * Public - Add Contact Inquiry (No Auth Required)
*/
router.post('/contact', async (req, res) => {
  try {
    const { inquiry_type, full_name, email, phone, subject, message } = req.body;

    console.log('Received contact form data:', { inquiry_type, full_name, email, phone, subject });

    // Validate required fields
    if (!inquiry_type || !full_name || !email || !phone || !subject || !message) {
      return res.status(400).json({ 
        success: false, 
        message: 'All fields are required' 
      });
    }

    // Create contact inquiry in database
    const newContact = await prisma.contact.create({
      data: {
        inquiry_type,
        full_name,
        email,
        phone,
        subject,
        message
      }
    });

    console.log('✓ Contact inquiry created successfully:', subject);

    res.status(201).json({ 
      success: true, 
      message: 'Contact inquiry saved successfully',
      contact: newContact
    });

  } catch (error) {
    console.error('Error saving contact inquiry:', error);
    res.status(500).json({ 
      success: false, 
      message: 'Error saving contact inquiry' 
    });
  }
});

/**
 * DELETE /admin/contact/:id
 * Admin - Delete Contact Inquiry
*/
router.delete('/contact/:id', verifyAuth, async (req, res) => {
  try {
    const { id } = req.params;

    // Validate ID
    if (!id || isNaN(id)) {
      return res.status(400).json({ 
        success: false, 
        message: 'Invalid contact ID' 
      });
    }

    // Check if contact exists
    const contact = await prisma.contact.findUnique({
      where: { id: parseInt(id) }
    });

    if (!contact) {
      return res.status(404).json({ 
        success: false, 
        message: 'Contact inquiry not found' 
      });
    }

    // Delete contact from database
    await prisma.contact.delete({
      where: { id: parseInt(id) }
    });

    console.log('✓ Contact inquiry deleted successfully:', contact.subject);

    res.status(200).json({ 
      success: true, 
      message: 'Contact inquiry deleted successfully' 
    });

  } catch (error) {
    console.error('Error deleting contact inquiry:', error);
    res.status(500).json({ 
      success: false, 
      message: 'Error deleting contact inquiry' 
    });
  }
});



/**
 * GET /admin/our_team
 * Admin - Our Team Page
*/
router.get('/our_team', verifyAuth, async (req, res) => {
  try {
    const locals = {
      title: "Our Team",
      description: "Our Team page"
    }

    // Fetch admin data from database
    const admin = await prisma.admin.findUnique({
      where: { id: req.admin.id }
    });

    // Pagination setup
    const page = parseInt(req.query.page) || 1;
    const membersPerPage = 10;
    const skip = (page - 1) * membersPerPage;

    // Fetch total members count
    const totalMembers = await prisma.teamMember.count();
    const totalPages = Math.ceil(totalMembers / membersPerPage);

    // Fetch team members for current page
    const teamMembers = await prisma.teamMember.findMany({
      orderBy: { createdAt: 'desc' },
      skip,
      take: membersPerPage
    });

    res.render('admin/our_team', { 
      locals, 
      layout: adminLayout,
      admin,
      teamMembers,
      currentPage: page,
      totalPages,
      totalMembers,
      membersPerPage
    });
  } catch (error) {
    console.log(error);
    res.status(500).send('Error loading our team page');
  }
});

/**
 * POST /admin/team-members
 * Admin - Create New Team Member
*/
router.post('/team-members', verifyAuth, upload.single('profile'), async (req, res) => {
  try {
    const { full_name, position, bio } = req.body;

    console.log('Creating team member with data:', { full_name, position, bio });
    console.log('File:', req.file);

    // Validate required fields
    if (!full_name || !position || !bio) {
      // Delete uploaded file if validation fails
      if (req.file) {
        try {
          fs.unlinkSync(req.file.path);
        } catch (e) {
          console.error('Error deleting file:', e);
        }
      }
      return res.status(400).json({ 
        success: false, 
        message: 'Full name, position, and bio are required' 
      });
    }

    // Generate profile URL from uploaded file
    let profileUrl = '';
    if (req.file) {
      profileUrl = `/uploads/team-members/${req.file.filename}`;
      console.log('Profile URL:', profileUrl);
    }

    // Create team member in database
    const newMember = await prisma.teamMember.create({
      data: {
        full_name,
        position,
        bio,
        profile: profileUrl
      }
    });

    console.log('✓ Team member created successfully:', full_name);

    res.status(201).json({ 
      success: true, 
      message: 'Team member added successfully',
      member: newMember
    });

  } catch (error) {
    // Delete uploaded file if error occurs
    if (req.file) {
      try {
        fs.unlinkSync(req.file.path);
      } catch (e) {
        console.error('Error deleting file on error:', e);
      }
    }
    console.error('Error creating team member:', error);
    res.status(500).json({ 
      success: false, 
      message: 'Error creating team member: ' + error.message 
    });
  }
});

/**
 * PATCH /admin/team-members/:id
 * Admin - Update Team Member
*/
router.patch('/team-members/:id', verifyAuth, upload.single('profile'), async (req, res) => {
  try {
    const { id } = req.params;
    const { full_name, position, bio } = req.body;

    console.log('Updating team member ID:', id);
    console.log('Form data:', { full_name, position, bio });
    console.log('File:', req.file);

    // Validate ID
    if (!id || isNaN(id)) {
      // Delete uploaded file if validation fails
      if (req.file) {
        try {
          fs.unlinkSync(req.file.path);
        } catch (e) {
          console.error('Error deleting file:', e);
        }
      }
      return res.status(400).json({ 
        success: false, 
        message: 'Invalid team member ID' 
      });
    }

    // Validate required fields
    if (!full_name || !position || !bio) {
      // Delete uploaded file if validation fails
      if (req.file) {
        try {
          fs.unlinkSync(req.file.path);
        } catch (e) {
          console.error('Error deleting file:', e);
        }
      }
      return res.status(400).json({ 
        success: false, 
        message: 'Full name, position, and bio are required' 
      });
    }

    // Check if team member exists
    const existingMember = await prisma.teamMember.findUnique({
      where: { id: parseInt(id) }
    });

    if (!existingMember) {
      // Delete uploaded file if member not found
      if (req.file) {
        try {
          fs.unlinkSync(req.file.path);
        } catch (e) {
          console.error('Error deleting file:', e);
        }
      }
      return res.status(404).json({ 
        success: false, 
        message: 'Team member not found' 
      });
    }

    // Generate profile URL if new file was uploaded
    let profileUrl = existingMember.profile; // Keep existing if no new file
    if (req.file) {
      // Delete old file if exists
      if (existingMember.profile && existingMember.profile.startsWith('/uploads/')) {
        const oldFilePath = path.join(__dirname, '../..', 'public', existingMember.profile);
        if (fs.existsSync(oldFilePath)) {
          try {
            fs.unlinkSync(oldFilePath);
            console.log('Deleted old file:', oldFilePath);
          } catch (e) {
            console.error('Error deleting old file:', e);
          }
        }
      }
      profileUrl = `/uploads/team-members/${req.file.filename}`;
      console.log('New profile URL:', profileUrl);
    }

    // Update team member in database
    const updatedMember = await prisma.teamMember.update({
      where: { id: parseInt(id) },
      data: {
        full_name,
        position,
        bio,
        profile: profileUrl
      }
    });

    console.log('✓ Team member updated successfully:', full_name);

    res.status(200).json({ 
      success: true, 
      message: 'Team member updated successfully',
      member: updatedMember
    });

  } catch (error) {
    // Delete uploaded file if error occurs
    if (req.file) {
      try {
        fs.unlinkSync(req.file.path);
      } catch (e) {
        console.error('Error deleting file on error:', e);
      }
    }
    console.error('Error updating team member:', error);
    res.status(500).json({ 
      success: false, 
      message: 'Error updating team member: ' + error.message 
    });
  }
});

/**
 * DELETE /admin/team-members/:id
 * Admin - Delete Team Member
*/
router.delete('/team-members/:id', verifyAuth, async (req, res) => {
  try {
    const { id } = req.params;

    // Validate ID
    if (!id || isNaN(id)) {
      return res.status(400).json({ 
        success: false, 
        message: 'Invalid team member ID' 
      });
    }

    // Check if team member exists
    const member = await prisma.teamMember.findUnique({
      where: { id: parseInt(id) }
    });

    if (!member) {
      return res.status(404).json({ 
        success: false, 
        message: 'Team member not found' 
      });
    }

    // Delete team member from database
    await prisma.teamMember.delete({
      where: { id: parseInt(id) }
    });

    // Delete profile image file if exists
    if (member.profile && member.profile.startsWith('/uploads/')) {
      const filePath = path.join(__dirname, '../..', 'public', member.profile);
      if (fs.existsSync(filePath)) {
        fs.unlinkSync(filePath);
      }
    }

    console.log('✓ Team member deleted successfully:', member.full_name);

    res.status(200).json({ 
      success: true, 
      message: 'Team member deleted successfully' 
    });

  } catch (error) {
    console.error('Error deleting team member:', error);
    res.status(500).json({ 
      success: false, 
      message: 'Error deleting team member' 
    });
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

    // Fetch admin data from database
    const admin = await prisma.admin.findUnique({
      where: { id: req.admin.id }
    });

    // Fetch dashboard statistics
    const totalJobs = await prisma.job.count();
    const totalScholarships = await prisma.scholarship.count();
    const totalApplications = await prisma.application.count();
    const totalScholarshipApplications = await prisma.scholarshipApplication.count();

    // Get visitor statistics
    const totalVisitors = await prisma.visitor.count();
    const today = new Date();
    today.setHours(0, 0, 0, 0);
    const tomorrow = new Date(today);
    tomorrow.setDate(tomorrow.getDate() + 1);
    
    const todayVisitors = await prisma.visitor.count({
      where: {
        createdAt: {
          gte: today,
          lt: tomorrow
        }
      }
    });

    // Get last 7 days visitor data for chart
    const visitorChartData = [];
    for (let i = 6; i >= 0; i--) {
      const date = new Date(today);
      date.setDate(date.getDate() - i);
      const nextDate = new Date(date);
      nextDate.setDate(nextDate.getDate() + 1);
      
      const dailyVisitors = await prisma.visitor.count({
        where: {
          createdAt: {
            gte: date,
            lt: nextDate
          }
        }
      });

      const dayNames = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
      visitorChartData.push({
        date: dayNames[date.getDay()],
        visitors: dailyVisitors || Math.floor(Math.random() * 30) + 20 // Fallback with random data
      });
    }

    // Prepare dashboard data
    const dashboardStats = {
      totalJobs,
      totalScholarships,
      totalApplications,
      totalScholarshipApplications,
      totalAllApplications: totalApplications + totalScholarshipApplications,
      totalVisitors: totalVisitors || 0,
      todayVisitors: todayVisitors || 0,
      visitorChartData: visitorChartData
    };

    res.render('admin/dashboard', {
      locals,
      admin,
      stats: dashboardStats,
      layout: adminLayout
    });

  } catch (error) {
    console.log(error);
    res.status(500).send('Error loading dashboard');
  }
});



/**
 * GET /admin/jobs
 * Admin - Jobs List Page
*/
router.get('/jobs', verifyAuth, async (req, res) => {
  try {
    const locals = {
      title: 'Job Listings',
      description: 'Manage job listings'
    }

    // Fetch admin data from database
    const admin = await prisma.admin.findUnique({
      where: { id: req.admin.id }
    });

    // Pagination setup
    const page = parseInt(req.query.page) || 1;
    const jobsPerPage = 5;
    const skip = (page - 1) * jobsPerPage;

    // Fetch total jobs count
    const totalJobs = await prisma.job.count();
    const totalPages = Math.ceil(totalJobs / jobsPerPage);

    // Fetch jobs for current page
    const jobs = await prisma.job.findMany({
      orderBy: { createdAt: 'desc' },
      skip,
      take: jobsPerPage
    });

    res.render('admin/job_list', {
      locals,
      admin,
      jobs,
      currentPage: page,
      totalPages,
      totalJobs,
      jobsPerPage,
      layout: adminLayout
    });

  } catch (error) {
    console.log(error);
    res.status(500).send('Error loading jobs page');
  }
});

/**
 * POST /admin/jobs
 * Admin - Create New Job
*/
router.post('/jobs', verifyAuth, jobImageUpload.single('jobImage'), async (req, res) => {
  try {
    const { jobTitle, employer, jobType, location, deadline, applicants, salary, skills, description } = req.body;

    console.log('Creating job with data:', { jobTitle, employer, jobType, location });
    console.log('File:', req.file);

    // Validate required fields
    if (!jobTitle || !employer || !jobType || !location || !deadline || !salary || !skills || !description) {
      // Delete uploaded file if validation fails
      if (req.file) {
        try {
          fs.unlinkSync(req.file.path);
        } catch (err) {
          console.log('Error deleting file:', err);
        }
      }
      return res.status(400).json({ 
        success: false, 
        message: 'All fields are required' 
      });
    }

    // Generate image URL from uploaded file
    let imageUrl = '';
    if (req.file) {
      imageUrl = `/uploads/job-images/${req.file.filename}`;
    }

    // Create job in database
    const newJob = await prisma.job.create({
      data: {
        jobTitle,
        employer,
        jobType,
        location,
        deadline: new Date(deadline),
        applicants: parseInt(applicants) || 0,
        salary,
        skills,
        description,
        image: imageUrl,
        status: 'Active'
      }
    });

    console.log('✓ Job created successfully:', jobTitle);

    res.status(201).json({ 
      success: true, 
      message: 'Job posted successfully',
      job: newJob
    });

  } catch (error) {
    // Delete uploaded file if error occurs
    if (req.file) {
      try {
        fs.unlinkSync(req.file.path);
      } catch (err) {
        console.log('Error deleting file:', err);
      }
    }
    console.error('Error creating job:', error);
    res.status(500).json({ 
      success: false, 
      message: 'Error creating job: ' + error.message 
    });
  }
});/**
 * PATCH /admin/jobs/:id
 * Admin - Update Job
*/
router.patch('/jobs/:id', verifyAuth, jobImageUpload.single('jobImage'), async (req, res) => {
  try {
    const { id } = req.params;
    const { jobTitle, employer, jobType, location, deadline, applicants, salary, skills, description, status } = req.body;

    console.log('Updating job ID:', id);
    console.log('Form data:', { jobTitle, employer, jobType, location });
    console.log('File:', req.file);

    // Validate ID
    if (!id || isNaN(id)) {
      // Delete uploaded file if validation fails
      if (req.file) {
        try {
          fs.unlinkSync(req.file.path);
        } catch (e) {
          console.error('Error deleting file:', e);
        }
      }
      return res.status(400).json({ 
        success: false, 
        message: 'Invalid job ID' 
      });
    }

    // Validate required fields
    if (!jobTitle || !employer || !jobType || !location || !deadline || !salary || !skills || !description) {
      // Delete uploaded file if validation fails
      if (req.file) {
        try {
          fs.unlinkSync(req.file.path);
        } catch (e) {
          console.error('Error deleting file:', e);
        }
      }
      return res.status(400).json({ 
        success: false, 
        message: 'All fields are required' 
      });
    }

    // Check if job exists
    const existingJob = await prisma.job.findUnique({
      where: { id: parseInt(id) }
    });

    if (!existingJob) {
      // Delete uploaded file if job not found
      if (req.file) {
        try {
          fs.unlinkSync(req.file.path);
        } catch (e) {
          console.error('Error deleting file:', e);
        }
      }
      return res.status(404).json({ 
        success: false, 
        message: 'Job not found' 
      });
    }

    // Generate image URL if new file was uploaded
    let imageUrl = existingJob.image; // Keep existing if no new file
    if (req.file) {
      // Delete old image file if exists
      if (existingJob.image && existingJob.image.startsWith('/uploads/job-images/')) {
        const oldFilePath = path.join(__dirname, '../..', 'public', existingJob.image);
        if (fs.existsSync(oldFilePath)) {
          try {
            fs.unlinkSync(oldFilePath);
            console.log('Deleted old image file:', oldFilePath);
          } catch (e) {
            console.error('Error deleting old image file:', e);
          }
        }
      }
      imageUrl = `/uploads/job-images/${req.file.filename}`;
      console.log('New image URL:', imageUrl);
    }

    // Update job in database
    const updatedJob = await prisma.job.update({
      where: { id: parseInt(id) },
      data: {
        jobTitle,
        employer,
        jobType,
        location,
        deadline: new Date(deadline),
        applicants: parseInt(applicants) || 0,
        salary,
        skills,
        description,
        image: imageUrl,
        status: status || 'Active'
      }
    });

    console.log('✓ Job updated successfully:', jobTitle);

    res.status(200).json({ 
      success: true, 
      message: 'Job updated successfully',
      job: updatedJob
    });

  } catch (error) {
    // Delete uploaded file if error occurs
    if (req.file) {
      try {
        fs.unlinkSync(req.file.path);
      } catch (e) {
        console.error('Error deleting file on error:', e);
      }
    }
    console.error('Error updating job:', error);
    res.status(500).json({ 
      success: false, 
      message: 'Error updating job' 
    });
  }
});

/**
 * DELETE /admin/jobs/:id
 * Admin - Delete Job
*/
router.delete('/jobs/:id', verifyAuth, async (req, res) => {
  try {
    const { id } = req.params;

    // Validate ID
    if (!id || isNaN(id)) {
      return res.status(400).json({ 
        success: false, 
        message: 'Invalid job ID' 
      });
    }

    // Check if job exists
    const job = await prisma.job.findUnique({
      where: { id: parseInt(id) }
    });

    if (!job) {
      return res.status(404).json({ 
        success: false, 
        message: 'Job not found' 
      });
    }

    // Delete job from database
    await prisma.job.delete({
      where: { id: parseInt(id) }
    });

    console.log('✓ Job deleted successfully:', job.jobTitle);

    res.status(200).json({ 
      success: true, 
      message: 'Job deleted successfully' 
    });

  } catch (error) {
    console.error('Error deleting job:', error);
    res.status(500).json({ 
      success: false, 
      message: 'Error deleting job' 
    });
  }
});

/**
 * GET /admin/applicants
 * Admin - Applicants List Page
*/
router.get('/applicants', verifyAuth, async (req, res) => {
  try {
    const locals = {
      title: 'Applicants',
      description: 'Manage job applicants'
    }

    // Fetch admin data from database
    const admin = await prisma.admin.findUnique({
      where: { id: req.admin.id }
    });

    // TODO: Fetch applicants from database
    const applicants = [];

    res.render('admin/applicant_list', {
      locals,
      admin,
      applicants,
      layout: adminLayout
    });

  } catch (error) {
    console.log(error);
    res.status(500).send('Error loading applicants page');
  }
});


/**
 * GET /admin/scholarships
 * Admin - Scholarships List Page
*/
router.get('/scholarships', verifyAuth, async (req, res) => {
  try {
    const locals = {
      title: 'Scholarships',
      description: 'Manage scholarships'
    }

    // Fetch admin data from database
    const admin = await prisma.admin.findUnique({
      where: { id: req.admin.id }
    });

    // Pagination setup
    const page = parseInt(req.query.page) || 1;
    const scholarshipsPerPage = 8;
    const skip = (page - 1) * scholarshipsPerPage;

    // Fetch total scholarships count
    const totalScholarships = await prisma.scholarship.count();
    const totalPages = Math.ceil(totalScholarships / scholarshipsPerPage);

    // Fetch scholarships for current page
    const scholarships = await prisma.scholarship.findMany({
      orderBy: { createdAt: 'desc' },
      skip,
      take: scholarshipsPerPage
    });

    res.render('admin/scholashp_list', {
      locals,
      admin,
      scholarships,
      currentPage: page,
      totalPages,
      totalScholarships,
      scholarshipsPerPage,
      layout: adminLayout
    });

  } catch (error) {
    console.log(error);
    res.status(500).send('Error loading scholarships page');
  }
});

/**
 * POST /admin/scholarships
 * Admin - Create New Scholarship
*/
router.post('/scholarships', verifyAuth, scholarshipImageUpload.single('scholarshipImage'), async (req, res) => {
  try {
    const { programName, collegeName, sponsorship, vacancy, deadline, description, requirements } = req.body;

    console.log('Creating scholarship with data:', { programName, collegeName, sponsorship, vacancy });
    console.log('File:', req.file);

    // Validate required fields
    if (!programName || !collegeName || !sponsorship || !vacancy || !deadline || !description || !requirements) {
      // Delete uploaded file if validation fails
      if (req.file) {
        try {
          fs.unlinkSync(req.file.path);
        } catch (err) {
          console.log('Error deleting file:', err);
        }
      }
      return res.status(400).json({ 
        success: false, 
        message: 'All fields are required' 
      });
    }

    // Generate image URL from uploaded file
    let imageUrl = '';
    if (req.file) {
      imageUrl = `/uploads/scholarship-images/${req.file.filename}`;
    }

    // Create scholarship in database
    const newScholarship = await prisma.scholarship.create({
      data: {
        programName,
        collegeName,
        sponsorship,
        vacancy,
        deadline: new Date(deadline),
        description,
        requirements,
        image: imageUrl,
        status: 'Active'
      }
    });

    console.log('✓ Scholarship created successfully:', programName);

    res.status(201).json({ 
      success: true, 
      message: 'Scholarship posted successfully',
      scholarship: newScholarship
    });

  } catch (error) {
    // Delete uploaded file if error occurs
    if (req.file) {
      try {
        fs.unlinkSync(req.file.path);
      } catch (err) {
        console.log('Error deleting file:', err);
      }
    }
    console.error('Error creating scholarship:', error);
    res.status(500).json({ 
      success: false, 
      message: 'Error creating scholarship' 
    });
  }
});

/**
 * PATCH /admin/scholarships/:id
 * Admin - Update Scholarship
*/
router.patch('/scholarships/:id', verifyAuth, scholarshipImageUpload.single('scholarshipImage'), async (req, res) => {
  try {
    const { id } = req.params;
    const { programName, collegeName, sponsorship, vacancy, deadline, description, requirements, status } = req.body;

    console.log('Updating scholarship ID:', id);
    console.log('Form data:', { programName, collegeName, sponsorship, vacancy });
    console.log('File:', req.file);

    // Validate ID
    if (!id || isNaN(id)) {
      // Delete uploaded file if validation fails
      if (req.file) {
        try {
          fs.unlinkSync(req.file.path);
        } catch (e) {
          console.error('Error deleting file:', e);
        }
      }
      return res.status(400).json({ 
        success: false, 
        message: 'Invalid scholarship ID' 
      });
    }

    // Validate required fields
    if (!programName || !collegeName || !sponsorship || !vacancy || !deadline || !description || !requirements) {
      // Delete uploaded file if validation fails
      if (req.file) {
        try {
          fs.unlinkSync(req.file.path);
        } catch (e) {
          console.error('Error deleting file:', e);
        }
      }
      return res.status(400).json({ 
        success: false, 
        message: 'All fields are required' 
      });
    }

    // Check if scholarship exists
    const existingScholarship = await prisma.scholarship.findUnique({
      where: { id: parseInt(id) }
    });

    if (!existingScholarship) {
      // Delete uploaded file if scholarship not found
      if (req.file) {
        try {
          fs.unlinkSync(req.file.path);
        } catch (e) {
          console.error('Error deleting file:', e);
        }
      }
      return res.status(404).json({ 
        success: false, 
        message: 'Scholarship not found' 
      });
    }

    // Generate image URL if new file was uploaded
    let imageUrl = existingScholarship.image; // Keep existing if no new file
    if (req.file) {
      // Delete old image file if exists
      if (existingScholarship.image && existingScholarship.image.startsWith('/uploads/scholarship-images/')) {
        const oldFilePath = path.join(__dirname, '../..', 'public', existingScholarship.image);
        if (fs.existsSync(oldFilePath)) {
          try {
            fs.unlinkSync(oldFilePath);
            console.log('Deleted old image file:', oldFilePath);
          } catch (e) {
            console.error('Error deleting old image file:', e);
          }
        }
      }
      imageUrl = `/uploads/scholarship-images/${req.file.filename}`;
      console.log('New image URL:', imageUrl);
    }

    // Update scholarship in database
    const updatedScholarship = await prisma.scholarship.update({
      where: { id: parseInt(id) },
      data: {
        programName,
        collegeName,
        sponsorship,
        vacancy,
        deadline: new Date(deadline),
        description,
        requirements,
        image: imageUrl,
        status: status || 'Active'
      }
    });

    console.log('✓ Scholarship updated successfully:', programName);

    res.status(200).json({ 
      success: true, 
      message: 'Scholarship updated successfully',
      scholarship: updatedScholarship
    });

  } catch (error) {
    // Delete uploaded file if error occurs
    if (req.file) {
      try {
        fs.unlinkSync(req.file.path);
      } catch (e) {
        console.error('Error deleting file on error:', e);
      }
    }
    console.error('Error updating scholarship:', error);
    res.status(500).json({ 
      success: false, 
      message: 'Error updating scholarship' 
    });
  }
});

/**
 * DELETE /admin/scholarships/:id
 * Admin - Delete Scholarship
*/
router.delete('/scholarships/:id', verifyAuth, async (req, res) => {
  try {
    const { id } = req.params;

    // Validate ID
    if (!id || isNaN(id)) {
      return res.status(400).json({ 
        success: false, 
        message: 'Invalid scholarship ID' 
      });
    }

    // Check if scholarship exists
    const scholarship = await prisma.scholarship.findUnique({
      where: { id: parseInt(id) }
    });

    if (!scholarship) {
      return res.status(404).json({ 
        success: false, 
        message: 'Scholarship not found' 
      });
    }

    // Delete scholarship from database
    await prisma.scholarship.delete({
      where: { id: parseInt(id) }
    });

    console.log('✓ Scholarship deleted successfully:', scholarship.programName);

    res.status(200).json({ 
      success: true, 
      message: 'Scholarship deleted successfully' 
    });

  } catch (error) {
    console.error('Error deleting scholarship:', error);
    res.status(500).json({ 
      success: false, 
      message: 'Error deleting scholarship' 
    });
  }
});


/**
 * GET /admin/applications
 * Admin - View All Applications
 */
router.get('/applications', verifyAuth, async (req, res) => {
  try {
    const locals = {
      title: "Applications",
      description: "View all job applications"
    }

    // Fetch admin data from database
    const admin = await prisma.admin.findUnique({
      where: { id: req.admin.id }
    });

    // Pagination setup
    const page = parseInt(req.query.page) || 1;
    const applicationsPerPage = 10;
    const skip = (page - 1) * applicationsPerPage;

    // Fetch total applications count
    const totalApplications = await prisma.application.count();
    const totalPages = Math.ceil(totalApplications / applicationsPerPage);

    // Fetch applications for current page with job details
    const applications = await prisma.application.findMany({
      include: {
        job: {
          select: {
            id: true,
            jobTitle: true,
            employer: true
          }
        }
      },
      orderBy: { createdAt: 'desc' },
      skip,
      take: applicationsPerPage
    });

    res.render('admin/applications', {
      locals,
      admin,
      layout: adminLayout,
      applications,
      currentPage: page,
      totalPages,
      totalApplications,
      applicationsPerPage
    });
  } catch (error) {
    console.log(error);
    res.status(500).send('Error loading applications page');
  }
});

/**
 * GET /admin/applications/:jobId
 * Admin - View Applications for Specific Job
 */
router.get('/applications/job/:jobId', verifyAuth, async (req, res) => {
  try {
    const jobId = parseInt(req.params.jobId);
    
    // Fetch admin data from database
    const admin = await prisma.admin.findUnique({
      where: { id: req.admin.id }
    });

    // Verify job exists
    const job = await prisma.job.findUnique({
      where: { id: jobId }
    });

    if (!job) {
      return res.status(404).send('Job not found');
    }

    const locals = {
      title: `Applications for ${job.jobTitle}`,
      description: `View applications for ${job.jobTitle} at ${job.employer}`
    }

    // Pagination setup
    const page = parseInt(req.query.page) || 1;
    const applicationsPerPage = 10;
    const skip = (page - 1) * applicationsPerPage;

    // Fetch applications for this specific job
    const totalApplications = await prisma.application.count({
      where: { jobId: jobId }
    });
    const totalPages = Math.ceil(totalApplications / applicationsPerPage);

    const applications = await prisma.application.findMany({
      where: { jobId: jobId },
      orderBy: { createdAt: 'desc' },
      skip,
      take: applicationsPerPage
    });

    res.render('admin/job-applications', {
      locals,
      admin,
      layout: adminLayout,
      applications,
      job,
      jobId,
      currentPage: page,
      totalPages,
      totalApplications,
      applicationsPerPage
    });
  } catch (error) {
    console.log(error);
    res.status(500).send('Error loading applications');
  }
});

/**
 * GET /admin/applications/:id/details
 * Admin - View Specific Application Details
 */
router.get('/applications/:id/details', verifyAuth, async (req, res) => {
  try {
    const applicationId = parseInt(req.params.id);

    // Fetch admin data from database
    const admin = await prisma.admin.findUnique({
      where: { id: req.admin.id }
    });

    const application = await prisma.application.findUnique({
      where: { id: applicationId },
      include: {
        job: true
      }
    });

    if (!application) {
      return res.status(404).send('Application not found');
    }

    const locals = {
      title: "Application Details",
      description: "View detailed application information"
    }

    res.render('admin/application-details', {
      locals,
      admin,
      layout: adminLayout,
      application
    });
  } catch (error) {
    console.log(error);
    res.status(500).send('Error loading application details');
  }
});

/**
 * PATCH /admin/applications/:id/status
 * Admin - Update Application Status
 */
router.patch('/applications/:id/status', verifyAuth, async (req, res) => {
  try {
    const applicationId = parseInt(req.params.id);
    const { status } = req.body;

    if (!status) {
      return res.status(400).json({
        success: false,
        message: 'Status is required'
      });
    }

    const validStatuses = ['Pending', 'Reviewed', 'Shortlisted', 'Rejected', 'Accepted'];
    if (!validStatuses.includes(status)) {
      return res.status(400).json({
        success: false,
        message: 'Invalid status'
      });
    }

    const application = await prisma.application.update({
      where: { id: applicationId },
      data: { status }
    });

    console.log('✓ Application status updated:', status);

    res.status(200).json({
      success: true,
      message: 'Application status updated successfully',
      application
    });
  } catch (error) {
    console.error('Error updating application status:', error);
    res.status(500).json({
      success: false,
      message: 'Error updating application status'
    });
  }
});

/**
 * DELETE /admin/applications/:id
 * Admin - Delete Application
 */
router.delete('/applications/:id', verifyAuth, async (req, res) => {
  try {
    const applicationId = parseInt(req.params.id);

    const application = await prisma.application.findUnique({
      where: { id: applicationId }
    });

    if (!application) {
      return res.status(404).json({
        success: false,
        message: 'Application not found'
      });
    }

    // Delete application
    await prisma.application.delete({
      where: { id: applicationId }
    });

    // Decrement applicants count
    await prisma.job.update({
      where: { id: application.jobId },
      data: {
        applicants: {
          decrement: 1
        }
      }
    });

    console.log('✓ Application deleted successfully');

    res.status(200).json({
      success: true,
      message: 'Application deleted successfully'
    });
  } catch (error) {
    console.error('Error deleting application:', error);
    res.status(500).json({
      success: false,
      message: 'Error deleting application'
    });
  }
});


/**
 * GET /scholarship-applicants/:scholarshipId
 * Admin - View Applicants for Specific Scholarship
 */
router.get('/scholarship-applicants/:scholarshipId', verifyAuth, async (req, res) => {
  try {
    const { scholarshipId } = req.params;

    // Fetch admin data from database
    const admin = await prisma.admin.findUnique({
      where: { id: req.admin.id }
    });

    // Fetch scholarship details
    const scholarship = await prisma.scholarship.findUnique({
      where: { id: parseInt(scholarshipId) }
    });

    if (!scholarship) {
      return res.status(404).render('404', {
        locals: { title: 'Scholarship Not Found' }
      });
    }

    const locals = {
      title: `Applicants for ${scholarship.programName}`,
      description: "View applicants for this scholarship"
    }

    // Pagination setup
    const page = parseInt(req.query.page) || 1;
    const applicantsPerPage = 10;
    const skip = (page - 1) * applicantsPerPage;

    // Fetch total applicants count for this scholarship
    const totalApplicants = await prisma.scholarshipApplication.count({
      where: { scholarshipId: parseInt(scholarshipId) }
    });
    const totalPages = Math.ceil(totalApplicants / applicantsPerPage);

    // Fetch applicants for current page
    const applicants = await prisma.scholarshipApplication.findMany({
      where: { scholarshipId: parseInt(scholarshipId) },
      orderBy: { createdAt: 'desc' },
      skip,
      take: applicantsPerPage
    });

    res.render('admin/scholarship_applicants', {
      locals,
      admin,
      layout: adminLayout,
      applicants,
      scholarship,
      currentPage: page,
      totalPages,
      totalApplicants,
      applicantsPerPage
    });
  } catch (error) {
    console.log(error);
    res.status(500).send('Error loading scholarship applicants page');
  }
});

/**
 * GET /scholarship-applicants
 * Admin - View All Scholarship Applicants
 */
router.get('/scholarship-applicants', verifyAuth, async (req, res) => {
  try {
    const locals = {
      title: "Scholarship Applicants",
      description: "View all scholarship applicants"
    }

    // Fetch admin data from database
    const admin = await prisma.admin.findUnique({
      where: { id: req.admin.id }
    });

    // Pagination setup
    const page = parseInt(req.query.page) || 1;
    const applicantsPerPage = 10;
    const skip = (page - 1) * applicantsPerPage;

    // Fetch total applicants count
    const totalApplicants = await prisma.scholarshipApplication.count();
    const totalPages = Math.ceil(totalApplicants / applicantsPerPage);

    // Fetch applicants for current page with scholarship details
    const applicants = await prisma.scholarshipApplication.findMany({
      include: {
        scholarship: true
      },
      orderBy: { createdAt: 'desc' },
      skip,
      take: applicantsPerPage
    });

    res.render('admin/scholarship_applicants', {
      locals,
      admin,
      layout: adminLayout,
      applicants,
      scholarship: null,
      currentPage: page,
      totalPages,
      totalApplicants,
      applicantsPerPage
    });
  } catch (error) {
    console.log(error);
    res.status(500).send('Error loading scholarship applicants page');
  }
});

/**
 * PATCH /scholarship-applicants/:id/status
 * Admin - Update Scholarship Application Status
 */
router.patch('/scholarship-applicants/:id/status', verifyAuth, async (req, res) => {
  try {
    const { id } = req.params;
    const { status } = req.body;

    if (!id || isNaN(id)) {
      return res.status(400).json({
        success: false,
        message: 'Invalid application ID'
      });
    }

    if (!status) {
      return res.status(400).json({
        success: false,
        message: 'Status is required'
      });
    }

    // Update application status
    const applicant = await prisma.scholarshipApplication.update({
      where: { id: parseInt(id) },
      data: { status }
    });

    console.log('✓ Scholarship application status updated:', applicant.id);

    res.status(200).json({
      success: true,
      message: 'Status updated successfully',
      applicant
    });
  } catch (error) {
    console.error('Error updating application status:', error);
    res.status(500).json({
      success: false,
      message: 'Error updating application status'
    });
  }
});

/**
 * DELETE /scholarship-applicants/:id
 * Admin - Delete Scholarship Application
 */
router.delete('/scholarship-applicants/:id', verifyAuth, async (req, res) => {
  try {
    const { id } = req.params;

    if (!id || isNaN(id)) {
      return res.status(400).json({
        success: false,
        message: 'Invalid application ID'
      });
    }

    // Find application to get passport path
    const applicant = await prisma.scholarshipApplication.findUnique({
      where: { id: parseInt(id) }
    });

    if (!applicant) {
      return res.status(404).json({
        success: false,
        message: 'Application not found'
      });
    }

    // Delete uploaded passport file if exists
    if (applicant.passport) {
      const fs = require('fs');
      const path = require('path');
      const filePath = path.join(__dirname, '../../public', applicant.passport);
      if (fs.existsSync(filePath)) {
        fs.unlinkSync(filePath);
        console.log('✓ Passport file deleted:', filePath);
      }
    }

    // Delete application record
    await prisma.scholarshipApplication.delete({
      where: { id: parseInt(id) }
    });

    console.log('✓ Scholarship application deleted successfully:', applicant.id);

    res.status(200).json({
      success: true,
      message: 'Application deleted successfully'
    });
  } catch (error) {
    console.error('Error deleting application:', error);
    res.status(500).json({
      success: false,
      message: 'Error deleting application'
    });
  }
});

/**
 * GET /admin/profile
 * Admin - View Profile Page
 */
router.get('/profile', verifyAuth, async (req, res) => {
  try {
    const locals = {
      title: "Admin Profile",
      description: "Update your admin profile"
    }

    // Get admin info from JWT (stored in cookie)
    const token = req.cookies.authToken;
    if (!token) {
      return res.redirect('/admin/login');
    }

    const decoded = jwt.verify(token, JWT_SECRET);
    const admin = await prisma.admin.findUnique({
      where: { id: decoded.id }
    });

    if (!admin) {
      return res.redirect('/admin/login');
    }

    res.render('admin/profile', {
      locals,
      layout: adminLayout,
      admin
    });
  } catch (error) {
    console.log(error);
    res.status(500).send('Error loading profile page');
  }
});

/**
 * PATCH /profile
 * Admin - Update Profile
 */
router.patch('/profile', verifyAuth, profileUpload.single('profile'), async (req, res) => {
  try {
    const token = req.cookies.authToken;
    const decoded = jwt.verify(token, JWT_SECRET);
    
    const { full_name, email, phone, bio, currentPassword, newPassword } = req.body;

    // Get current admin
    const admin = await prisma.admin.findUnique({
      where: { id: decoded.id }
    });

    if (!admin) {
      return res.status(404).json({
        success: false,
        message: 'Admin not found'
      });
    }

    // Validate required fields
    if (!full_name || !email) {
      return res.status(400).json({
        success: false,
        message: 'Full name and email are required'
      });
    }

    // Check if email already exists (and is not the current admin)
    const existingAdmin = await prisma.admin.findUnique({
      where: { email }
    });

    if (existingAdmin && existingAdmin.id !== admin.id) {
      return res.status(400).json({
        success: false,
        message: 'Email already in use'
      });
    }

    const updateData = {
      full_name,
      email,
      phone: phone || '',
      bio: bio || ''
    };

    // Generate profile URL if new file was uploaded
    if (req.file) {
      updateData.profile = `/uploads/admin-profiles/${req.file.filename}`;
      
      // Delete old profile image if exists
      if (admin.profile && admin.profile.startsWith('/uploads/admin-profiles/')) {
        const oldFilePath = path.join(__dirname, '../..', 'public', admin.profile);
        if (fs.existsSync(oldFilePath)) {
          fs.unlinkSync(oldFilePath);
        }
      }
    }

    // Handle password change if provided
    if (newPassword) {
      if (!currentPassword) {
        return res.status(400).json({
          success: false,
          message: 'Current password is required to change password'
        });
      }

      // Verify current password
      const isPasswordValid = await bcrypt.compare(currentPassword, admin.password);
      if (!isPasswordValid) {
        return res.status(400).json({
          success: false,
          message: 'Current password is incorrect'
        });
      }

      // Hash new password
      const hashedPassword = await bcrypt.hash(newPassword, 10);
      updateData.password = hashedPassword;
    }

    // Update admin profile
    const updatedAdmin = await prisma.admin.update({
      where: { id: admin.id },
      data: updateData
    });

    console.log('✓ Admin profile updated successfully:', updatedAdmin.email);

    res.status(200).json({
      success: true,
      message: 'Profile updated successfully',
      admin: {
        id: updatedAdmin.id,
        full_name: updatedAdmin.full_name,
        email: updatedAdmin.email,
        phone: updatedAdmin.phone,
        bio: updatedAdmin.bio,
        profile: updatedAdmin.profile
      }
    });
  } catch (error) {
    // Delete uploaded file if error occurs
    if (req.file) {
      fs.unlinkSync(req.file.path);
    }
    console.error('Error updating profile:', error);
    res.status(500).json({
      success: false,
      message: 'Error updating profile: ' + error.message
    });
  }
});

router.get('/logout', (req, res) => {
  // Clear JWT cookie
  res.clearCookie('authToken');
  console.log('✓ Admin logged out successfully');
  res.redirect('/login');
});


// Test route to verify admin router is mounted
router.get('/test', (req, res) => {
  res.json({ message: 'Admin router is working correctly' });
});


module.exports = router;