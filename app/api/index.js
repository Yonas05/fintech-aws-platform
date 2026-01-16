const express = require("express");
const { Pool } = require("pg");

const app = express();
const port = 8080;

const pool = new Pool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER || "fintechuser",
  database: process.env.DB_NAME || "fintechdb",
  password: process.env.DB_PASSWORD,
  port: 5432,
  ssl: { rejectUnauthorized: false }
});

app.get("/health", async (req, res) => {
  try {
    const client = await pool.connect();
    const result = await client.query("SELECT 'ok' as status");
    client.release();
    res.json({ status: result.rows[0].status });
  } catch (e) {
    res.status(500).json({ status: "db-failed" });
  }
});

app.listen(port, () => console.log(`API listening on ${port}`));