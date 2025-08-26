import dotenv from "dotenv";
dotenv.config();
import express from "express";
import cors from "cors";
import bodyParser from 'body-parser';

import storeRouter from "./routes/storeRouter.js"
import usersRouter from "./routes/usersRouter.js"
import plansRouter from "./routes/plansRouter.js"
import trainersRouter from "./routes/trainersRouter.js"



const app = express();

const FRONTEND_URL = process.env.FRONTEND_URL;

app.use(cors({
  origin: FRONTEND_URL,      // allow only my frontend
  methods: ["GET","POST","PUT","DELETE","OPTIONS"],
  credentials: true           // needed if I use cookies/auth headers
}));

// Handle preflight requests
app.options("*", cors({
  origin: FRONTEND_URL,
  methods: ["GET","POST","PUT","DELETE","OPTIONS"],
  credentials: true
}));


app.use(bodyParser.json());
app.use(express.json());

app.use("/api/store", storeRouter);
app.use("/api/users", usersRouter);
app.use("/api/plans", plansRouter);
app.use("/api/trainers", trainersRouter);

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log(`Server is running at http://localhost:${PORT}`);
});
