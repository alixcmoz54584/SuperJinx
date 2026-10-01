FROM node:20-bookworm

ENV NODE_ENV=production
ENV HOST=0.0.0.0
ENV PORT=8080

RUN apt-get update \
    && apt-get install -y --no-install-recommends git ca-certificates curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Pull the upstream Claude Code Web project during the Railway image build.
RUN git clone --depth 1 https://github.com/fafawlf/claude-code-web.git .

# Install Claude Code CLI. Authentication is supplied through Railway variables.
RUN npm install -g @anthropic-ai/claude-code
# NODE_ENV=production skips devDependencies; the build needs TypeScript and other dev tooling.
RUN npm ci --include=dev
RUN npm run build

# Railway injects PORT automatically. The app listens on 0.0.0.0 so the public
# Railway domain can reach it.
CMD ["sh", "-c", "node server/dist/bin/claudecode-web.js --host 0.0.0.0 --port ${PORT:-8080}"]
