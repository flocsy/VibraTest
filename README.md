# Vibe & Tone Profile Editor

## Usage

This app is for CIQ developers: edit and try how the VibeProfile feels like and how the ToneProfile and the built-in tones sound like.

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
        new Attention.ToneProfile(2500, 250),
        new Attention.ToneProfile(5000, 250)
    ];


# Changelog

5 (2024-03-25) add fr165, fix vibration detection

4 (2024-02-19) only display settings that are relevant to the device

3 (2024-02-19) fix crash when device doesn't support ToneProfile

2 (2024-02-13) add new devices

1 (2023-03-10) initial version
