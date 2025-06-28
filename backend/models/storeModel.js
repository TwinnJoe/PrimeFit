import pool from "../config/config.js";

const AllProducts = async () => {
    let [rows] = await pool.query("SELECT * FROM store");
    return rows
}catch (err) {
    console.error("❌ SQL ERROR in AllProducts:", err); // Log full SQL error
    throw err; // Let the controller catch it
  }
};

export {AllProducts}

