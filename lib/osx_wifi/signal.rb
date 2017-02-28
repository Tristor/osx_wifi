require 'mixlib/shellout'

module OsxWifi
  # Signal converts stats from `airport` to signal bar count
  class Signal
    attr_reader :bars

    def initialize(options = {})
      if options[:unicode_output]
        @bars = unicode_bars.encode('utf-8')
      else
        @bars = calculate_bars
      end
    end

    def airport_stats
      airport = Mixlib::ShellOut.new('/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I')
      airport.run_command
      airport.error!
      @airport_stats ||= airport.stdout
    end

    def rssi
      @rssi ||= airport_stats.match('^\s*.*CtlRSSI:\s(-\d{2,3})')[1]
    end

    def noise
      @noise ||= airport_stats.match('^\s*.*CtlNoise:\s(-\d{2,3})')[1]
    end

    def snr
      @snr ||= rssi.to_i - noise.to_i
    end

    def calculate_bars
      case snr
      when 25..40
        3
      when 15..25
        2
      when 10..15
        1
      else
        if @snr > 40
          4
        elsif @snr < 10
          0
        end
      end
    end

    def unicode_bars
      case snr
      when 25..40
        "_\u033F"
      when 15..25
        "_\u0305"
      when 10..15
        '_'
      else
        if @snr > 40
          "_\u0305\u033F"
        elsif @snr < 10
          ''
        end
      end
    end
  end
end
