import express from "express";
import {AllTrainersCon} from "../controllers/trainersController.js";

const router = express.Router();

router.get("/", AllTrainersCon);

export default router;