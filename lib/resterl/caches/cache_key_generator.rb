# frozen_string_literal: true

module Resterl
  module Caches
    class CacheKeyGenerator
      def self.generate(url, params, headers)
        normalized = [url, params, headers].map do |part|
          part.is_a?(Hash) ? part.sort : part
        end.each_with_object(+'') { |e, acc| acc << e.inspect }

        Digest::SHA1.hexdigest(normalized)
      end
    end
  end
end
