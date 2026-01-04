class AiObserver < Formula
  desc "Single binary OpenTelemetry-compatible observability backend for AI coding tools like Claude Code, Codex CLI and Gemini CLI"
  homepage "https://github.com/tobilg/ai-observer"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tobilg/ai-observer/releases/download/v#{version}/ai-observer-darwin-arm64-v#{version}.tar.gz"
      sha256 "ac223319c4285a16cdfa9920eb2802d0fe58f8be5b9c086d999ba639c56f8901"
    end
  end

  def install
    bin.install "ai-observer"
    (var/"ai-observer").mkpath
    (var/"log").mkpath
  end

  service do
    run [opt_bin/"ai-observer"]
    keep_alive true
    working_dir var/"ai-observer"
    log_path var/"log/ai-observer.log"
    error_log_path var/"log/ai-observer.log"
    environment_variables AI_OBSERVER_API_PORT: "8080", AI_OBSERVER_OTLP_PORT: "4318", AI_OBSERVER_DATABASE_PATH: "#{HOMEBREW_PREFIX}/var/ai-observer/ai-observer.duckdb"
  end

  def caveats
    <<~EOS
      AI Observer runs two servers in a single process:
        - Port 4318: OTLP ingestion (traces, metrics, logs)
        - Port 8080: Dashboard and API

      Configure via environment variables:
        export AI_OBSERVER_API_PORT=8080
        export AI_OBSERVER_OTLP_PORT=4318
        export AI_OBSERVER_DATABASE_PATH=./data/ai-observer.duckdb

      To start ai-observer as a background service:
        brew services start ai-observer

      To stop the service:
        brew services stop ai-observer

      To restart the service:
        brew services restart ai-observer

      Or run manually:
        ai-observer

      Logs are written to:
        #{var}/log/ai-observer.log

      Database is stored at:
        #{var}/ai-observer/ai-observer.duckdb
    EOS
  end

  test do
    assert_match "ai-observer", shell_output("#{bin}/ai-observer --help 2>&1", 2)
  end
end
