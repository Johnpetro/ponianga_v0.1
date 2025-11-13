const express = require('express');
const router = express.Router();
const multer = require('multer');
const path = require('path');
const fs = require('fs');
// const Post = require('../models/Post');
// const User = require('../models/User');
const { connectDB, prisma } = require('../config/db');
const adminService = require('../services/adminService');
const { verifyAuth } = require('../middleware/authMiddleware');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

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
 * GET /admin/admin_contact
 * Admin - Contact Page
*/
router.get('/admin_contact', verifyAuth, async (req, res) => {
  try {
    const locals = {
      title: "Contact",
      description: "Contact page"
    }
    
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
 * GET /admin/jobs
 * Admin - Jobs List Page
*/
router.get('/jobs', verifyAuth, async (req, res) => {
  try {
    const locals = {
      title: 'Job Listings',
      description: 'Manage job listings'
    }

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
router.post('/jobs', verifyAuth, async (req, res) => {
  try {
    const { jobTitle, employer, jobType, location, deadline, applicants, salary, skills, description } = req.body;

    // Validate required fields
    if (!jobTitle || !employer || !jobType || !location || !deadline || !salary || !skills || !description) {
      return res.status(400).json({ 
        success: false, 
        message: 'All fields are required' 
      });
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
    console.error('Error creating job:', error);
    res.status(500).json({ 
      success: false, 
      message: 'Error creating job' 
    });
  }
});

/**
 * PATCH /admin/jobs/:id
 * Admin - Update Job
*/
router.patch('/jobs/:id', verifyAuth, async (req, res) => {
  try {
    const { id } = req.params;
    const { jobTitle, employer, jobType, location, deadline, applicants, salary, skills, description, status } = req.body;

    // Validate ID
    if (!id || isNaN(id)) {
      return res.status(400).json({ 
        success: false, 
        message: 'Invalid job ID' 
      });
    }

    // Validate required fields
    if (!jobTitle || !employer || !jobType || !location || !deadline || !salary || !skills || !description) {
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
      return res.status(404).json({ 
        success: false, 
        message: 'Job not found' 
      });
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

    // TODO: Fetch applicants from database
    const applicants = [];

    res.render('admin/applicant_list', {
      locals,
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
router.post('/scholarships', verifyAuth, async (req, res) => {
  try {
    const { programName, collegeName, sponsorship, vacancy, deadline, description, requirements } = req.body;

    // Validate required fields
    if (!programName || !collegeName || !sponsorship || !vacancy || !deadline || !description || !requirements) {
      return res.status(400).json({ 
        success: false, 
        message: 'All fields are required' 
      });
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
router.patch('/scholarships/:id', verifyAuth, async (req, res) => {
  try {
    const { id } = req.params;
    const { programName, collegeName, sponsorship, vacancy, deadline, description, requirements, status } = req.body;

    // Validate ID
    if (!id || isNaN(id)) {
      return res.status(400).json({ 
        success: false, 
        message: 'Invalid scholarship ID' 
      });
    }

    // Validate required fields
    if (!programName || !collegeName || !sponsorship || !vacancy || !deadline || !description || !requirements) {
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
      return res.status(404).json({ 
        success: false, 
        message: 'Scholarship not found' 
      });
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


router.get('/logout', (req, res) => {
  req.session.destroy((err) => {
    if (err) {
      console.error('Error destroying session:', err);
      return res.status(500).send('Error logging out');
    }
    res.clearCookie('connect.sid');
    console.log('✓ Admin logged out successfully');
    res.redirect('/admin/login');
  });
});


// Test route to verify admin router is mounted
router.get('/test', (req, res) => {
  res.json({ message: 'Admin router is working correctly' });
});


module.exports = router;