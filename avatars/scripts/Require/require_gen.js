"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const fs_1 = require("fs");
const path = require("path");
const process_1 = require("process");
const CWD = path.dirname(process_1.argv[1]);
const colors = {
    0: "0;30", 1: "0;34", 2: "0;32", 3: "0;36", 4: "0;31", 5: "0;35", 6: "0;33", 7: "0;37",
    8: "0;90", 9: "0;94", a: "0;92", b: "0;96", c: "0;91", d: "0;95", e: "0;93", f: "0;97",
    l: "1", o: "3", n: "4", m: "9", k: "6", r: "0"
};
function colorize(str) {
    return str.replace(/§(.)/g, (_, char) => `\x1b[${colors[char]}m`) + "\x1b[0m";
}
const ARGL = process.argv.length;
/*
  arg0 NODE
  arg1 .js
  arg2 <file>
  arg3 <modulename>
*/
switch (ARGL) {
    case 2:
        console.log(colorize('Usage:\n'
            + '  §anode §erequire_gen§r\n'
            + '  §8================§r\n'
            + '    Show this help page.\n\n'
            + '  §anode §erequire_gen §boption§r\n'
            + '  §8=======================§r\n'
            + '  §boption§r:\n'
            + '   ├ §3error§r:   Why is this tool erroring?\n'
            + '   ├ §3files§r:   What do the files this makes do?\n'
            + '   ├ §3suggest§r: How to make §1VSCode§r automatically suggest require modules.\n'
            + '   └ §3where§r:   Where are the files that this script makes?\n'
            + '    Shows info about the option given.\n\n'
            + '  §anode §erequire_gen §9"path/to/script.lua" §d"module_name"§r\n'
            + '  §8===================================================§r\n'
            + '    Converts a script file into a require module.\n\n'
            + '    If you are using this utility from §1VSCode§r, you can right click a tab and select "Copy Relative Path" to quickly get a file path.\n'
            + '    Make sure to wrap the path in quotes just in case.\n'
            + '    Make sure the module name does not use any invalid characters or you will not be able to load it in-game.\n'
            + '    Try sticking to §3A§8-§3Z§r, §3a§8-§3z§r, §30§8-§39§r, §3_§r, §3-§r.'));
        process.exit();
    case 3:
        switch (process.argv[2]) {
            case "error":
                console.log(colorize("§cThis script is not running in the 'figura/model_files' folder§r:\n"
                    + "  Make sure the §erequire_gen.js§r file is in 'figura/model_files' as stated in the error.\n\n"
                    + "§cModule with name '<mod_name>' already exists! §4←§c Pick a different name or delete the module§r:\n"
                    + "  The module name given already exists as a file at '../stored_vars/LUAMODULE_<mod_name>.json'.\n"
                    + "  If you want to save to that module name, delete that file first.\n\n"
                    + "§cCould not read script at 'path/to/script.lua'§r:\n"
                    + "  The script file could not be read, either it does not exist or the tool does not have\n"
                    + "  permission to read the file.\n\n"
                    + "§cCould not write module at 'path/to/module.json'§r:\n"
                    + "  Despite what this error actually says, this can be caused by the tool being unable to\n"
                    + "  write to either the §6JSON§r or §9Lua§r file.\n\n"
                    + "If you see any other type of error, complain to §bGrandpa Scout§r."));
                break;
            case "files":
                console.log(colorize('§6LUAMODULE_*.json§r:\n'
                    + '  Contains the actual script that runs when the module is run. The JSON object looks like so:\n'
                    + '  §8{\n'
                    + '    §b"script"§8: §c"<module content here>"\n'
                    + '  §8}§r\n\n'
                    + '§9LUAMODULE_*.lua§r:\n'
                    + '  This file is used as a marker to tell §1VSCode§r that there is a module here.\n'
                    + '  It does nothing and only contains "§dreturn §c[[<module_name>]]§r".'));
                break;
            case "suggest":
                console.log(colorize('Start by going to the settings page.\n'
                    + 'If you are in a §bWorkspace§r and are §cnot§r using the VSC Docs, go to the "§fWorkspace§r" tab,\n'
                    + 'If you are in a §3Folder§r, go to the §fWorkspace§r tab,\n'
                    + '  §8(VSCode treats the Workspace tab as the folder tab if you do not have a workspace open)§r\n'
                    + 'If you are in a §bWorkspace§r and are using the VSC Docs, go to the "§f<folder_name> Folder§r" tab,\n'
                    + 'Search for the "§fLua.runtime.path§r" setting,\n'
                    + 'Remove all items currently in the setting,\n'
                    + 'Click \x1b[104;97m Add Item §r and set the new item to §3./LUAMODULE_?.json§r,\n'
                    + 'Search for the "§fLua.workspace.library§r" setting,\n'
                    + '  §8(If there are items already in this setting, do §4not§8 remove them unless you know what you are doing.)§r\n'
                    + 'Click \x1b[104;97m Add Item §r and set the new item to §3../stored_vars§r.\n\n'
                    + 'VSCode should now automatically suggest require modules when using the §erequire§r function.'));
                break;
            case "where":
                console.log(colorize(`The files are stored at §e${path.resolve(CWD, "../stored_vars")}§r.`));
                break;
            default:
                console.error("Invalid option given. Do 'node require_gen' for help.");
                process.exit(1);
        }
        process.exit();
    case 4:
        break;
    default:
        console.error("Invalid number of arguments given. Do 'node require_gen' for help.");
        process.exit(1);
}
console.log("This is running in '" + CWD + "'.\nChecking if that is correct...");
if (!CWD.match(/([\/|\\])figura\1model_files\1?$/)) {
    console.error(colorize("§4This script is not running in the §6'figura/model_files'§4 folder.§r"));
    process.exit();
}
const LUAPATH = path.resolve(CWD, process.argv[2]), MODPATH = path.resolve(CWD, "../stored_vars/LUAMODULE_" + process.argv[3]);
if ((0, fs_1.existsSync)(MODPATH + ".json")) {
    console.log(`Module with name '${process.argv[3]}' already exists!\nPick a different name or delete the module.`);
    process.exit(1);
}
let LUADATA;
try {
    LUADATA = (0, fs_1.readFileSync)(LUAPATH).toString();
}
catch {
    console.error(`Could not read script at '${LUAPATH}'`);
    process.exit(1);
}
const JSONDATA = JSON.stringify({ script: LUADATA }).replace(/[\u0080-\uFFFF]/g, (substring) => {
    return "\\u" + substring.charCodeAt(0).toString(16).padStart(4, "0");
});
try {
    (0, fs_1.writeFileSync)(MODPATH + ".json", JSONDATA);
    (0, fs_1.writeFileSync)(MODPATH + ".lua", `return [[${process.argv[3]}]]`);
}
catch {
    console.error(`Could not write module at '${MODPATH}.json'`);
    process.exit(1);
}
console.log("Done.");
//# sourceMappingURL=require_gen.js.map