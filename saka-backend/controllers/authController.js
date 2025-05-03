const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const User = require("../models/User");

// Registrasi User
const registerUser = async (req, res) => {
  const { name, email, password, role, provinsi, kota, sekolah } = req.body;

  // Validasi input, pastikan role valid
  if (!role || !['Siaga', 'Penggalang', 'Penegak', 'Pandega'].includes(role)) {
    return res.status(400).json({ message: 'Role tidak valid' });
  }

  try {
    // Cek apakah user sudah ada
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.status(400).json({ message: "User already exists" });
    }

    // Enkripsi password
    const hashedPassword = await bcrypt.hash(password, 10);

    // Buat user baru
    const newUser = new User({
      name,
      email,
      password: hashedPassword,
      role,         // Menggunakan 'role' yang diterima dari frontend
      provinsi,
      kota,
      sekolah,
    });

    // Simpan user ke database
    await newUser.save();

    // Buat token JWT
    const token = jwt.sign({ userId: newUser._id }, process.env.JWT_SECRET, { expiresIn: "1h" });

    // Kirim response berhasil
    res.status(201).json({
      message: "User registered successfully",
      token,
    });
  } catch (err) {
    console.error("Registration error:", err);
    res.status(500).json({ message: "Server error", error: err.message });
  }
};

module.exports = { registerUser };
