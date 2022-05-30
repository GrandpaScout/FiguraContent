import { readFileSync, writeFileSync } from "fs";
import path = require("path");
import { argv } from "process";

const CWD = path.dirname(argv[1]);
console.log(CWD);

const LUAFILE = path.join(CWD, "../REPL/figura_repl.lua");
const LOADERFILE = path.join(CWD, "LOADERFILE_REPL.json");

const LUADATA = readFileSync(LUAFILE).toString();

const JSONDATA = JSON.stringify({script: LUADATA}).replace(
  /[\u0080-\uFFFF]/g,
  (substring) => {
    return "\\u" + substring.charCodeAt(0).toString(16).padStart(4, "0");
  }
);

console.log(JSONDATA);
writeFileSync(LOADERFILE, JSONDATA);
