import $ from "daxex/mod.ts";
import { PathRef } from "dax/mod.ts";

export async function readRunpath (path: PathRef) : Promise<string | undefined> {
  return (await $`objdump -x ${path}`.stderr("null").noThrow()
    .apply((l) => {
      const e = $.split(l);
      if (e[0] != "RUNPATH") return;
      return e[1];
    })
    .text()).trimEnd();
}

export async function mimicDeploy (src: PathRef, dst: PathRef) {
  const runpath = await readRunpath(src);
  if (!runpath) return;
  let needPatch = false;
  for (const p of runpath.split(":")) {
    if (!p.startsWith("$ORIGIN")) {
      needPatch = true;
      break;
    }
  }
  if (!needPatch) return;
  const deployBin = dst.join(src.basename());
  await src.copyFile(deployBin);
  const newRunpath = runpath.replace(/^\//, "/host/").replace(":/", ":/host/");
  await $`/usr/bin/patchelf --set-rpath ${newRunpath} ${deployBin}`;
  await $.path("./target.log").appendText(
    `add /host prefix to RUNPATH in ${deployBin}\n`,
  );
}
