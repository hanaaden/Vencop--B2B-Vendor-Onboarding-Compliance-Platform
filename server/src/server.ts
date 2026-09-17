import {app} from "./app"
import {env} from "./config/env"


app.listen(env.port, ()=>{
    console.log(`the server is running ${env.port}`)
})