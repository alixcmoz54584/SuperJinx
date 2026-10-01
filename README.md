# Claude Code Web — Railway-ready

This package deploys the open-source Claude Code Web project as a single Railway service.
The Docker image pulls the upstream project at build time, installs Claude Code, builds the web UI,
and starts it on Railway's `PORT` (default `8080`).

## Railway

1. Create a new Railway project.
2. Deploy this folder/repository.
3. Railway will detect the Dockerfile and build it.
4. In **Variables**, add:

   `ANTHROPIC_API_KEY` = your own Anthropic API key

5. Keep `PORT=8080` if Railway allows you to set it; Railway may also inject its own PORT.
6. Generate a public domain from **Settings → Networking → Generate Domain**.

The container listens on `0.0.0.0`, not localhost, so Railway can route traffic to it.

## Important

- This is a web interface for Claude Code; it does not provide free Claude API usage.
- You need your own valid Claude Code/Anthropic authentication.
- Do not put your API key in frontend code or commit it to GitHub.
- Railway's filesystem is ephemeral unless you attach a Volume. If you want project files/sessions to survive redeploys, attach persistent storage.

## Local

```bash
docker build -t claude-code-web-railway .
docker run --rm -p 8080:8080 -e ANTHROPIC_API_KEY=YOUR_KEY claude-code-web-railway
```

Open `http://localhost:8080`.

Upstream project: https://github.com/fafawlf/claude-code-web
