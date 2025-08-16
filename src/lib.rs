use worker::*;
use console_error_panic_hook;

mod routes;

#[event(fetch)]
pub async fn main(req: Request, env: Env, _ctx: worker::Context) -> Result<Response> {
    console_error_panic_hook::set_once();
    routes::router(req, env).await
}