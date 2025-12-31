# ai-observer-homebrew

Homebrew tap for [ai-observer](https://github.com/tobilg/ai-observer) - a single binary OpenTelemetry-compatible observability backend for AI coding tools like Claude Code, Codex CLI and Gemini CLI.

## Installation

```bash
# Add the tap
brew tap tobilg/ai-observer

# Install ai-observer
brew install ai-observer
```

## Upgrade

```bash
brew upgrade ai-observer
```

## Usage

### Run as a background service (recommended)

```bash
# Start service (runs on login)
brew services start ai-observer

# Stop service
brew services stop ai-observer

# Restart service
brew services restart ai-observer

# Check status
brew services list
```

### Run manually

```bash
ai-observer
```

## Servers

AI Observer runs two servers:
- **Port 4318**: OTLP ingestion (traces, metrics, logs)
- **Port 8080**: Dashboard and API

## File locations

When running as a service:
- **Logs**: `$(brew --prefix)/var/log/ai-observer.log`
- **Database**: `$(brew --prefix)/var/ai-observer/ai-observer.duckdb`

## Configuration

The service uses these default environment variables:

| Variable | Default | Description |
|----------|---------|-------------|
| `AI_OBSERVER_API_PORT` | `8080` | Dashboard and API port |
| `AI_OBSERVER_OTLP_PORT` | `4318` | OTLP ingestion port |
| `AI_OBSERVER_DATABASE_PATH` | `$(brew --prefix)/var/ai-observer/ai-observer.duckdb` | DuckDB database path |

## More Information

See the main repository for documentation: [tobilg/ai-observer](https://github.com/tobilg/ai-observer)
