"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.env = void 0;
require("dotenv/config");
function getEnv(name) {
    const value = process.env[name];
    if (!value) {
        throw new Error(`missing env variable: ${name}`);
    }
    return value;
}
exports.env = {
    port: Number(getEnv("PORT")),
    DB_URL: getEnv("DB_URL")
};
