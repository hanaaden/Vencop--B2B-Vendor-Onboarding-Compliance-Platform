import express from "express"
import { pool } from "./config/database";

export const app = express();

app.use(express.json())

export const select = async ()=>{
 const d = await pool.query(`SELECT NOW()`)
 return d.rows[0]
}

app.get('/health' , (_ , res)=>{
   res.json("the app is healthy")
})