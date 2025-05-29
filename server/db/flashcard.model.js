const mongoose = require("mongoose");

const { Schema } = mongoose;

const FlashCardSchema = new Schema({
  question: String,
  answer: String,
  createdAt: {
    type: Date,
    default: Date.now,
  },
});

module.exports = mongoose.model("FlashCard", FlashCardSchema);