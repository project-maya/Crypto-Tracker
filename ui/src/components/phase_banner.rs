use dioxus::prelude::*;

#[component]
pub fn PhaseBanner() -> Element {
    rsx! {
        div {
            style: "background: #f0f4ff; padding: 1rem; border-bottom: 1px solid #ccc;",
            h2 { "📦 Phase v1.1.1 – UI Baseline" }
            p { "This UI is powered by:" }
            ul {
                li { "🦀 Rust" }
                li { "⚡ Cloudflare Workers via workers-rs" }
                li { "🎨 Dioxus 0.6.3" }
                li { "📊 Binance REST API (price snapshots)" }
                li { "🗄️ Cloudflare D1 & KV" }
            }
        }
    }
}
