"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const pg_1 = require("pg");
const env_1 = require("./env");
const pool = new pg_1.Pool({
    connectionString: env_1.env.DB_URL
});
