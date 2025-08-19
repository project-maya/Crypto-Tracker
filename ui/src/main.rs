use dioxus::prelude::*;
mod components;
use components::phase_banner::PhaseBanner;
use components::credits::Credits;

fn main() {
    // For quick start, just launch straight from dioxus
    launch(App);
}

#[component]
fn App() -> Element {
    rsx! {
        PhaseBanner {}
        div {
            style: "padding: 2rem;",
            h1 { "Welcome to the Crypto Tracker UI" }
            p { "This is the beginning of your reproducible, Shariah-compliant frontend." }
            Credits {}
        }
    }
}