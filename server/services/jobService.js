const { prisma } = require('../config/db');

/**
 * Create a new job
 */
exports.createJob = async (jobData) => {
  try {
    const newJob = await prisma.job.create({
      data: jobData
    });
    return newJob;
  } catch (error) {
    throw new Error(`Error creating job: ${error.message}`);
  }
};

/**
 * Get all jobs
 */
exports.getAllJobs = async () => {
  try {
    const jobs = await prisma.job.findMany({
      orderBy: { createdAt: 'desc' }
    });
    return jobs;
  } catch (error) {
    throw new Error(`Error fetching jobs: ${error.message}`);
  }
};

/**
 * Get job by ID
 */
exports.getJobById = async (id) => {
  try {
    const job = await prisma.job.findUnique({
      where: { id: parseInt(id) }
    });
    return job;
  } catch (error) {
    throw new Error(`Error fetching job: ${error.message}`);
  }
};

/**
 * Update job
 */
exports.updateJob = async (id, jobData) => {
  try {
    const updatedJob = await prisma.job.update({
      where: { id: parseInt(id) },
      data: jobData
    });
    return updatedJob;
  } catch (error) {
    throw new Error(`Error updating job: ${error.message}`);
  }
};

/**
 * Delete job
 */
exports.deleteJob = async (id) => {
  try {
    const deletedJob = await prisma.job.delete({
      where: { id: parseInt(id) }
    });
    return deletedJob;
  } catch (error) {
    throw new Error(`Error deleting job: ${error.message}`);
  }
};

/**
 * Get jobs by status
 */
exports.getJobsByStatus = async (status) => {
  try {
    const jobs = await prisma.job.findMany({
      where: { status },
      orderBy: { createdAt: 'desc' }
    });
    return jobs;
  } catch (error) {
    throw new Error(`Error fetching jobs by status: ${error.message}`);
  }
};
