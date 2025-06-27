import {AllProducts} from "../models/storeModel.js";

const AllProductsCon = async (req, res) => {
    try {
        res.status(200).json(await AllProducts());
    } catch (err) {
        console.error(err);
        res.status(500).json({
            error:"There was an error while getting all products"
        })
    }
}

export {AllProductsCon};