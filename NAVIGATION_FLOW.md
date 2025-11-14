# Admin Application Management - Navigation Flow

## 📊 Navigation Structure

```
┌─ Dashboard (/dashboard)
│
├─ Jobs Management (/admin/jobs)
│  ├─ Job List
│  │  └─ [Click Job] → Job Details
│  │     └─ [View Applications] → /admin/applications/job/:jobId
│  │        ├─ Application List (Job-Specific)
│  │        └─ [Click Application Row] → /admin/applications/:id/details
│  │           ├─ Full Application Details
│  │           ├─ [Change Status] → Modal
│  │           └─ [Delete] → Confirmation
│  │
│  └─ Add/Edit Job
│
├─ Applications Management (/admin/applications) ← MAIN ENTRY POINT
│  │
│  ├─ Application List (All Jobs)
│  │  ├─ [View Details] → /admin/applications/:id/details
│  │  ├─ [Edit Status] → Modal
│  │  ├─ [Delete] → Confirmation
│  │  └─ Pagination (10 per page)
│  │
│  └─ Search/Filter
│     └─ By Job, Status, Date
│
├─ Application Details (/admin/applications/:id/details)
│  ├─ Job Information Card
│  ├─ Personal Information Card
│  ├─ Professional Experience Card
│  ├─ Education Card
│  ├─ Skills Card
│  ├─ Cover Letter Card
│  ├─ Attachments Card
│  ├─ Status Management (Sidebar)
│  └─ Actions (Delete Button)
│
├─ Scholarships Management
├─ Team Members Management
└─ Contact Inquiries
```

## 🔗 Route Mapping

### Application Routes (READ)

```
GET /admin/applications
├─ Returns: All applications (paginated)
├─ Display: applications.ejs
├─ Data:
│  ├─ applications[] (array)
│  ├─ currentPage (number)
│  ├─ totalPages (number)
│  ├─ totalApplications (number)
│  └─ applicationsPerPage (10)
└─ Each application includes: firstName, lastName, email, status, createdAt, job {}
```

```
GET /admin/applications/job/:jobId
├─ Returns: Applications for specific job (paginated)
├─ Display: job-applications.ejs
├─ Data:
│  ├─ applications[] (array)
│  ├─ job {} (job details)
│  ├─ currentPage (number)
│  ├─ totalPages (number)
│  ├─ totalApplications (number)
│  └─ applicationsPerPage (10)
└─ Shows: Job banner with context + filtered applications
```

```
GET /admin/applications/:id/details
├─ Returns: Single application with full details
├─ Display: application-details.ejs
├─ Data:
│  └─ application {}
│     ├─ id, firstName, lastName, email, phone, address
│     ├─ currentPosition, experience, expectedSalary, availableFrom
│     ├─ degree, university, graduationYear, gpa
│     ├─ skills, coverLetter, resume, portfolio
│     ├─ agreement, status, createdAt, updatedAt
│     └─ job {} (complete job details)
└─ Shows: All 7 cards with complete information
```

### Application Routes (UPDATE)

```
PATCH /admin/applications/:id/status
├─ Request: { status: "Pending|Reviewed|Shortlisted|Rejected|Accepted" }
├─ Validates: status is one of 5 valid values
├─ Updates: application.status in database
├─ Response: { success: true, message, application {} }
└─ Triggered by: Status modal in applications.ejs or application-details.ejs
```

### Application Routes (DELETE)

```
DELETE /admin/applications/:id
├─ Deletes: application record
├─ Updates: job.applicants counter (decrement by 1)
├─ Response: { success: true, message }
├─ Triggered by: Delete button + confirmation
└─ Maintains: Data integrity with foreign key cascade
```

### Application Routes (CREATE - Public)

```
POST /application-form
├─ Request: Form data from /job_details.ejs modal
├─ Validates:
│  ├─ Required: jobId, firstName, lastName, email, agreement
│  ├─ Checks: Job exists in database
│  └─ Checks: No duplicate (same email + jobId)
├─ Creates: Application record with all fields
├─ Updates: job.applicants counter (increment by 1)
├─ Response: { success: true, message, application {} }
└─ Triggered by: Application form submission on job details page
```

## 📄 View Files

### 1. `/views/admin/applications.ejs` (Main List)
```
Header
├─ Back Button (to admin area)
├─ Title: "Applications Management"
└─ Profile Menu

Content
├─ Stats Bar: Total Applications badge
├─ Table: 7 columns
│  ├─ Column 1: No (1-based numbering with pagination offset)
│  ├─ Column 2: Name (firstName + lastName)
│  ├─ Column 3: Email
│  ├─ Column 4: Job Title + Employer
│  ├─ Column 5: Status (color-coded badge)
│  ├─ Column 6: Date Applied (formatted date)
│  └─ Column 7: Actions (View, Edit Status, Delete)
├─ Pagination: Page numbers with Previous/Next
└─ Each row: Hover effects, clickable actions

Modals
└─ Status Update Modal
   ├─ Dropdown: 5 status options
   ├─ Cancel Button
   └─ Update Status Button
```

### 2. `/views/admin/job-applications.ejs` (Job-Specific)
```
Header
├─ Back Button (to /admin/jobs)
├─ Title: "Applications for [Job Title]"
└─ Profile Menu

Content
├─ Banner Card (gradient, blue)
│  ├─ Job Title
│  ├─ Company Name
│  ├─ Location
│  └─ Total Applications (large number)
├─ Table: Same 6 columns as main list (no "Job Title" column)
│  ├─ Column 1: No
│  ├─ Column 2: Name
│  ├─ Column 3: Email
│  ├─ Column 4: Status
│  ├─ Column 5: Date Applied
│  └─ Column 6: Actions
├─ Pagination: Same as main list
└─ Each row: Same hover and action behavior

Modals
└─ Status Update Modal (same as main list)
```

### 3. `/views/admin/application-details.ejs` (Full Details)
```
Header
├─ Back Button (to /admin/applications)
├─ Title: "Application Details"
└─ Profile Menu

Content: 2-Column Layout (responsive)

Left Column (Main Content - 7 Cards)
├─ Card 1: Job Information
│  ├─ Job Title
│  ├─ Employer
│  ├─ Location
│  └─ Salary
├─ Card 2: Personal Information
│  ├─ First Name
│  ├─ Last Name
│  ├─ Email
│  ├─ Phone
│  └─ Address
├─ Card 3: Professional Experience
│  ├─ Current Position
│  ├─ Years of Experience
│  ├─ Expected Salary
│  └─ Available From (date)
├─ Card 4: Education
│  ├─ Degree
│  ├─ University
│  ├─ Graduation Year
│  └─ GPA
├─ Card 5: Skills
│  └─ Skills (displayed as colored badges, comma-separated)
├─ Card 6: Cover Letter
│  └─ Full text with line breaks preserved
└─ Card 7: Attachments
   ├─ Resume (PDF icon, download link)
   └─ Portfolio (Link icon, external link)

Right Sidebar (Sticky - 3 Cards)
├─ Card 1: Application Status
│  ├─ Status Badge (color-coded)
│  └─ Change Status Button (opens modal)
├─ Card 2: Application Info
│  ├─ Application ID (#123)
│  ├─ Applied On (date)
│  └─ Last Updated (date)
└─ Card 3: Actions
   └─ Delete Application Button (red, with confirmation)
```

## 🎨 Color Scheme (Status Badges)

| Status | Background | Text | Icon | Use Case |
|--------|-----------|------|------|----------|
| Pending | Yellow-100 | Yellow-800 | 🕐 | Initial submission |
| Reviewed | Gray-100 | Gray-800 | — | Admin reviewed |
| Shortlisted | Blue-100 | Blue-800 | ⭐ | Moved to next round |
| Accepted | Green-100 | Green-800 | ✓ | Hired/Selected |
| Rejected | Red-100 | Red-800 | ✕ | Did not qualify |

## 📱 Responsive Breakpoints

- **Desktop** (1024px+): Full 2-column layout on details page
- **Tablet** (768px-1023px): 2-column with narrower sidebar
- **Mobile** (<768px): Single column, full width cards

## 🔐 Authentication

- All admin routes require `verifyAuth` middleware
- JWT token checked from `req.cookies.authToken`
- Unauthorized → Redirect to `/admin/login`

## ⚡ Client-Side Actions

### Status Update Flow
```
1. User clicks Edit Status button
2. Modal opens with current status selected
3. User selects new status from dropdown
4. User clicks "Update Status"
5. Fetch PATCH /admin/applications/:id/status
6. Success → Reload page
7. Error → Show alert
```

### Delete Flow
```
1. User clicks Delete button
2. Confirmation dialog
3. If confirmed → Fetch DELETE /admin/applications/:id
4. Success → Reload page (deleted row removed)
5. Error → Show alert
```

## 📊 Data Display Examples

### Table Row (applications.ejs)
```
1 | John Smith | john@example.com | Senior Developer @ Acme Inc | ⭐ Shortlisted | 2024-01-15 | 👁️ ✏️ 🗑️
```

### Job Banner (job-applications.ejs)
```
┌────────────────────────────────────────┐
│ Senior Developer │ Acme Inc │ New York │ 42 │
└────────────────────────────────────────┘
```

## 🔄 Data Flow

### Application Submission → Admin Listing
```
1. User submits form on /job_details.ejs
2. POST /application-form receives data
3. Server validates & creates Application record
4. Server increments job.applicants counter
5. User sees success message
6. Admin navigates to /admin/applications
7. Sees new application in table (latest first)
```

### Status Update Flow
```
1. Admin clicks "Edit Status" on applications table
2. Modal opens with status dropdown
3. Admin selects new status
4. PATCH /admin/applications/:id/status sent
5. Server validates status value
6. Server updates application.status
7. Page reloads with new badge color
```

### Delete Flow
```
1. Admin clicks Delete button
2. Confirmation: "Are you sure?"
3. DELETE /admin/applications/:id sent
4. Server deletes application
5. Server decrements job.applicants
6. Page reloads (row removed from table)
```

## 📋 Summary

**3 Admin Views Created:**
1. ✅ `/views/admin/applications.ejs` - All applications (paginated, 10/page)
2. ✅ `/views/admin/job-applications.ejs` - Job-specific (paginated, 10/page)
3. ✅ `/views/admin/application-details.ejs` - Full details with sidebar

**5 Backend Routes (Already Complete):**
1. ✅ GET /admin/applications - List all
2. ✅ GET /admin/applications/job/:jobId - Filter by job
3. ✅ GET /admin/applications/:id/details - View details
4. ✅ PATCH /admin/applications/:id/status - Update status
5. ✅ DELETE /admin/applications/:id - Delete application

**Database:**
- ✅ Application model with 18 fields
- ✅ JobId foreign key with cascade delete
- ✅ Status field with 5 valid values
- ✅ Timestamps for audit trail

**Features:**
- ✅ Color-coded status badges
- ✅ Pagination (10 per page)
- ✅ Responsive design with dark mode
- ✅ Modal dialogs for updates
- ✅ Confirmation dialogs for deletion
- ✅ Full CRUD operations
- ✅ Job context and filtering
