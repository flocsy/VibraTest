import Toybox.Application;
import Toybox.Attention;
import Toybox.Lang;
import Toybox.WatchUi;

class VibraTestApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        return [ new VibraTestView() ] as Array<Views or InputDelegates>;
    }

    public function onSettingsChanged() as Void {
        vibrate(getConfigStr("v", null));
        var tone = getConfigNumber("t", -1);
        if (tone > -1) {
            tone(tone);
        } else {
            toneProfile(getConfigStr("T", null));
        }
    }

    hidden function parseProfile(str as String?) as Array<Number> {
        var result = [] as Array<Number>;
        if (str == null || str.length() == 0) {
            return result;
        }
        while (str != null && str.length() > 0) {
            var pos = str.find(",");
            if (pos == null) {
                break;
            }
            var dutyCycleStr = str.substring(0, pos);
            if (dutyCycleStr == null) {
                break;
            }
            var dutyCycle = dutyCycleStr.toNumber();
            if (dutyCycle == null) {
                break;
            }
            str = str.substring(pos + 1, str.length());
            if (str == null || str.length() == 0) {
                break;
            }
            pos = str.find(";");
            if (pos == null) {
                pos = str.length();
            }
            var lengthStr = str.substring(0, pos);
            if (lengthStr == null) {
                break;
            }
            var length = lengthStr.toNumber();
            if (length == null) {
                break;
            }
            result.add(dutyCycle);
            result.add(length);
            str = str.substring(pos + 1, str.length());
        }
        return result;
    }

    hidden function vibrate(vibrationStr as String?) as Void {
        var vibeData = [] as Array<VibeProfile>;
        var numbers = parseProfile(vibrationStr);       
        for (var i = 0; i < numbers.size() - 1; i += 2) {
            vibeData.add(new Attention.VibeProfile(numbers[i], numbers[i + 1]));
        }
        if (vibeData.size() > 0 && Attention has :vibrate) {
            Attention.vibrate(vibeData);
        }
    }

    hidden function tone(tone as Number) as Void {
        if (tone > -1 && Attention has :playTone) {
            Attention.playTone(tone as Attention.Tone);
        }
    }

    (:no_ciq_3_1_0, :no_tone_profile)
    hidden function toneProfile(toneProfileStr as String?) as Void {}
    (:ciq_3_1_0, :tone_profile)
    hidden function toneProfile(toneProfileStr as String?) as Void {
        if (Attention has :ToneProfile && Attention has :playTone) {
            var toneProfile = [] as Array<ToneProfile>;
            var numbers = parseProfile(toneProfileStr);       
            for (var i = 0; i < numbers.size() - 1; i += 2) {
                toneProfile.add(new Attention.ToneProfile(numbers[i], numbers[i + 1]));
            }
            if (toneProfile.size() > 0) {
                Attention.playTone({:toneProfile => toneProfile});
            }
        }
    }
}

function getApp() as VibraTestApp {
    return Application.getApp() as VibraTestApp;
}
