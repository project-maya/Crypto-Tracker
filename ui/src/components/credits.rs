use dioxus::prelude::*;

#[component]
pub fn Credits() -> Element {
    // Hard‑coded list for now
    let credits = vec![
        ("🔗", "Dioxus", "https://dioxuslabs.com/"),
        ("🔗", "Rust", "https://www.rust-lang.org/"),
        ("🔗", "Cloudflare Workers", "https://workers.cloudflare.com/"),
    ];

    rsx! {
        ul {
            for (emoji, name, url) in credits {
                li {
                    a {
                        href: "{url}",
                        target: "_blank",
                        rel: "noopener noreferrer",
                        "{emoji} {name}"
                    }
                }
            }
        }
    }
}
// Note: In a real application, you might want to load this data from a JSON file or an API.
// For simplicity, we're hardcoding it here.