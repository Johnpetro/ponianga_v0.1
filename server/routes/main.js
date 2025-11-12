const express = require('express');
const router = express.Router();
const Post = require('../models/Post');

/**
 * GET /
 * HOME
*/
router.get('', async (req, res) => {
  try {
    const locals = {
      title: "NodeJs Blog",
      description: "Simple Blog created with NodeJs, Express & MongoDb."
    }
  res.render('index', { locals });
  } catch (error) {
    console.log(error);
  }



    // Count is deprecated - please use countDocuments
    // const count = await Post.count();

   

});






module.exports = router;

/**
 * GET /about
 */
router.get('/about', (req, res) => {
  try {
    const locals = {
      title: "About",
      description: "About page"
    }
    res.render('about', { locals });
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
router.get('/job-listing', (req, res) => {
  try {
    const locals = {
      title: "Job",
      description: "Job posts"
    }
    res.render('job', { locals });
  } catch (error) {
    console.log(error);
  }
});



/**
 * GET /blog/study-abbroad-list
 */
router.get('/study-abbroad-list', (req, res) => {
  try {
    const locals = {
      title: "Study Abroad",
      description: "Study abroad resources and listings"
    }
    res.render('study-abbroad-list', { locals });
  } catch (error) {
    console.log(error);
  }
});

/**
 * GET /job-details/:id
 * Job Details
 */
router.get('/job-details/:id', (req, res) => {
  try {
    const jobId = req.params.id;
    const locals = {
      title: "Job Details",
      description: "View detailed information about this job position"
    }
    res.render('job_details', { locals, jobId });
  } catch (error) {
    console.log(error);
  }
});

/**
 * GET /job-details
 * Job Details (without ID for general access)
 */
router.get('/job-details', (req, res) => {
  try {
    const locals = {
      title: "Job Details",
      description: "View detailed information about job positions"
    }
    res.render('job_details', { locals });
  } catch (error) {
    console.log(error);
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
