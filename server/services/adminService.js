const { prisma } = require('../config/db');
const bcrypt = require('bcrypt');

// Create a new admin
const createAdmin = async (full_name, email, password) => {
  try {
    // Hash the password
    const hashedPassword = await bcrypt.hash(password, 10);

    const admin = await prisma.admin.create({
      data: {
        full_name,
        email,
        password: hashedPassword,
      },
    });

    return admin;
  } catch (error) {
    throw new Error(`Error creating admin: ${error.message}`);
  }
};

// Get admin by email
const getAdminByEmail = async (email) => {
  try {
    const admin = await prisma.admin.findUnique({
      where: { email },
    });
    return admin;
  } catch (error) {
    throw new Error(`Error fetching admin: ${error.message}`);
  }
};

// Get admin by ID
const getAdminById = async (id) => {
  try {
    const admin = await prisma.admin.findUnique({
      where: { id },
    });
    return admin;
  } catch (error) {
    throw new Error(`Error fetching admin: ${error.message}`);
  }
};

// Get all admins
const getAllAdmins = async () => {
  try {
    const admins = await prisma.admin.findMany();
    return admins;
  } catch (error) {
    throw new Error(`Error fetching admins: ${error.message}`);
  }
};

// Update admin
const updateAdmin = async (id, data) => {
  try {
    // If password is being updated, hash it
    if (data.password) {
      data.password = await bcrypt.hash(data.password, 10);
    }

    const admin = await prisma.admin.update({
      where: { id },
      data,
    });

    return admin;
  } catch (error) {
    throw new Error(`Error updating admin: ${error.message}`);
  }
};

// Delete admin
const deleteAdmin = async (id) => {
  try {
    const admin = await prisma.admin.delete({
      where: { id },
    });
    return admin;
  } catch (error) {
    throw new Error(`Error deleting admin: ${error.message}`);
  }
};

// Verify password
const verifyPassword = async (plainPassword, hashedPassword) => {
  try {
    return await bcrypt.compare(plainPassword, hashedPassword);
  } catch (error) {
    throw new Error(`Error verifying password: ${error.message}`);
  }
};

module.exports = {
  createAdmin,
  getAdminByEmail,
  getAdminById,
  getAllAdmins,
  updateAdmin,
  deleteAdmin,
  verifyPassword,
};
