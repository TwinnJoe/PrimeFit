import {Plans} from "../models/plansModel.js";

const PlansCon = async (req, res) => {
    try {
      res.status(200).json(await Plans());
    } catch (err) {
      console.error(err);
      res.status(500).json({
        error: "There was an error while getting Subscriptions",
      });
    }
  };
export {PlansCon};