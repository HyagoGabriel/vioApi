const mysql = require("mysql2");

const pool = mysql.createPool({
    connectionLimit:10,
    host:'localhost',
    user:'alunods',
    password:'ma@12345',
    database:'vio_hyago'
})

module.exports = pool;