use std::collections::HashMap;
use std::time::{SystemTime, Duration};

struct DDoSFilter {
    requests: HashMap<String, SystemTime>,
}

impl DDoSFilter {
    fn new() -> Self {
        DDoSFilter { requests: HashMap::new() }
    }

    fn is_blocked(&mut self, ip: &str) -> bool {
        let now = SystemTime::now();
        if let Some(last_request) = self.requests.get(ip) {
            if now.duration_since(*last_request).unwrap() < Duration::from_secs(1) {
                return true;
            }
        }
        self.requests.insert(ip.to_string(), now);
        false
    }
}

fn main() {
    let mut filter = DDoSFilter::new();
    let user_ip = "192.168.1.1";

    if filter.is_blocked(user_ip) {
        println!("Blocked request from {}", user_ip);
    } else {
        println!("Allowed request from {}", user_ip);
    }
}