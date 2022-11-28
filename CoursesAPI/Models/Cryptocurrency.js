const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const Crypto = new Schema ({

  price:
  {
    type: Number,
    required: true
  },
  coinName: 
  {
    type: String,
    required: true
  },
  coinTicker:
  {
    type: String,
    required: true
  }
});

mongoose.model('Crypto', Crypto);