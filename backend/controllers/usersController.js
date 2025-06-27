// 📁 controllers/usersController.js
import jwt from 'jsonwebtoken';
import bcrypt from 'bcrypt';
import { AllUsers, addUser, updateUser, getUserByUsername } from '../models/usersModel.js';

const JWT_SECRET = 'fdd6733c6254ae9e10a2dd003741e0ae8b9f1a5726face4067c6a4d74d9a9d385df81db438ee3ff0ded74b9bd46fc44a426f22418262d20ff65cd4976d5e789b';


const AllUsersCon = async (req, res) => {
  try {
    res.json(await AllUsers());
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: 'Failed to fetch users' });
  }
};

const registerUserCon = async (req, res) => {
  const { email, password } = req.body;
  try {
    const hashedPassword = await bcrypt.hash(password, 10);

    // Call your DB function to insert user with minimal fields
    await addUser(null, email, hashedPassword, null, null, null, null);

    res.status(201).json({ message: 'User registered successfully' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Failed to register user' });
  }
};

const updateUserCon = async (req, res) => {
  let { name, email, password, address, age, gender, phone } = req.body;
  try {
    let hashedPassword = null;
    if (password) {
      hashedPassword = await bcrypt.hash(password, 10);
    } 
    await updateUser(name, email, password, address, age, gender, phone);
    res.json({ message: 'User added successfully' });
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: 'Failed to subscribe' });
  }
};

// LOGIN CONTROLLER
const loginUserCon = async (req, res) => {
  const { username, password } = req.body;
  try {
    const user = await getUserByUsername(username);
    if (!user) {
      return res.status(401).json({ error: 'Invalid username or password' });
    }

    const validPassword = await bcrypt.compare(password, user.password);
    if (!validPassword) {
      return res.status(401).json({ error: 'Invalid username or password' });
    }

    const token = jwt.sign(
      { user_id: user.user_id, username: user.name },
      JWT_SECRET,
      { expiresIn: '1h' }
    );

    res.json({ message: 'Login successful', token, user: { username: user.name } });
  } catch (error) {
    console.log(error);
    res.status(500).json({ error: 'Server error' });
  }
};

export {
  AllUsersCon,
  registerUserCon,
  updateUserCon,
  loginUserCon
};
