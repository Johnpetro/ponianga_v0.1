const { PrismaClient } = require('@prisma/client');
const bcrypt = require('bcrypt');

const prisma = new PrismaClient();

const jobsData = [
  {
    jobTitle: 'Senior Frontend Developer',
    employer: 'Tech Corp Inc',
    jobType: 'Full-time',
    location: 'New York, USA',
    deadline: new Date('2025-12-31'),
    applicants: 12,
    salary: '$120k - $150k',
    skills: 'React, TypeScript, UI/UX',
    description: 'We are looking for an experienced Frontend Developer to build scalable web applications using modern technologies.',
    status: 'Active'
  },
  {
    jobTitle: 'Backend Engineer',
    employer: 'Digital Solutions Ltd',
    jobType: 'Remote',
    location: 'Remote',
    deadline: new Date('2025-01-15'),
    applicants: 8,
    salary: '$100k - $130k',
    skills: 'Node.js, PostgreSQL, API Design',
    description: 'Join our backend team to develop robust APIs and microservices. Work with latest technologies and best practices.',
    status: 'Active'
  },
  {
    jobTitle: 'Data Scientist',
    employer: 'Analytics Pro',
    jobType: 'Part-time',
    location: 'San Francisco, USA',
    deadline: new Date('2024-12-20'),
    applicants: 5,
    salary: '$90k - $120k',
    skills: 'Python, Machine Learning, TensorFlow',
    description: 'Help us build intelligent systems using machine learning and data analytics. Analyze and solve complex data problems.',
    status: 'Pending'
  },
  {
    jobTitle: 'UX/UI Designer',
    employer: 'Design Studio Co',
    jobType: 'Full-time',
    location: 'London, UK',
    deadline: new Date('2024-12-10'),
    applicants: 25,
    salary: '£50k - £70k',
    skills: 'Figma, UI/UX, Adobe XD',
    description: 'Create beautiful and intuitive user experiences. Design user interfaces for web and mobile applications.',
    status: 'Closed'
  },
  {
    jobTitle: 'Full Stack Developer',
    employer: 'StartUp Innovations',
    jobType: 'Full-time',
    location: 'San Francisco, USA',
    deadline: new Date('2025-01-30'),
    applicants: 18,
    salary: '$110k - $140k',
    skills: 'JavaScript, React, Node.js, MongoDB',
    description: 'Build end-to-end web applications for our innovative startup. Work with cutting-edge technologies.',
    status: 'Active'
  },
  {
    jobTitle: 'DevOps Engineer',
    employer: 'Cloud Systems Inc',
    jobType: 'Full-time',
    location: 'Seattle, USA',
    deadline: new Date('2025-02-10'),
    applicants: 7,
    salary: '$130k - $160k',
    skills: 'Docker, Kubernetes, AWS, CI/CD',
    description: 'Manage infrastructure and deployment pipelines. Ensure system reliability and scalability.',
    status: 'Active'
  },
  {
    jobTitle: 'Mobile App Developer',
    employer: 'AppWorks Studio',
    jobType: 'Contract',
    location: 'Austin, USA',
    deadline: new Date('2024-12-28'),
    applicants: 11,
    salary: '$80k - $110k',
    skills: 'React Native, iOS, Android',
    description: 'Develop cross-platform mobile applications for iOS and Android. Create engaging user experiences.',
    status: 'Active'
  },
  {
    jobTitle: 'Product Manager',
    employer: 'Tech Ventures',
    jobType: 'Full-time',
    location: 'Boston, USA',
    deadline: new Date('2025-01-20'),
    applicants: 22,
    salary: '$100k - $130k',
    skills: 'Product Strategy, Analytics, Communication',
    description: 'Lead product strategy and roadmap. Work with cross-functional teams to deliver great products.',
    status: 'Active'
  },
  {
    jobTitle: 'Security Specialist',
    employer: 'CyberSafe Solutions',
    jobType: 'Full-time',
    location: 'Toronto, Canada',
    deadline: new Date('2025-02-05'),
    applicants: 9,
    salary: '$120k - $150k',
    skills: 'Cybersecurity, Penetration Testing, Network Security',
    description: 'Protect our systems and data from security threats. Implement security best practices and solutions.',
    status: 'Active'
  },
  {
    jobTitle: 'QA Automation Engineer',
    employer: 'Quality Tech',
    jobType: 'Full-time',
    location: 'Berlin, Germany',
    deadline: new Date('2024-12-25'),
    applicants: 6,
    salary: '€70k - €90k',
    skills: 'Selenium, Python, Test Automation',
    description: 'Develop automated testing frameworks. Ensure software quality through comprehensive testing strategies.',
    status: 'Active'
  }
];

const scholarshipsData = [
  {
    programName: 'Engineering Excellence Scholarship',
    collegeName: 'Massachusetts Institute of Technology',
    sponsorship: 'Full',
    vacancy: '5 Scholarships',
    deadline: new Date('2025-03-31'),
    description: 'Full scholarship covering tuition, room, and board for engineering students with exceptional academic records.',
    requirements: 'GPA 3.8+, SAT 1500+, essay, STEM focused, US citizen or permanent resident',
    status: 'Active'
  },
  {
    programName: 'Global Scholars Programme',
    collegeName: 'University of Oxford',
    sponsorship: 'Partial',
    vacancy: '10 Scholarships',
    deadline: new Date('2025-04-15'),
    description: 'Partial scholarship for international students pursuing postgraduate studies across all disciplines.',
    requirements: 'Bachelor degree, strong academic performance, demonstrated financial need, leadership experience',
    status: 'Active'
  },
  {
    programName: 'Business Leaders Initiative',
    collegeName: 'Harvard Business School',
    sponsorship: 'Full',
    vacancy: '3 Scholarships',
    deadline: new Date('2025-02-28'),
    description: 'Prestigious full scholarship for MBA students showing exceptional potential in business leadership.',
    requirements: 'GMAT 700+, 3+ years professional experience, strong leadership record, US citizen preferred',
    status: 'Active'
  },
  {
    programName: 'Medical Excellence Award',
    collegeName: 'Stanford University School of Medicine',
    sponsorship: 'Full',
    vacancy: '8 Scholarships',
    deadline: new Date('2025-05-31'),
    description: 'Full tuition scholarship for MD program students committed to primary care and underserved communities.',
    requirements: 'MCAT 520+, GPA 3.7+, volunteer in healthcare, commitment to serving disadvantaged populations',
    status: 'Active'
  },
  {
    programName: 'Tech Innovators Fund',
    collegeName: 'California Institute of Technology',
    sponsorship: 'Partial',
    vacancy: '15 Scholarships',
    deadline: new Date('2025-03-15'),
    description: 'Partial scholarships for computer science and engineering students with innovative project ideas.',
    requirements: 'GPA 3.6+, demonstrated programming skills, innovation project or GitHub portfolio, essay',
    status: 'Pending'
  },
  {
    programName: 'Arts and Humanities Grant',
    collegeName: 'Yale University',
    sponsorship: 'Partial',
    vacancy: '20 Scholarships',
    deadline: new Date('2025-04-30'),
    description: 'Partial scholarships supporting talented students in arts, literature, philosophy, and humanities.',
    requirements: 'Strong portfolio or writing samples, GPA 3.5+, essay on academic interests, demonstrated passion for field',
    status: 'Active'
  },
  {
    programName: 'STEM Women Empowerment',
    collegeName: 'Carnegie Mellon University',
    sponsorship: 'Full',
    vacancy: '12 Scholarships',
    deadline: new Date('2025-03-01'),
    description: 'Full scholarship exclusively for female students pursuing STEM fields to promote gender diversity.',
    requirements: 'Female applicants, GPA 3.7+, STEM focus, leadership experience, commitment to mentoring other women',
    status: 'Active'
  },
  {
    programName: 'Public Service Scholars',
    collegeName: 'Princeton University',
    sponsorship: 'Full',
    vacancy: '7 Scholarships',
    deadline: new Date('2025-04-20'),
    description: 'Full scholarship for undergraduate students committed to careers in public service and social justice.',
    requirements: 'Demonstrated commitment to public service, strong academics, leadership in community work, interview',
    status: 'Active'
  },
  {
    programName: 'International Excellence Scholarship',
    collegeName: 'University of Cambridge',
    sponsorship: 'Partial',
    vacancy: '25 Scholarships',
    deadline: new Date('2025-05-15'),
    description: 'Partial scholarships for outstanding international undergraduate and postgraduate students.',
    requirements: 'International applicant, strong academic credentials, demonstrated excellence, subject-specific merit',
    status: 'Active'
  },
  {
    programName: 'Environmental Studies Fellowship',
    collegeName: 'University of British Columbia',
    sponsorship: 'Full',
    vacancy: '6 Scholarships',
    deadline: new Date('2025-02-15'),
    description: 'Full scholarship for graduate students researching climate change and environmental sustainability.',
    requirements: 'Master or PhD applicant, research focus on environment, strong academics, research proposal',
    status: 'Closed'
  }
];

async function main() {
  try {
    // Check if admin already exists
    const existingAdmin = await prisma.admin.findUnique({
      where: { email: 'admin@example.com' }
    });

    if (!existingAdmin) {
      // Hash the password
      const hashedPassword = await bcrypt.hash('admin123', 10);

      // Create the admin user
      const admin = await prisma.admin.create({
        data: {
          full_name: 'Admin User',
          email: 'admin@example.com',
          password: hashedPassword
        }
      });

      console.log('✓ Admin user created successfully!');
      console.log(`  Email: ${admin.email}`);
      console.log(`  Full Name: ${admin.full_name}`);
    } else {
      console.log('✓ Admin user already exists (admin@example.com)');
    }

    // Check if jobs already exist
    const existingJobsCount = await prisma.job.count();
    
    if (existingJobsCount === 0) {
      // Create all jobs
      for (const jobData of jobsData) {
        await prisma.job.create({
          data: jobData
        });
      }

      console.log(`\n✓ ${jobsData.length} sample jobs created successfully!`);
      console.log('  Jobs include various positions across different roles and locations.');
    } else {
      console.log(`\n✓ Jobs already exist in database (${existingJobsCount} jobs found)`);
    }

    // Check if scholarships already exist
    const existingScholarshipsCount = await prisma.scholarship.count();

    if (existingScholarshipsCount === 0) {
      // Create all scholarships
      for (const scholarshipData of scholarshipsData) {
        await prisma.scholarship.create({
          data: scholarshipData
        });
      }

      console.log(`\n✓ ${scholarshipsData.length} sample scholarships created successfully!`);
      console.log('  Scholarships include various prestigious programs from top universities worldwide.');
    } else {
      console.log(`\n✓ Scholarships already exist in database (${existingScholarshipsCount} scholarships found)`);
    }

  } catch (error) {
    console.error('✗ Error seeding data:', error.message);
    process.exit(1);
  }
}

main()
  .catch(error => {
    console.error(error);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });