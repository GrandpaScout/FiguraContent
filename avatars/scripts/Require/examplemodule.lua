local this = {}

function this.numberIsEven(n) return n % 2 == 0 end

function this.round(n) return math.floor(n + 0.5) end

---@type string[]
local randomSound = {
  "minecraft:entity.creeper.primed",
  "minecraft:entity.pig.ambient",
  "minecraft:block.anvil.land",
  "minecraft:ui.toast.challenge_complete",
  "minecraft:enchant.thorns.hit",
  "minecraft:item.trident.return",
  "minecraft:event.raid.horn",
  "minecraft:ambient.cave"
}
local wackySound = vectors.of{2, 1}
function this.playWackySound()
  sound.playSound(randomSound[math.random(#randomSound)], player.getPos(), vectors.of{2, 1})
end

print("Done making wacky functions. Have fun!")

return this
