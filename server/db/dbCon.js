const mysql = require('mysql')
const util = require('util')

//Create pool of connections
const dbCon = mysql.createPool({
    connectionLimit: 100,
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    user: process.env.DB_USER,
    password: process.env.DB_PW,
    database: "streetsmarts"
})

//Error handling
dbCon.getConnection((err, connection) => {
    if (err) {
        if (err.code === 'PROTOCOL_CONNECTION_LOST') {
            console.error('Database connection was closed.')
        }
        if (err.code === 'ER_CON_COUNT_ERROR') {
            console.error('Database has too many connections.')
        }
        if (err.code === 'ECONNREFUSED') {
            console.error('Database connection was refused.')
        }
        console.error(err)
    }
    if (connection) connection.release()
    return
})

//Allow .query to function with promises
dbCon.query = util.promisify(dbCon.query)

module.exports = dbCon
