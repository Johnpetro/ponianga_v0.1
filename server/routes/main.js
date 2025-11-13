const express = require('express');
const router = express.Router();
const Post = require('../models/Post');
// const User = require('../models/User');
const { connectDB, prisma } = require('../config/db');
// const adminService = require('../services/adminService');

/**
 * GET /
 * HOME
*/
router.get('/', async (req, res) => {
  try {
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
    const locals = {
      title: "NodeJs Blog",
      description: "Simple Blog created with NodeJs, Express & MongoDb."
    }
  res.render('index', { locals, jobs, currentPage: page, totalPages, jobsPerPage});
  } catch (error) {
    console.log(error);
  }



    // Count is deprecated - please use countDocuments
    // const count = await Post.count();

   

});







router.get('/about', async(req, res) => {
  try {
    const page = parseInt(req.query.page) || 1;
    const membersPerPage = 6; // Show 6 members per page (2 rows of 3)
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

    const locals = {
      title: "About",
      description: "About page"
    }
    res.render('about', { locals, teamMembers, currentPage: page, totalPages, membersPerPage });
  } catch (error) {
    console.log(error);
  }
});

/**
 * GET /contact
 */
router.get('/contact', (req, res) => {
  try {
    const locals = {
      title: "Contact",
      description: "Contact page"
    }
    res.render('contact', { locals });
  } catch (error) {
    console.log(error);
  }
});

/**
 * GET /blog
 * List posts
 */
router.get('/blog', async (req, res) => {
  try {
 
    res.render('blog');
  } catch (error) {
    console.log(error);
  }
});

/**
 * GET /blog/job
 */
router.get('/job-listing', async(req, res) => {
  try {
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
    const locals = {
      title: "Job",
      description: "Job posts"
    }
    res.render('job', { locals, jobs, currentPage: page, totalPages, jobsPerPage});
  } catch (error) {
    console.log(error);
  }
});



/**
 * GET /blog/study-abbroad-list
 */
router.get('/study-abbroad-list', async (req, res) => {
  try {
    const locals = {
      title: "Study Abroad",
      description: "Study abroad resources and listings"
    }

    // Pagination setup
    const page = parseInt(req.query.page) || 1;
    const scholarshipsPerPage = 5;
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
    console.log(scholarships);
    
    res.render('study-abbroad-list', { locals , scholarships, currentPage: page, totalPages, scholarshipsPerPage });
  } catch (error) {
    console.log(error);
  }
});

/**
 * POST /job-details
 * Job Details - uses POST to hide ID in URL
 */
router.post('/job-details', async (req, res) => {
  try {
    const jobId = parseInt(req.body.jobId);
    
    // Fetch the specific job by ID
    const job = await prisma.job.findUnique({
      where: { id: jobId }
    });

    // If job not found, render error or redirect
    if (!job) {
      return res.status(404).render('404', { 
        locals: { title: 'Job Not Found' } 
      });
    }

    // Fetch related jobs (other jobs, excluding current one)
    const relatedJobs = await prisma.job.findMany({
      where: {
        id: { not: jobId }
      },
      orderBy: { createdAt: 'desc' },
      take: 2
    });

    const locals = {
      title: "Job Details",
      description: "View detailed information about this job position"
    }
    
    res.render('job_details', { locals, job, relatedJobs, jobId });
  } catch (error) {
    console.log(error);
    res.status(500).send('Error loading job details');
  }
});

/**
 * POST /scholarship_details
 * Scholarship Details - uses POST to hide ID in URL
 */
router.post('/scholarship_details', async (req, res) => {
  try {
    const scholarshipId = parseInt(req.body.scholarshipId);

    // Fetch the specific scholarship by ID
    const scholarship = await prisma.scholarship.findUnique({
      where: { id: scholarshipId }
    });

    // If scholarship not found, render error or redirect
    if (!scholarship) {
      return res.status(404).render('404', {
        locals: { title: 'Scholarship Not Found' }
      });
    }

    const locals = {
      title: "Scholarship Details",
      description: "View detailed information about scholarship opportunities"
    }
    res.render('scholarship_details', { locals, scholarship, scholarshipId });
  } catch (error) {
    console.log(error);
  }
});



router.post('/contact', async (req, res) => {
  try {
    const { inquiry_type, full_name, email, phone, subject, message } = req.body;

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
 * GET /application-form
 * Job Application Form
 */
router.get('/application-form', (req, res) => {
  try {
    const locals = {
      title: "Job Application",
      description: "Apply for your dream job position"
    }
    res.render('application-form', { locals });
  } catch (error) {
    console.log(error);
  }
});

/**
 * GET /application-form/:jobId
 * Job Application Form with specific job ID
 */
router.get('/application-form/:jobId', (req, res) => {
  try {
    const jobId = req.params.jobId;
    const locals = {
      title: "Job Application",
      description: "Apply for this job position"
    }
    res.render('application-form', { locals, jobId });
  } catch (error) {
    console.log(error);
  }
});

/**
 * POST /application-form
 * Handle job application form submission
 */
router.post('/application-form', (req, res) => {
  try {
    // Handle form submission logic here
    // For now, just redirect with success message
    console.log('Application submitted:', req.body);
    res.redirect('/application-form?success=true');
  } catch (error) {
    console.log(error);
    res.redirect('/application-form?error=true');
  }
});

module.exports = router;
