const mysql = require("mysql2");

const pool = mysql.createPool({
  connectionLimit: 10,
  host: process.env.MYSQLHOST || process.env.DB_HOST,
  user: process.env.MYSQLHOST || process.env.DB_USER,
  password: process.env.MYSQLPASSOWORD || process.env.DB_PASSWORD,
  database: process.env.MYSQLHOST || process.env.DB_NAME,
  port: process.env.MYSQLPORT || 3306,
});

module.exports = pool;
