// Oyunu yerel ağda sunar: node serve.js  →  http://<bilgisayar-ip>:8080
const http = require("http");
const os = require("os");
const { page } = require("./shell");

const PORT = Number(process.env.PORT) || 8080;

http.createServer((req, res) => {
  res.writeHead(200, { "Content-Type": "text/html; charset=utf-8", "Cache-Control": "no-store" });
  res.end(page());
}).listen(PORT, "0.0.0.0", () => {
  for (const list of Object.values(os.networkInterfaces()))
    for (const a of list) if (a.family === "IPv4" && !a.internal) console.log(`http://${a.address}:${PORT}`);
});
