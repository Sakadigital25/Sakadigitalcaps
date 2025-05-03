const express = require("express");
const router = express.Router();
const bcrypt = require("bcryptjs");
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

module.exports = router;
