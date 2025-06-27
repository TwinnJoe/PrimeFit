import express from "express";
import {AllProductsCon} from "../controllers/storeController.js";

const router = express.Router();

router.get("/", AllProductsCon);

export default router;