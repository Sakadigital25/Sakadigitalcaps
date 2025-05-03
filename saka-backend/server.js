const express = require("express");
const cors = require("cors");
require("dotenv").config(); // Pastikan dotenv sudah di-setup
const connectDB = require("./config/db");
 // Impor koneksi ke DB

const app = express();
const port = process.env.PORT || 5000;
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});

// Middleware
app.use(cors());
app.use(express.json());

// Koneksi ke MongoDB
connectDB(); // Memanggil koneksi ke DB

// Routes
const authRoutes = require("./routes/auth");
app.use("/api/auth", authRoutes);

// Jalankan server
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
