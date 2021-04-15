# frozen_string_literal: true

module Spring
  module Commands
    class Ridgepole
      def call
        require 'ridgepole'
        constants = ActiveRecord::ConnectionAdapters.constants
        constants.select! { |c| c.match?(/Adapter$/) && c != :AbstractAdapter }
        constants.each do |constant|
          ActiveRecord::ConnectionAdapters.const_get(constant).prepend(
            ::Ridgepole::Ext::AbstractAdapter::DisableTableOptions
          )
        end
        load Gem.bin_path('ridgepole', 'ridgepole')
      end
    end
    Spring.register_command 'ridgepole', Ridgepole.new
  end
end
