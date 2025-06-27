import express from "express";
import {AllUsersCon, registerUserCon,  updateUserCon, loginUserCon} from "../controllers/usersController.js";

const router = express.Router();

router.get('/', AllUsersCon);
router.post('/register', registerUserCon);
router.put('/profile', updateUserCon);

// Login route
router.post('/login', loginUserCon);

export default router;