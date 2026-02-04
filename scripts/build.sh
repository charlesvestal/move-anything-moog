#!/usr/bin/env bash
# Build RaffoSynth module for Move Anything (ARM64)
#
# Automatically uses Docker for cross-compilation if needed.
# Set CROSS_PREFIX to skip Docker (e.g., for native ARM builds).
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
IMAGE_NAME="move-anything-builder"

# Check if we need Docker
if [ -z "$CROSS_PREFIX" ] && [ ! -f "/.dockerenv" ]; then
    echo "=== RaffoSynth Module Build (via Docker) ==="
    echo ""

    # Build Docker image if needed
    if ! docker image inspect "$IMAGE_NAME" &>/dev/null; then
        echo "Building Docker image (first time only)..."
        docker build -t "$IMAGE_NAME" -f "$SCRIPT_DIR/Dockerfile" "$REPO_ROOT"
        echo ""
    fi

    # Run build inside container
    echo "Running build..."
    docker run --rm \
        -v "$REPO_ROOT:/build" \
        -u "$(id -u):$(id -g)" \
        -w /build \
        "$IMAGE_NAME" \
        ./scripts/build.sh

    echo ""
    echo "=== Done ==="
    exit 0
fi

# === Actual build (runs in Docker or with cross-compiler) ===
CROSS_PREFIX="${CROSS_PREFIX:-aarch64-linux-gnu-}"

cd "$REPO_ROOT"

echo "=== Building RaffoSynth Module ==="
echo "Cross prefix: $CROSS_PREFIX"

# Create build directories
mkdir -p build
mkdir -p dist/moog

# Compile DSP plugin
echo "Compiling DSP plugin..."
${CROSS_PREFIX}g++ -g -O3 -shared -fPIC -std=c++14 \
    src/dsp/moog_plugin.cpp \
    src/dsp/moog_engine.c \
    -o build/dsp.so \
    -Isrc/dsp \
    -lm

# Copy files to dist (use cat to avoid ExtFS deallocation issues with Docker)
echo "Packaging..."
cat src/module.json > dist/moog/module.json
cat src/ui.js > dist/moog/ui.js
cat build/dsp.so > dist/moog/dsp.so
chmod +x dist/moog/dsp.so

# Create tarball for release
cd dist
tar -czvf moog-module.tar.gz moog/
cd ..

echo ""
echo "=== Build Complete ==="
echo "Output: dist/moog/"
echo "Tarball: dist/moog-module.tar.gz"
echo ""
echo "To install on Move:"
echo "  ./scripts/install.sh"
