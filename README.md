# OsxWifi

This is a hacky little gem to output a "bar count" which is the relative strength of a WiFi signal.  It only works on OSX as it shells out to the `airport` utility.
## Installation

    $ gem install osx_wifi

## Usage

Simply run it, and it will output a "bar count" between `0` and `4` based on your SNR.  If you'd like an approximation of the WiFi bars using Unicode combined characters, add `-u` or `--unicode` as an option.

## powerlevel9k script

Put this is in your `.zshrc` to make use of this.  Needs an installed font patched with Font Awesome for the fa-wifi icon and the installation of this gem so that `osx_wifi` is in your PATH.

Numerical with Font Awesome WiFi Icon
```
POWERLEVEL9K_CUSTOM_WIFI_SIGNAL="zsh_wifi_signal"
POWERLEVEL9K_CUSTOM_WIFI_SIGNAL_BACKGROUND="blue"
POWERLEVEL9K_CUSTOM_WIFI_SIGNAL_FOREGROUND="yellow"

# This function requires installing osx_wifi from https://github.com/tristor/osx_wifi
zsh_wifi_signal(){
        local output=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I) 
        local airport=$(echo $output | grep 'AirPort' | awk -F': ' '{print $2}')

        if [ "$airport" = "Off" ]; then
                local color='%F{red}'
                echo -n "%{$color%}Wifi Off"
        else
                local ssid=$(echo $output | grep ' SSID' | awk -F': ' '{print $2}')
                local bars=$(osx_wifi)
                local color='%F{yellow}'

                [[ $bars -ge 3 ]] && color='%F{green}'
                [[ $bars -eq 2 ]] && color='%F{yellow}'
                [[ $bars -lt 2 ]] && color='%F{red}'

                echo -n "%{$color%} \uf1eb $ssid $bars%{%f%}" # relies on Nerd Fonts
        fi
}
```

When https://github.com/FortAwesome/Font-Awesome/issues/7856 is fixed this can be modified to instead output a color-coded bar count WiFi icon, instead of the numerical output.


Approximation of WiFi bars with Unicode combined character stacking
```
# This function requires installing osx_wifi from https://github.com/tristor/osx_wifi
zsh_wifi_signal(){
        local output=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I) 
        local airport=$(echo $output | grep 'AirPort' | awk -F': ' '{print $2}')

        if [ "$airport" = "Off" ]; then
                local color='%F{red}'
                echo -n "%{$color%}Wifi Off"
        else
                local ssid=$(echo $output | grep ' SSID' | awk -F': ' '{print $2}')
                local bar_count=$(osx_wifi)
                local bars=$(osx_wifi -u)
                local color='%F{yellow}'

                [[ $bar_count -ge 3 ]] && color='%F{green}'
                [[ $bar_count -eq 2 ]] && color='%F{yellow}'
                [[ $bar_count -lt 2 ]] && color='%F{red}'

                echo -n "%{$color%} $bars $ssid %{%f%}" # relies on Nerd Fonts
        fi
}

```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tristor/osx_wifi/

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

