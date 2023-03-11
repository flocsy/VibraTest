# Vibe & Tone Profile Test

## Usage

For CIQ developers: edit and try VibeProfile, ToneProfile and the built-in tones.

1. Open VibraTest app on the watch
2. Open the settings in ConnectIQ app
3. Edit the vibe profile, tone profile
4. Save and hear the tone, and feel the vibration on the watch

## Toybox.Attention.VibeProfile

You can enter your own VibeProfile:

Vibe Profile: "25,2000;50,2000;100,2000" is equivalent to:

    var vibeData = [
        new Attention.VibeProfile(25, 2000),
        new Attention.VibeProfile(50, 2000),
        new Attention.VibeProfile(100, 2000)
    ];

## Toybox.Attention.ToneProfile and Toybox.Attention.Tone

You can test both the built in tones: TONE_START, ... and create your own ToneProfile: 

Tone Profile: "2500,250;5000,250" is equivalent to:

    var toneProfile = [
        new Attention.ToneProfile( 2500, 250),
        new Attention.ToneProfile( 5000, 250)
    ];


# Changelog

1 (2023-03-10) initial version
