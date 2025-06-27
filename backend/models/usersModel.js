import pool from "../config/config.js";

const AllUsers = async () => {
  const [data] = await pool.execute('SELECT * FROM users');
  return data;
};

const addUser = async (name, email, password, address, age, gender, phone) => {
  await pool.query(
    'INSERT INTO users (name, email, password, address, age, gender, phone) VALUES (?, ?, ?, ?, ?, ?, ?)',
    [name, email, password, address, age, gender, phone]
  );
};

const updateUser = async (name, email, password, address, age, gender, phone) => {
  if (password) {
    await pool.query(
      'UPDATE users SET name = ?, address = ?, age = ?, gender = ?, phone = ?, password = ? WHERE email = ?',
      [name, address, age, gender, phone, password, email]
    );
  } else {
  await pool.query(
    'UPDATE users SET name = ?, address = ?, age = ?, gender = ?, phone = ? WHERE email = ?',
    [name, address, age, gender, phone, email]
  );
}
};


export const getUserByUsername = async (name) => {
  const [rows] = await pool.query('SELECT * FROM users WHERE name = ?', [name]);
  return rows[0];
};

export { AllUsers, addUser, updateUser};