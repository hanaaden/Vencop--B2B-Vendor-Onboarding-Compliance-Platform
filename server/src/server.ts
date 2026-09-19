import {app, select} from "./app"
import {env} from "./config/env"


app.listen(env.port, ()=>{
    console.log(`the server is running ${env.port}`)
  const call = async ()=>{
   const get = await select()
 console.log(get )

  }
  return call()
})

