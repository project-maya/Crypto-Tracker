use worker::*;

pub async fn router(_req: Request, _env: Env) -> Result<Response> {
    // TODO: implement price fetch + KV store logic here
    Response::ok("Crypto Tracker API OK")
}