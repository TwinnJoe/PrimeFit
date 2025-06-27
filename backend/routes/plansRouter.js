import express from "express";
import {PlansCon} from "../controllers/plansController.js";

const router = express.Router();

router.get("/", PlansCon);

export default router;