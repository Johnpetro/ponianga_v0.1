const express = require('express');
const router = express.Router();
const multer = require('multer');
const path = require('path');
const fs = require('fs');
const Post = require('../models/Post');
// const User = require('../models/User');
const { connectDB, prisma } = require('../config/db');
const { trackVisitor } = require('../middleware/visitorTracker');
// const adminService = require('../services/adminService');

// Configure multer for file uploads
const uploadDir = path.join(__dirname, '../..', 'public', 'uploads', 'applications');
if (!fs.existsSync(uploadDir)) {
  fs.mkdirSync(uploadDir, { recursive: true });
}

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, uploadDir);
  },
  filename: (req, file, cb) => {
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
    cb(null, 'app-' + uniqueSuffix + path.extname(file.originalname));
  }
});

const upload = multer({
  storage: storage,
  limits: { fileSize: 5 * 1024 * 1024 }, // 5MB limit
  fileFilter: (req, file, cb) => {
    // Allow PDF, DOC, DOCX, ZIP
    const allowedMimes = [
      'application/pdf',
      'application/msword',
      'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
      'application/zip'
    ];
    if (allowedMimes.includes(file.mimetype)) {
      cb(null, true);
    } else {
      cb(new Error('Invalid file type. Only PDF, DOC, DOCX, and ZIP are allowed.'));
    }
  }
});

/**
 * GET /
 * HOME
*/
router.get('/', trackVisitor, async (req, res) => {
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







router.get('/about', trackVisitor, async(req, res) => {
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
router.get('/contact', trackVisitor, (req, res) => {
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
router.get('/blog', trackVisitor, async (req, res) => {
  try {
 
    res.render('blog');
  } catch (error) {
    console.log(error);
  }
});

/**
 * GET /blog/job
 */
router.get('/job-listing', trackVisitor, async(req, res) => {
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
router.get('/study-abbroad-list', trackVisitor, async (req, res) => {
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
 * Handle job application form submission with file uploads
 */
router.post('/application-form', upload.fields([
  { name: 'resume', maxCount: 1 },
  { name: 'portfolio', maxCount: 5 }
]), async (req, res) => {
  try {
    const {
      jobId,
      firstName,
      lastName,
      email,
      phone,
      address,
      currentPosition,
      experience,
      expectedSalary,
      availableFrom,
      degree,
      university,
      graduationYear,
      gpa,
      skills,
      coverLetter,
      agreement
    } = req.body;

    // Validation
    if (!jobId || !firstName || !lastName || !email || !agreement) {
      // Delete uploaded files if validation fails
      if (req.files) {
        Object.keys(req.files).forEach(fieldName => {
          req.files[fieldName].forEach(file => {
            try {
              fs.unlinkSync(file.path);
            } catch (e) {
              console.error('Error deleting file:', e);
            }
          });
        });
      }
      return res.status(400).json({
        success: false,
        message: 'Please fill in all required fields'
      });
    }

    // Check if resume was uploaded
    if (!req.files || !req.files.resume || req.files.resume.length === 0) {
      return res.status(400).json({
        success: false,
        message: 'Resume/CV is required'
      });
    }

    // Verify job exists
    const job = await prisma.job.findUnique({
      where: { id: parseInt(jobId) }
    });

    if (!job) {
      // Delete uploaded files if job not found
      if (req.files) {
        Object.keys(req.files).forEach(fieldName => {
          req.files[fieldName].forEach(file => {
            try {
              fs.unlinkSync(file.path);
            } catch (e) {
              console.error('Error deleting file:', e);
            }
          });
        });
      }
      return res.status(404).json({
        success: false,
        message: 'Job not found'
      });
    }

    // Check if user already applied for this job
    const existingApplication = await prisma.application.findFirst({
      where: {
        jobId: parseInt(jobId),
        email: email
      }
    });

    if (existingApplication) {
      // Delete uploaded files if duplicate application
      if (req.files) {
        Object.keys(req.files).forEach(fieldName => {
          req.files[fieldName].forEach(file => {
            try {
              fs.unlinkSync(file.path);
            } catch (e) {
              console.error('Error deleting file:', e);
            }
          });
        });
      }
      return res.redirect('/job-listing?error=true&message=You have already applied for this job');
    }

    // Generate file URLs
    let resumeUrl = '';
    let portfolioUrl = '';

    if (req.files.resume && req.files.resume[0]) {
      resumeUrl = `/uploads/applications/${req.files.resume[0].filename}`;
      console.log('Resume uploaded:', resumeUrl);
    }

    if (req.files.portfolio && req.files.portfolio.length > 0) {
      // Store portfolio as comma-separated URLs
      portfolioUrl = req.files.portfolio.map(file => `/uploads/applications/${file.filename}`).join(',');
      console.log('Portfolio uploaded:', portfolioUrl);
    }

    // Create application
    const application = await prisma.application.create({
      data: {
        jobId: parseInt(jobId),
        firstName: firstName || '',
        lastName: lastName || '',
        email: email || '',
        phone: phone || '',
        address: address || '',
        currentPosition: currentPosition || '',
        experience: experience || '',
        expectedSalary: expectedSalary || '',
        availableFrom: availableFrom ? new Date(availableFrom) : new Date(),
        degree: degree || '',
        university: university || '',
        graduationYear: graduationYear || '',
        gpa: gpa || '',
        skills: skills || '',
        coverLetter: coverLetter || '',
        resume: resumeUrl,
        portfolio: portfolioUrl,
        agreement: agreement === 'on' || agreement === true,
        status: 'Pending'
      }
    });

    // Increment applicants count
    await prisma.job.update({
      where: { id: parseInt(jobId) },
      data: {
        applicants: {
          increment: 1
        }
      }
    });

    console.log('✓ Application submitted successfully:', email);
    console.log('✓ Files uploaded:', { resume: resumeUrl, portfolio: portfolioUrl });

    // Redirect to job listing with success message
    res.redirect('/job-listing');
  } catch (error) {
    // Delete uploaded files if error occurs
    if (req.files) {
      Object.keys(req.files).forEach(fieldName => {
        req.files[fieldName].forEach(file => {
          try {
            fs.unlinkSync(file.path);
          } catch (e) {
            console.error('Error deleting file:', e);
          }
        });
      });
    }
    console.error('Error submitting application:', error);
    res.status(500).json({
      success: false,
      message: 'Error submitting application. Please try again.'
    });
  }
});

/**
 * POST /scholarship-application
 * Handle scholarship application form submission with file uploads
 */
router.post('/scholarship-application', upload.single('passport'), async (req, res) => {
  try {
    const {
      scholarshipId,
      firstName,
      lastName,
      email,
      phone,
      address
    } = req.body;

    // Validation
    if (!scholarshipId || !firstName || !lastName || !email || !phone || !address) {
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
        message: 'Please fill in all required fields'
      });
    }

    // Check if passport was uploaded
    if (!req.file) {
      return res.status(400).json({
        success: false,
        message: 'Passport document is required'
      });
    }

    // Verify scholarship exists
    const scholarship = await prisma.scholarship.findUnique({
      where: { id: parseInt(scholarshipId) }
    });

    if (!scholarship) {
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

    // Check if user already applied for this scholarship
    const existingApplication = await prisma.scholarshipApplication.findFirst({
      where: {
        scholarshipId: parseInt(scholarshipId),
        email: email
      }
    });

    if (existingApplication) {
      // Delete uploaded file if duplicate application
      if (req.file) {
        try {
          fs.unlinkSync(req.file.path);
        } catch (e) {
          console.error('Error deleting file:', e);
        }
      }
      return res.status(400).json({
        success: false,
        message: 'You have already applied for this scholarship'
      });
    }

    // Generate file URL
    let passportUrl = '';
    if (req.file) {
      passportUrl = `/uploads/applications/${req.file.filename}`;
      console.log('Passport uploaded:', passportUrl);
    }

    // Create scholarship application
    const application = await prisma.scholarshipApplication.create({
      data: {
        scholarshipId: parseInt(scholarshipId),
        firstName: firstName || '',
        lastName: lastName || '',
        email: email || '',
        phone: phone || '',
        address: address || '',
        passport: passportUrl,
        status: 'Pending'
      }
    });

    console.log('✓ Scholarship application submitted successfully:', email);
    console.log('✓ Passport uploaded:', passportUrl);

    // res.status(201).json({
    //   success: true,
    //   message: 'Scholarship application submitted successfully! We will review it shortly.',
    //   application: application
    // });
    res.redirect('/study-abbroad-list');

  } catch (error) {
    // Delete uploaded file if error occurs
    if (req.file) {
      try {
        fs.unlinkSync(req.file.path);
      } catch (e) {
        console.error('Error deleting file:', e);
      }
    }
    console.error('Error submitting scholarship application:', error);
    res.status(500).json({
      success: false,
      message: 'Error submitting scholarship application. Please try again.'
    });
  }
});

module.exports = router;
