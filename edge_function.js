addEventListener("fetch", event => {
    event.respondWith(handleRequest(event.request));
});

async function handleRequest(request) {
    let response = await fetch(request);
    let text = await response.text();
    return new Response(`<html><h1>[Edge Optimized] ${text}</h1></html>`, {
        headers: response.headers
    });
}