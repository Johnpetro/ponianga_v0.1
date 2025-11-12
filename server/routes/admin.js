const express = require('express');
const router = express.Router();
// const Post = require('../models/Post');
// const User = require('../models/User');
// const bcrypt = require('bcrypt');
// const jwt = require('jsonwebtoken');

const adminLayout = '../views/layouts/admin';
const jwtSecret = process.env.JWT_SECRET;


/**
 * 
 * Check Login
*/
// 


/**
 * GET /
 * Admin - Login Page
*/
router.get('/admin', async (req, res) => {
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
 * POST /
 * Admin - Check Login
*/



/**
 * GET /
 * Admin Dashboard
*/
// router.get('/dashboard', authMiddleware, async (req, res) => {
//   try {
//     const locals = {
//       title: 'Dashboard',
//       description: 'Simple Blog created with NodeJs, Express & MongoDb.'
//     }

//     const data = await Post.find();
//     res.render('admin/dashboard', {
//       locals,
//       data,
//       layout: adminLayout
//     });

//   } catch (error) {
//     console.log(error);
//   }

// });


/**
 * GET /
 * Admin - Create New Post
*/
// router.get('/add-post', authMiddleware, async (req, res) => {
//   try {
//     const locals = {
//       title: 'Add Post',
//       description: 'Simple Blog created with NodeJs, Express & MongoDb.'
//     }

//     const data = await Post.find();
//     res.render('admin/add-post', {
//       locals,
//       layout: adminLayout
//     });

//   } catch (error) {
//     console.log(error);
//   }

// });


/**
 * POST /
 * Admin - Create New Post
*/
// router.post('/add-post', authMiddleware, async (req, res) => {
//   try {
//     try {
//       const newPost = new Post({
//         title: req.body.title,
//         body: req.body.body
//       });

//       await Post.create(newPost);
//       res.redirect('/dashboard');
//     } catch (error) {
//       console.log(error);
//     }

//   } catch (error) {
//     console.log(error);
//   }
// });


/**
 * GET /
 * Admin - Create New Post
// */
// router.get('/edit-post/:id', authMiddleware, async (req, res) => {
//   try {

//     const locals = {
//       title: "Edit Post",
//       description: "Free NodeJs User Management System",
//     };

//     const data = await Post.findOne({ _id: req.params.id });

//     res.render('admin/edit-post', {
//       locals,
//       data,
//       layout: adminLayout
//     })

//   } catch (error) {
//     console.log(error);
//   }

// });


/**
 * PUT /
 * Admin - Create New Post
*/
// router.put('/edit-post/:id', authMiddleware, async (req, res) => {
//   try {

//     await Post.findByIdAndUpdate(req.params.id, {
//       title: req.body.title,
//       body: req.body.body,
//       updatedAt: Date.now()
//     });

//     res.redirect(`/edit-post/${req.params.id}`);

//   } catch (error) {
//     console.log(error);
//   }

// });


// router.post('/admin', async (req, res) => {
//   try {
//     const { username, password } = req.body;
    
//     if(req.body.username === 'admin' && req.body.password === 'password') {
//       res.send('You are logged in.')
//     } else {
//       res.send('Wrong username or password');
//     }

//   } catch (error) {
//     console.log(error);
//   }
// });


/**
 * POST /
 * Admin - Register
*/
// router.post('/register', async (req, res) => {
//   try {
//     const { username, password } = req.body;
//     const hashedPassword = await bcrypt.hash(password, 10);

//     try {
//       const user = await User.create({ username, password:hashedPassword });
//       res.status(201).json({ message: 'User Created', user });
//     } catch (error) {
//       if(error.code === 11000) {
//         res.status(409).json({ message: 'User already in use'});
//       }
//       res.status(500).json({ message: 'Internal server error'})
//     }

//   } catch (error) {
//     console.log(error);
//   }
// });


/**
 * DELETE /
 * Admin - Delete Post
*/
// router.delete('/delete-post/:id', authMiddleware, async (req, res) => {

//   try {
//     await Post.deleteOne( { _id: req.params.id } );
//     res.redirect('/dashboard');
//   } catch (error) {
//     console.log(error);
//   }

// });


/**
 * GET /
 * Admin Logout
*/
// router.get('/logout', (req, res) => {
//   res.clearCookie('token');
//   //res.json({ message: 'Logout successful.'});
//   res.redirect('/');
// });


module.exports = router;