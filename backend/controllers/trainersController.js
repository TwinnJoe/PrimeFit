import {AllTrainers} from "../models/trainersModel.js";

const AllTrainersCon = async (req, res) => {
  try {
    res.json(await AllTrainers());
  } catch (err) {
    console.error(err);
    res.status(500).json({
      error: "There was an error while getting Trainers",
    });
  }
};

export {AllTrainersCon};