require 'vk/dsl/base'

module Vk
  module DSL
    class Photos < Base
      # @param [Hash] options
      # @option options :owner_id [Fixnum] (current user id)
      # @option options :album_id ['wall', 'profile', 'saved', String] album identifier
      # @option options :rev [1, 0, Boolean] 0 - chronological sort, 1 - reversed chronological sort
      # @option options :photo_ids [<String>, String] photos’ identifiers joined using ','
      # @option options :extended [1, 0, Boolean] (0) fields :likes, :comments, :tags, :can_comment
      # @option options :feed_type ['photo', 'photo_tag'] :type field of {Newsfeed#get} result
      # @option options :offset [Fixnum] offset for loaded photos
      # @option options :count [Fixnum] (100) amount of photos to load (max 1000)
      def get(options = {})
        options[:rev] = 1 if options[:rev]
        options[:extended] = 1 if options[:extended]
        raise Vk::TooMuchArguments.new('photos.get', 'photo_ids', 1000) if options[:photo_ids].try(:count).try(:>, 1000)
        options[:photo_ids] = options[:photo_ids].join(',') if options[:photo_ids]
        raise Vk::TooMuchArguments.new('photos.get', 'count', 1000) if options[:count].try(:>, 1000)
        request_for_collection(:get, Vk::Photo, options)
      end

    end
  end
end
