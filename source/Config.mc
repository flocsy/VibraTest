import Toybox.Application;
import Toybox.Application.Properties;
import Toybox.Lang;
import Toybox.System;

(:no_ciq_2_4_0, :inline)
function getConfigImpl(key as PropertyKeyType) as PropertyValueType or Null {
    // return getApp().getProperty(key);

    // since this is the only place we used getApp() inlining saves 25 bytes in code and 18 bytes in data:
    // return Application.getApp().getProperty(key);

    // adding using Toybox.Application as App; and using App.Appbase.getProperty saves 3 bytes in code:
    // return App.AppBase.getProperty(key);

    // using MyApp instead of App.AppBase saves 4 bytes
    return getApp().getProperty(key);
}
(:ciq_2_4_0, :inline)
function getConfigImpl(key as PropertyKeyType) as PropertyValueType or Null {
    return Properties.getValue(key);
}
(:no_inline) // no_inline:-59
function getConfig(key as PropertyKeyType) as PropertyValueType or Null {
    var val;
    try {
        val = getConfigImpl(key);
    } catch (e) { // adds 31 bytes (non optimized)
        System.println(key + ":" + e.getErrorMessage());
        val = null;
    }
    return val;
}

// returns value if value.length > 0 or defaultValue is not null, otherwise defaultValue
(:no_inline)
function getConfigStr(key as PropertyKeyType, defaultValue as String?) as String? {
    return toConfigStr(getConfig(key), defaultValue);    
}
(:inline)
function toConfigStr(value as PropertyValueType, defaultValue as String?) as String? {
    value = convertToString(value, defaultValue);
    return value != null && (value.length() > 0 || defaultValue != null) ? value : defaultValue;
}

(:inline)
function convertToString(value as Object?, defaultValue as String?) as String? {
    // return value != null && value has :toString ? value.toString() : (value has :format ? value.format("%d") : defaultValue);
    return value != null ? "" + value : defaultValue;
}

typedef ConvertibleToNumber as interface {
    function toNumber() as Number;
};
(:no_inline)
function getConfigNumber(key as PropertyKeyType, defaultValue as Number) as Number {
    return toConfigNumber(getConfig(key), defaultValue);
}
(:no_inline)
function toConfigNumber(value as PropertyValueType?, defaultValue as Number) as Number {
    // if (value instanceof Lang.Number) {
    //     return value;
    // }
    // if (value != null && value has :toNumber) {
    //     value = (value as ConvertibleToNumber).toNumber();
    // }
    // value = value != null && value has :toNumber ? (value as ConvertibleToNumber).toNumber() : null;
    if (value instanceof Lang.Boolean) {
        return value ? 1 : 0;
    }
    // this should cover Float, Double, Number, String, Long, Char, Symbol
    value = value != null && value has :toNumber ? value.toNumber() : null;
    return value != null ? value as Number : defaultValue;
}
