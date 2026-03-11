const os = require("os");
const path = require("path");

module.exports = {
  apps: [
    {
      name: "qwen3-server",
      script: "llama-server",
      args: [
        "--model",
        path.resolve(
          os.homedir(),
          ".cache/huggingface/hub/models--unsloth--Qwen3-Coder-30B-A3B-Instruct-GGUF/snapshots/b17cb02dd882d5b6ab62fc777ad2995f19668350/Qwen3-Coder-30B-A3B-Instruct-Q4_K_M.gguf",
        ),
        "--seed",
        "3407",
        "--temp",
        "0.5",
        "--top-p",
        "0.95",
        "--min-p",
        "0.01",
        "--top-k",
        "40",
        "--port",
        "21434",
        "--ctx-size",
        "130672", // "65336",
        "--n-gpu-layers",
        "-1",
        "--cache-type-k",
        "q4_0",
        "--cache-type-v",
        "q4_0",
      ].join(" "),
      interpreter: "none", // バイナリを直接実行する場合
    },
  ],
};
