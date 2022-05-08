/**
 * FIGURA TOOLS by Grandpa Scout (STEAM_1:0:55009667)
 *
 * This contains some tools for working with Figura models.
 *
 * @version 0.5.3
**/
console.debug("FiguraTools: Loading the Figura Tools plugin...");
(function() {

  const VERSION = "0.5.3";


  console.debug("FiguraTools: Loading actions...");
  const getPathAction = {
    id: "figuratools-getPath",
    name: "Copy Part Path",
    description: "Copy the part path of this object to the clipboard.",
    icon: "fas.fa-code",
    click: context => {
      const path = [];
      let parent = context;
      while (parent !== "root") {
        /** @type {string} */
        let name = parent.name;
        if (name.match(/^[a-zA-Z_]\w*$/)) {
          path.push("." + name);
        } else {
          path.push('["' + name.replace(/([\\"])/g, "\\$1") + '"]');
        }
        parent = parent.parent;
      }
      const modelPath = "model" + path.reverse().join("");
      if (clipboard) {
        clipboard.writeText(modelPath);
      } else if (navigator.clipboard?.writeText) {
        navigator.clipboard?.writeText(modelPath)
          .catch(reason => {
            console.log(
              "Failed to send model path to clipboard because of:\n" +
              reason +
              "\n\nHere's your model path.\n" +
              modelPath
            );
            Blockbench.showQuickMessage("Failed to send model path to clipboard.\nCheck the console for more info.", 3333);
          });
      } else {
        Blockbench.showQuickMessage("There is no clipboard to send the model path to!\nCheck the console for the path.", 3333);
        console.log("MODEL PATH: " + modelPath);
      }
    }
  };

  const getComplexityAction = {
    id: "figuratools-getComplexity",
    name: "Get Complexity",
    description: "Get the current complexity of the selection in the status bar.\nShift-click to also send the value to clipboard.",
    icon: "fas.fa-vector-square",
    condition: () => (Cube.selected.length + Mesh.selected.length) > 0,
    click: (_, event) => {
      let complexity = 0;
      for (let cube of Cube.selected) {
        for (let face in cube.faces) {
          if (cube.faces[face]?.texture != null)
            complexity += 4;
        }
      }
      for (let mesh of Mesh.selected) {
        for (let face in mesh.faces) {
          if (mesh.faces[face]?.texture != null)
            complexity += 4;
        }
      }

      Blockbench.showStatusMessage("Complexity: " + complexity, 5000);

      if (event?.shiftKey) {
        if (clipboard) {
          clipboard.writeText(complexity.toString());
        } else if (navigator.clipboard?.writeText) {
          navigator.clipboard.writeText(complexity.toString())
            .catch(reason => {
              console.log(
                "Failed to send complexity to clipboard because of:\n" +
                reason +
                "\n\nHere's your complexity.\n" +
                complexity
              );
              Blockbench.showQuickMessage("Failed to send complexity to clipboard.\nCheck the console for more info.", 3333);
            });
        } else {
          Blockbench.showQuickMessage("There is no clipboard to send the complexity to!\nCheck the console for the complexity.", 3333);
          console.log("COMPLEXITY: " + complexity);
        }
      }
    }
  };

  console.debug("FiguraTools: Registering Plugin");

  BBPlugin.register("figuratools", {
    title: "Figura Tools",
    author: "GrandpaScout",
    description: "Contains tools for working with Figura models.",
    about: "Contains tools for working with Figura models.<br>" +
      '<i class="fab fa-github"></i> <a href="https://github.com/GrandpaScout/FiguraContent">Github</a>&emsp;' +
      '<i class="fab fa-discord"></i> <a href="https://discord.gg/ekHGHcH8Af">Figura Discord Server</a>',
    version: VERSION,
    variant: "desktop",
    min_version: "4.0.0",
    await_loading: true,
    tags: [
      "Minecraft: Java Edition",
      "Figura"
    ],
    icon: "change_history",

    //==| LOAD |==============================================================================//
    onload() {
      console.debug("FiguraTools: Plugin Loading");
      /** @type {Menu} */
      const Gmenu = Group.prototype.menu;
      Gmenu.addAction("_");
      Gmenu.addAction(getPathAction);
      Gmenu.addAction(getComplexityAction);

      /** @type {Menu} */
      const Cmenu = Cube.prototype.menu;
      Cmenu.addAction("_");
      Cmenu.addAction(getPathAction);
      Cmenu.addAction(getComplexityAction);

      /** @type {Menu} */
      const Mmenu = Mesh.prototype.menu;
      Mmenu.addAction("_");
      Mmenu.addAction(getPathAction);
      Mmenu.addAction(getComplexityAction);
    },
    //==| LOAD |==============================================================================//

    //==| UNLOAD |============================================================================//
    onunload() {
      console.debug("FiguraTools: Plugin Unloading");
      /** @type {Menu} */
      const Gmenu = Group.prototype.menu;
      const Cmenu = Cube.prototype.menu;
      const Mmenu = Mesh.prototype.menu;
      Gmenu.removeAction("figuratools-getPath");
      Gmenu.removeAction("figuratools-getComplexity");
      Cmenu.removeAction("figuratools-getPath");
      Cmenu.removeAction("figuratools-getComplexity");
      Mmenu.removeAction("figuratools-getPath");
      Mmenu.removeAction("figuratools-getComplexity");
    },
    //==| UNLOAD |============================================================================//

    oninstall() {
      console.debug("FiguraTools: Installed");
    },

    onuninstall() {
      console.debug("FiguraTools: Uninstalled");
    }
  });
})();
