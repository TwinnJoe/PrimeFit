import pool from "../config/config.js";

const AllTrainers = async () => {
    let [rows] = await pool.query("SELECT * FROM trainers");
    return rows
}

export {AllTrainers};

