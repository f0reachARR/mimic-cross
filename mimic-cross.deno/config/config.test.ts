import $ from "daxex/mod.ts";
import { config, loadConfig } from "./config.ts";
import { assertEquals } from "std/assert/mod.ts";

Deno.test("config", async () => {
  const testConfig = {
    hostRoot: "/host",
  };
  assertEquals(config.hostRoot, "/mimic-cross/host");
  assertEquals(config.internalBin, "/mimic-cross/host/mimic-cross/internal/bin");
  const configPath = $.path("/mimic-cross/config.json");
  await configPath.writeJson(testConfig);
  await loadConfig();
  assertEquals(config.hostRoot, "/host");
  assertEquals(config.internalBin, "/mimic-cross/host/mimic-cross/internal/bin");
  await configPath.remove();
});
