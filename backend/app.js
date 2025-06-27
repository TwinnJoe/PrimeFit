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
app.use(express.static("public"));
app.use(cors());
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
