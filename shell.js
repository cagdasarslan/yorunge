// Oyun dosyasını (index.html) tam bir HTML belgesine sarar. Hem yerel sunucu hem de iOS uygulama derlemesi kullanır.
const fs = require("fs");
const path = require("path");

const head = `<!doctype html><html lang="tr"><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no,viewport-fit=cover">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
<meta name="theme-color" content="#0A0D19">
<style>:root{padding-top:env(safe-area-inset-top,0px);padding-bottom:env(safe-area-inset-bottom,0px);box-sizing:border-box;height:100%}
body{margin:0;font:14px system-ui,sans-serif}[hidden]{display:none!important}</style></head><body>`;

function page() {
  return head + fs.readFileSync(path.join(__dirname, "index.html"), "utf8") + "</body></html>";
}

module.exports = { page };
