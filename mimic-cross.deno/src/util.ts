import $ from "daxex/mod.ts";
import { PathRefLike } from "daxex/mod.ts";
import { config } from "../config/config.ts";

export async function checkNeeded(
  path: PathRefLike,
  needed: string,
): Promise<boolean> {
  const commandOut = await $`${config.internalBin}/patchelf --print-needed ${
    $.path(path)
  }`.lines();
  for (const line of commandOut) {
    if (line == needed) return true;
  }
  return false;
}

export async function getElfArch(
  path: PathRefLike,
): Promise<string | undefined> {
  const machine =
    (await $`${config.internalBin}/readelf -h ${$.path(path)}`.noThrow().stderr(
      "null",
    )
      .apply((l) => {
        const e = l.split(":");
        if (e[0].trim() !== "Machine") return;
        return e[1].trim();
      }).text()).trimEnd();
  switch (machine) {
    case "Advanced Micro Devices X86-64":
      return "x86_64";
    case "AArch64":
      return "aarch64";
    default:
      return;
  }
}
