var mysql = require('mysql');
var pool = mysql.createPool({
  connectionLimit : 10,
  host            : 'hostname.engr.oregonstate.edu',
  user            : 'username',
  password        : 'password',
  database        : 'database_username'
});
module.exports.pool = pool;
