module Resterl
  module Caches
    class CacheInterface
      def read key
        raise 'Not yet implemented!'
      end

      def write key, value, expires_in
        raise 'Not yet implemented!'
      end

      def delete key
        raise 'Not yet implemented!'
      end
    end
  end
end
