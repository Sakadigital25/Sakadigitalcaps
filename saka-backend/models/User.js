const mongoose = require("mongoose");  // Pastikan ini ada di bagian atas file

const userSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  email: {
    type: String,
    required: true,
    unique: true,
  },
  password: {
    type: String,
    required: true,
  },
  role: {
    type: String,
    enum: ["Siaga", "Penggalang", "Penegak", "Pandega"],
    default: "Siaga",
  },
  provinsi: {
    type: String,
    required: false,
  },
  kota: {
    type: String,
    required: false,
  },
  sekolah: {
    type: String,
    required: false,
  },
});

const User = mongoose.model("User", userSchema);

module.exports = User;
