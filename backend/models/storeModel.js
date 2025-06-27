import pool from "../config/config.js";

const AllProducts = async () => {
    let [rows] = await pool.query("SELECT * FROM store");
    return rows
}

export {AllProducts}

