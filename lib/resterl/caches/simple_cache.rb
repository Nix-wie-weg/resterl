# From:
# http://github.com/der-flo/localmemcache_store/blob/master/lib/expiry_cache.rb

module Resterl
  module Caches
    class SimpleCache < CacheInterface
      class Entry < Struct.new(:data, :expires_at)
        def expired?
          expires_at && expires_at <= Time.now
        end
      end

      def initialize options = {}
        @options = {
          expiration_check_interval: 1_000,
          cache_key_prefix: 'RESTERL_'
        }.merge options
        @expiration_check_counter = 0
        @data = {}
      end

      def read key
        key = internal_key key

        do_expiration_check
        entry = @data[key]

        # return if nothing in cache
        return nil unless entry

        # entry expired?
        if verify_entry_not_expired(key, entry)
          entry.data
        else
          nil
        end
      end

      def write key, value, expires_in = nil
        key = internal_key key

        do_expiration_check

        # calculate expiration
        expires_at = Time.now + expires_in.to_i if expires_in.to_i > 0

        # store data
        if expires_at.nil? || expires_at > Time.now
          entry = Entry.new(value, expires_at)
          @data[key] = entry
        end

        value
      end

      def delete key
        key = internal_key key

        @data.delete key
      end

      def flush
        @data = {}
      end

      private

      def verify_key_not_expired key
        entry = @cache[key]
        verify_entry_not_expired(key, entry) if entry
      end

      def verify_entry_not_expired key, entry
        if entry.expired?
          @data.delete(key)
          false
        else
          true
        end
      end

      def do_expiration_check
        @expiration_check_counter += 1
        unless @expiration_check_counter >= @options[:expiration_check_interval]
          return
        end
        @expiration_check_counter = 0
        expire_random_entries
      end

      def expire_random_entries count = 1_000
        [count, @data.length].min.times do
          key = @data.keys.sample
          break if key.nil?
          entry = @data[key]
          verify_entry_not_expired key, entry
        end
      end

      def expire_some_entries count = 100
        count = [count, @data.length].min
        @data.each_key do |key|
          break if count <= 0
          count -= 1 unless verify_entry_not_expired(key, entry)
        end
      end

      def internal_key key
        "#{@options[:cache_key_prefix]}#{key}"
      end
    end
  end
end
