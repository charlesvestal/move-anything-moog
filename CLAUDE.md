# CLAUDE.md

Instructions for Claude Code when working with this repository.

## Project Overview

RaffoSynth module for Move Anything - a monophonic synthesizer based on RaffoSynth.

## Architecture

```
src/
  dsp/
    moog_plugin.cpp     # Main plugin wrapper (V2 API)
    moog_engine.h       # Synth engine header
    moog_engine.c       # Synth engine implementation
    param_helper.h      # Shared parameter helper
  ui.js                 # JavaScript UI (uses shared sound_generator_ui)
  module.json           # Module metadata
```

## Key Implementation Details

### Plugin API

Implements Move Anything plugin_api_v2 (multi-instance):
- `create_instance`: Initializes synth engine, loads factory presets
- `destroy_instance`: Cleanup
- `on_midi`: Routes MIDI to synth engine (mono, last-note priority)
- `set_param`: preset, octave_transpose, and 37 synth parameters
- `get_param`: preset_name, preset_count, ui_hierarchy, chain_params, state
- `render_block`: Renders synth output (mono to stereo)

### Synth Engine

Monophonic synthesizer with:
- 4 oscillators (triangle, sawtooth, square, pulse waveforms)
- Moog-style 4-pole ladder filter with resonance
- Amplitude ADSR envelope
- Filter ADSR envelope with contour control
- Glide/portamento
- LFO with pitch and filter modulation
- Noise generator
- Mod wheel and pitch bend support
- Last-note priority key handling

### Parameters (37 total)

**Oscillator 1**: `osc1_wave` (int 0-3), `osc1_volume`, `osc1_range` (int -2 to +2)
**Oscillator 2**: `osc2_wave`, `osc2_volume`, `osc2_range`, `osc2_detune`
**Oscillator 3**: `osc3_wave`, `osc3_volume`, `osc3_range`, `osc3_detune`
**Oscillator 4**: `osc4_wave`, `osc4_volume`, `osc4_range`, `osc4_detune`
**Mixer**: `noise`
**Filter**: `cutoff`, `resonance`, `contour`, `key_follow`
**Amp Envelope**: `attack`, `decay`, `sustain`, `release`
**Filter Envelope**: `f_attack`, `f_decay`, `f_sustain`, `f_release`
**Performance**: `glide`, `volume`
**LFO**: `lfo_rate`, `lfo_pitch`, `lfo_filter`
**Modulation**: `mod_filter`, `mod_pitch`, `bend_range`, `vel_sens`
**Other**: `octave_transpose` (plugin-level, -3 to +3 octaves)

### Factory Presets (14)

Init, Soloist, Duet, Trio, Quartet, SonataFlair, SonataFlairSub,
AngrySweep, SquarePulse, Whisper, CookedPasta, CookedPasta2, Classic Bass, Sub Bass

## Signal Chain Integration

Module declares `"chainable": true` and `"component_type": "sound_generator"` in module.json.

## Build Commands

```bash
./scripts/build.sh           # Build with Docker (ARM64 cross-compilation)
./scripts/install.sh          # Deploy to Move device
```

## License

MIT License (inherited from RaffoSynth)

## Origin

Based on RaffoSynth:
- Original: https://github.com/nicoroulet/RaffoSynth
- Fork: https://github.com/zynthian/moog
