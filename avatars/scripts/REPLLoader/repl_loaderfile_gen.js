"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const fs_1 = require("fs");
const path = require("path");
const process_1 = require("process");
const CWD = path.dirname(process_1.argv[1]);
console.log(CWD);
const LUAFILE = path.join(CWD, "../REPL/figura_repl.lua");
const LOADERFILE = path.join(CWD, "LOADERFILE_REPL.json");
const LUADATA = (0, fs_1.readFileSync)(LUAFILE).toString();
const JSONDATA = JSON.stringify({ script: LUADATA }).replace(/[\u0080-\uFFFF]/g, (substring) => {
    return "\\u" + substring.charCodeAt(0).toString(16).padStart(4, "0");
});
console.log(JSONDATA);
(0, fs_1.writeFileSync)(LOADERFILE, JSONDATA);
//# sourceMappingURL=repl_loaderfile_gen.js.map