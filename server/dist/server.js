"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const app_1 = require("./app");
const PORT = 3131;
app_1.app.listen(PORT, () => {
    console.log(`the server is running ${PORT}`);
});
