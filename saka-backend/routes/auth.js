const express = require("express");
const router = express.Router();
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const User = require("../models/User");

// Register User
router.post('/register', async (req, res) => {
  const { name, email, password, role } = req.body;

  // Validasi: Pastikan semua data yang diperlukan ada
  if (!name || !email || !password || !role) {
    return res.status(400).json({ message: "Semua field harus diisi!" });
  }

  try {
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.status(400).json({ message: "Email sudah terdaftar!" });
    }

    const hashedPassword = await bcrypt.hash(password, 10);
    const newUser = new User({
      name,
      email,
      password: hashedPassword,
      role: role || "Siaga",  // Default role jika tidak ada
    });

    await newUser.save();
    res.status(201).json({ message: "User berhasil dibuat" });
  } catch (err) {
    res.status(500).json({ message: "Terjadi kesalahan saat mendaftar", error: err.message });
  }
});

// Login User
router.post('/login', async (req, res) => {
  const { email, password } = req.body;

  // Validasi input
  if (!email || !password) {
    return res.status(400).json({ message: "Email dan password harus diisi!" });
  }

  try {
    // Cari user berdasarkan email
    const user = await User.findOne({ email });
    if (!user) {
      return res.status(400).json({ message: "Email atau password salah!" });
    }

    // Verifikasi password
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ message: "Email atau password salah!" });
    }

    // Buat JWT token
    const token = jwt.sign(
      { 
        userId: user._id,
        email: user.email,
        role: user.role 
      },
      process.env.JWT_SECRET,
      { expiresIn: '24h' }
    );

    res.json({
      token,
      user: {
        id: user._id,
        name: user.name,
        email: user.email,
        role: user.role
      }
    });
  } catch (err) {
    res.status(500).json({ message: "Terjadi kesalahan saat login", error: err.message });
  }
});

module.exports = router;
