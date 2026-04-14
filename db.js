import mongoose from 'mongoose';
import fs from 'fs';

export async function connectMongo() {
  const host = process.env.MONGO_HOST || 'mongodb';
  const db = process.env.MONGO_DB || 'appdb';
  const user = process.env.MONGO_USER || 'appuser';

  let password;

  if (process.env.MONGO_PASSWORD_FILE) {
    // ✅ Read from Docker secret file
    password = fs.readFileSync(process.env.MONGO_PASSWORD_FILE, 'utf8').trim();
  } else {
    // ✅ fallback (for local/dev)
    password = process.env.MONGO_PASSWORD || 'root123';
  }

  const uri = `mongodb://${user}:${encodeURIComponent(password)}@${host}:27017/${db}?authSource=admin`;

  await mongoose.connect(uri, {
    serverSelectionTimeoutMS: 5000,
  });

  console.log('✅ Connected to MongoDB');
}