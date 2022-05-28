import { readFileSync, writeFileSync } from "fs";
import path = require("path");
import { argv } from "process";

const CWD = path.dirname(argv[1]);
console.log(CWD);

const LUAFILE = path.join(CWD, "repl_loader.lua");
const LOADERFILE = path.join(CWD, "LOADERFILE_REPL.json");

const LUADATA = readFileSync(LUAFILE).toString();
console.log(LUADATA);

const JSONDATA = JSON.stringify({script: LUADATA});

console.log(JSONDATA);
writeFileSync(LOADERFILE, JSONDATA);
