const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
require("dotenv").config(); // Pastikan dotenv sudah di-setup

const app = express();
const port = process.env.PORT || 5000;

// Middleware
app.use(cors());
app.use(express.json());

// Koneksi ke MongoDB
mongoose
  .connect(process.env.MONGO_URI)
  .then(() => console.log("MongoDB connected"))
  .catch((err) => {
    console.error("MongoDB connection failed ❌", err);
  });

// Routes
const authRoutes = require("./routes/auth");
app.use("/api/auth", authRoutes);

// Jalankan server
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
