// Uygulamanın içine gömülecek web klasörünü (www/) üretir.
const fs = require("fs");
const path = require("path");
const { page } = require("../shell");

const out = path.join(__dirname, "..", "www");
fs.mkdirSync(out, { recursive: true });
fs.writeFileSync(path.join(out, "index.html"), page());
console.log("www/index.html yazıldı");
