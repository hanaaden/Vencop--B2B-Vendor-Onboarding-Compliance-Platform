import "dotenv/config"

function getEnv(name : string): string{
    const value= process.env[name]

    if(!value){
        throw new Error  (`missing env variable: ${name}`)
    }
    return value
} 
export const env={
    port : Number(getEnv("PORT")),
    DATABASE_URL : getEnv("DATABASE_URL")
}