/// <reference types="blockbench-types" />

//START BLOCKBENCH EXTRA TYPES
interface ConditionalToggleOptions extends Omit<ActionOptions, "click"> {
  default?: boolean;

  click?: (event: Event) => void;
  onChange: (state: boolean) => boolean | undefined;
}

type ModeTypes = "animate" | "display" | "edit" | "paint" | "pose";

declare var Modes: {[K in ModeTypes]?: boolean;};
declare var main_preview: Preview;
declare var NullObject: any;

type PreviewControls = {
  target: THREE.Vector3,
  enabled: boolean
};
//END BLOCKBENCH EXTRA TYPES

interface SavedData {
  camera: {
    position: [number, number, number],
    target: [number, number, number]
  },

  nodepos: {
    self?: OutlinerElement,
    icon: string,
    lastPos: [number, number, number]
  },

  nodetgt: {
    self?: OutlinerElement,
    icon: string,
    lastPos: [number, number, number]
  }
}

{
  const BLANK_EVENT = <Event>{};

  const MAIN_CONTROLS = <PreviewControls>main_preview.controls;
  const MAIN_CAMERA = main_preview.camera;

  const savedData: SavedData = {
    camera: {
      position: [0, 0, 0],
      target: [0, 0, 0]
    },

    nodepos: {
      self: undefined,
      icon: "",
      lastPos: [NaN, NaN, NaN]
    },

    nodetgt: {
      self: undefined,
      icon: "",
      lastPos: [NaN, NaN, NaN]
    }
  };


  const FOLLOWPOS_ACTION = {
    name: "Follow Position",
    description: "Makes the camera follow this part's position during an animation.",
    icon: "fas.fa-video",

    condition: (): boolean | undefined => (NullObject.selected.length === 1) && Modes.animate,

    click: (self: OutlinerElement) => {
      const NODEPOS = savedData.nodepos;

      if (NODEPOS.self) {
        //@ts-expect-error // -=[ <1> ]=-
        //Despite `icon` being a property of `OutlinerElement`, it does not exist in type defs...
        NODEPOS.self.icon = NODEPOS.icon;
      }

      NODEPOS.self = self;
      //@ts-expect-error //Ditto: <1>
      NODEPOS.icon = self.icon;
      //@ts-expect-error //Ditto: <1>
      self.icon = "fa fas fa-video";
      self.updateElement();

      cameraFollow();
    }
  };

  const FOLLOWTGT_ACTION = {
    name: "Follow Target",
    description: "Makes the camera look at this part's position during an animation.",
    icon: "fas.fa-eye",

    condition: () => (NullObject.selected.length === 1) && Modes.animate,

    click: (self: OutlinerElement) => {
      const NODETGT = savedData.nodetgt;

      if (NODETGT.self) {
        //@ts-expect-error //Ditto: <1>
        NODETGT.self.icon = NODETGT.icon;
      }

      NODETGT.self = self;
      //@ts-expect-error //Ditto: <1>
      NODETGT.icon = self.icon;
      //@ts-expect-error //Ditto: <1>
      self.icon = "fa fas fa-eye";
      self.updateElement();

      cameraFollow();
    }
  };

  const REMOVEPOS_ACTION = {
    name: "Remove Follow",
    description: "Removes the current follow state of this part.",
    icon: "fas.fa-video-slash",

    condition: (self: OutlinerElement) =>
      (NullObject.selected.length === 1) && Modes.animate && self === savedData.nodepos.self,

    click: (self: OutlinerElement) => {
      const NODEPOS = savedData.nodepos;
      NODEPOS.self = undefined;
      //@ts-expect-error //Ditto: <1>
      self.icon = NODEPOS.icon;
      self.updateElement();

      cameraFollow();
    }
  };

  const REMOVETGT_ACTION = {
    name: "Remove Follow",
    description: "Removes the current follow state of this part.",
    icon: "fas.fa-eye-slash",

    condition: (self: OutlinerElement) =>
      (NullObject.selected.length === 1) && Modes.animate && self === savedData.nodetgt.self,

    click: (self: OutlinerElement) => {
      const NODETGT = savedData.nodetgt;
      NODETGT.self = undefined;
      //@ts-expect-error //Ditto: <1>
      self.icon = NODETGT.icon;
      self.updateElement();

      cameraFollow();
    }
  };

  const FOLLOW_MENU: any = {
    id: "gs-camfollow",
    name: "Camera Follow",
    description: "Contains tools for animating the camera.\n\n"
               + "You can also click this directly to assign the position and target\n"
               + "in order if they are not assigned yet or unassign this if it is assigned.",
    icon: "fas.fa-video",
    children: [
      FOLLOWPOS_ACTION,
      FOLLOWTGT_ACTION,
      "_",
      REMOVEPOS_ACTION,
      REMOVETGT_ACTION
    ],
    condition: () => (NullObject.selected.length === 1) && Modes.animate,
    click: (self: OutlinerElement) => {
      const NODEPOS = savedData.nodepos.self,
            NODETGT = savedData.nodetgt.self;

      if (self === NODEPOS)
        REMOVEPOS_ACTION.click(self);

      else if (self === NODETGT)
        REMOVETGT_ACTION.click(self);

      else if (!NODEPOS)
        FOLLOWPOS_ACTION.click(self);

      else if (!NODETGT)
        FOLLOWTGT_ACTION.click(self);

      else
        Blockbench.showQuickMessage("All camera targets are already set.", 3000);
    }
  };

  const CTOG_CSS = Blockbench.addCSS(`
    .tool.ctoggleerr {
      border-bottom: 3px solid #FF11117F;
    }
  `);

  class ConditionalToggle extends Action {
    type: "toggle";
    value: boolean;
    menu_icon_node: HTMLElement;
    errtimeout?: NodeJS.Timeout = undefined;
    onChange: (state: boolean) => boolean | undefined;

    constructor(id: string, data: ConditionalToggleOptions) {
      super(id, <ActionOptions>data);
      this.type = 'toggle';
      this.value = data.default || false;

      this.onChange = data.onChange;

      this.menu_icon_node = Blockbench.getIconNode('check_box_outline_blank');
      //@ts-expect-error //class Action does not contain `menu_node` for some reason.
      $(this.menu_node).find('.icon').replaceWith(this.menu_icon_node);

      this.updateEnabledState();
    };

    click(event: JQuery.TriggeredEvent) {
      const inv = !this.value;
      const success = this.onChange(inv);

      if (success !== false) {
        this.value = inv;
        this.updateEnabledState();
      } else {
        this.nodes.forEach(node => {node.classList.add('ctoggleerr');});
        if (this.errtimeout !== undefined) clearTimeout(this.errtimeout);
        this.errtimeout = setTimeout(() => {
          this.nodes.forEach(node => {node.classList.remove('ctoggleerr');});
          this.errtimeout = undefined;
        }, 667);
      }
    }

    updateEnabledState() {
      this.nodes.forEach(node => {node.classList.toggle('enabled', this.value);});
      this.menu_icon_node.innerText = this.value ? 'check_box' : 'check_box_outline_blank';
    }
  }

  const FOLLOW_TOGGLE = new ConditionalToggle("gs-camfollow_toggle", {
    name: "Disable Camera Follow",
    description: "Stops the camera from following the current active part.",
    icon: "fas.fa-video-slash",
    default: true,
    onChange: (state: boolean) => {
      if (state) {
        let tgt = savedData.camera.target,
            pos = savedData.camera.position;
        MAIN_CONTROLS.target.set(...tgt);
        MAIN_CAMERA.position.set(...pos);
        MAIN_CONTROLS.enabled = true;
      } else {
        let fail = shouldFollowFail(state);
        if (fail) {
          Blockbench.showStatusMessage("Camera follow cancelled: " + fail, 5000);
          return false;
        }

        let tgt = MAIN_CONTROLS.target,
            pos = MAIN_CAMERA.position,
            stgt = savedData.camera.target,
            spos = savedData.camera.position;
        stgt[0] = tgt.x,
        stgt[1] = tgt.y,
        stgt[2] = tgt.z,
        spos[0] = pos.x,
        spos[1] = pos.y,
        spos[2] = pos.z;

        MAIN_CONTROLS.enabled = false;

        let ntgt = savedData.nodetgt.lastPos,
            npos = savedData.nodepos.lastPos;
        ntgt[0] = NaN,
        ntgt[1] = NaN,
        ntgt[2] = NaN,
        npos[0] = NaN,
        npos[1] = NaN,
        npos[2] = NaN;

        cameraFollow(state);
      }
    }
  });

  function shouldFollowFail(newState?: boolean): string | false {
    if (newState ?? FOLLOW_TOGGLE.value) return "Camera Follow disabled.";
    if (!Modes.animate) return "Not in Animate Mode.";
    let npos = savedData.nodepos,
        ntgt = savedData.nodetgt;

    //`mesh` is missing and I'm not gonna figure out why.
    //@ts-expect-error -=[ <2> ]=-
    if (!npos.self?.mesh) {
      if (npos.self) {
        //@ts-expect-error //Ditto: <1>
        npos.self.icon = npos.icon;
        npos.self = undefined;
      }
      return "Camera follow position is missing.";
    }

    //@ts-expect-error //Ditto: <2>
    if (!ntgt.self?.mesh) {
      if (ntgt.self) {
        //@ts-expect-error //Ditto: <1>
        ntgt.self.icon = ntgt.icon;
        ntgt.self = undefined;
      }
      return "Camera follow target is missing.";
    }

    return false;
  }

  function cameraFollow(force?: boolean) {
    if (force ?? FOLLOW_TOGGLE.value) return;
    let fail = shouldFollowFail(force);
    if (fail) {
      Blockbench.showStatusMessage("Camera follow disabled: " + fail, 5000);
      FOLLOW_TOGGLE.value = true;
      FOLLOW_TOGGLE.onChange(true);
      FOLLOW_TOGGLE.updateEnabledState();
    }

    let ltgt = savedData.nodetgt.lastPos,
        lpos = savedData.nodepos.lastPos,
        //@ts-expect-error //getWorldCenter does not exist in type defs.
        ntgt = new THREE.Vector3().add(savedData.nodetgt.self.getWorldCenter(true)),
        //@ts-expect-error //Ditto: Above
        npos = new THREE.Vector3().add(savedData.nodepos.self.getWorldCenter(true));

    if (ltgt[0] !== ntgt.x || ltgt[1] !== ntgt.y || ltgt[2] !== ntgt.z) {
      ltgt[0] = ntgt.x,
      ltgt[1] = ntgt.y,
      ltgt[2] = ntgt.z;

      MAIN_CONTROLS.target.set(...ltgt);
    }

    if (lpos[0] !== npos.x || lpos[1] !== npos.y || lpos[2] !== npos.z) {
      lpos[0] = npos.x,
      lpos[1] = npos.y,
      lpos[2] = npos.z;

      MAIN_CAMERA.position.set(...lpos);
    }
  };

  BBPlugin.register("camerafollow", {
    title: "Camera Follow",
    author: "GrandpaScout",
    variant: "both",
    description: "Makes the camera follow a part around when animating.",
    icon: "fas.fa-video",

    onload() {
      const NULLOBJECT_MENU: Menu = NullObject.prototype.menu;
      //@ts-expect-error //addAction doesn't support its own `"_"` seperators.
      NULLOBJECT_MENU.addAction("_", "0");
      NULLOBJECT_MENU.addAction(FOLLOW_MENU, "0");

      //@ts-expect-error //Imagine misspelling an event name.
      Blockbench.addListener("display_animation_frame", cameraFollow);
    },

    onunload() {
      (NullObject.prototype.menu as Menu).removeAction("gs-camfollow");

      //@ts-expect-error //How does this *entire* function not exist?
      Blockbench.removeListener("display_animation_frame", cameraFollow);

      CTOG_CSS.delete();
    }
  });
}
