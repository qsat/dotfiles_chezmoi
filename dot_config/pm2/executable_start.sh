#!/bin/zsh

pm2 start ~/.config/pm2/qwen3-coder/ecosystem.config.js

## 動作確認
# curl http://127.0.0.1:21434/v1/chat/completions \
#  -H "Content-Type: application/json" \
#  -d '{
#    "model": "your-model-name",
#    "messages": [
#      {"role": "user", "content": "are you qwen3 coder?"}
#    ]
#  }' | jq .

