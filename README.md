# RaffoSynth for Move Anything

Monophonic synthesizer module based on [RaffoSynth](https://github.com/nicoroulet/RaffoSynth) by Nicolas Roulet and Julian Palladino.

Features 4 oscillators, a Moog-style ladder filter, and dual ADSR envelopes.

## Features

- Monophonic with last-note priority and key stacking
- 4 oscillators with 4 waveforms each (triangle, sawtooth, square, pulse)
- Per-oscillator volume, octave range, and fine detune
- Moog-style 4-pole ladder filter with resonance
- Separate amplitude and filter ADSR envelopes
- Glide/portamento
- LFO with pitch and filter modulation
- Noise generator
- Mod wheel and pitch bend support
- 14 factory presets
- Works standalone or as a sound generator in Signal Chain patches

## Prerequisites

- [Move Anything](https://github.com/charlesvestal/move-anything) installed on your Ableton Move
- SSH access enabled: http://move.local/development/ssh

## Install

### Via Module Store (Recommended)

1. Launch Move Anything on your Move
2. Select **Module Store** from the main menu
3. Navigate to **Sound Generators** → **RaffoSynth**
4. Select **Install**

### Build from Source

Requires Docker (recommended) or ARM64 cross-compiler.

```bash
git clone https://github.com/charlesvestal/move-anything-moog
cd move-anything-moog
./scripts/build.sh
./scripts/install.sh
```

## Controls

| Control | Function |
|---------|----------|
| Up/Down | Octave transpose (-3 to +3) |
| Jog wheel | Browse presets / navigate menus |
| Knobs 1-8 | Adjust parameters for current category |

In Shadow UI / Signal Chain, parameters are organized into navigable categories.

## Factory Presets

| # | Name | Description |
|---|------|-------------|
| 0 | Init | Default sawtooth patch |
| 1 | Soloist | Single bright saw |
| 2 | Duet | Saw + triangle |
| 3 | Trio | Saw + triangle + square |
| 4 | Quartet | All four oscillators |
| 5 | SonataFlair | Detuned three-saw, dark filter |
| 6 | SonataFlairSub | SonataFlair with sub oscillator |
| 7 | AngrySweep | Resonant filter sweep |
| 8 | SquarePulse | Pulse + square, resonant |
| 9 | Whisper | Soft resonant three-osc |
| 10 | CookedPasta | Percussive pulses |
| 11 | CookedPasta2 | Sustained pulses |
| 12 | Classic Bass | Fat dual-saw bass |
| 13 | Sub Bass | Deep triangle sub |

## Parameters (37 total)

### Oscillator 1
`osc1_wave` (0=tri, 1=saw, 2=square, 3=pulse), `osc1_volume`, `osc1_range` (-2 to +2 octaves)

### Oscillator 2
`osc2_wave`, `osc2_volume`, `osc2_range`, `osc2_detune`

### Oscillator 3
`osc3_wave`, `osc3_volume`, `osc3_range`, `osc3_detune`

### Oscillator 4
`osc4_wave`, `osc4_volume`, `osc4_range`, `osc4_detune`

### Mixer
`noise`, `volume`

### Filter
`cutoff`, `resonance`, `contour` (envelope amount), `key_follow`

### Filter Envelope
`f_attack`, `f_decay`, `f_sustain`, `f_release`

### Amp Envelope
`attack`, `decay`, `sustain`, `release`

### LFO
`lfo_rate`, `lfo_pitch` (depth to pitch), `lfo_filter` (depth to filter)

### Performance
`glide`, `mod_filter`, `mod_pitch`, `bend_range`, `vel_sens`

## Troubleshooting

**No sound:**
- This is a monophonic synth - only one note plays at a time
- Check that Osc1 volume is above zero
- Try a different preset

**Thin sound:**
- Turn up Osc2, Osc3, and/or Osc4 volumes for a fatter tone
- Add slight detune on Osc2 for classic thickness

**Filter self-oscillation:**
- High resonance with low cutoff will cause the filter to ring
- This is authentic Moog behavior - lower resonance to tame it

## License

MIT License - See [LICENSE](LICENSE)

Based on RaffoSynth by Nicolas Roulet and Julian Palladino.
