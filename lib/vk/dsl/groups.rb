require 'vk/dsl/base'

module Vk
  module DSL
    class Groups < Base
      # Identifiers of groups in which user participates
      # @param [Integer] user_id user’s identifier
      # @param [Hash] options
      # @option options [Boolean] :extended (0)
      # @option options [<:admin, :editor, :moder, :groups, :publics, :events>] :filter
      # @option options [<:city, :country, :place, :description, :wiki_page, :members_count, :counters, :start_date, :end_date, :can_post, :can_see_all_posts, :activity, :status, :contacts, :links, :fixed_post, :verified, :site, :can_create_topic>] :fields
      # @option options [Fixnum] :offset
      # @option options [Fixnum] :count
      # @return [Array] array of group identifiers
      def get(user_id, options = {})
        options[:user_id] = user_id
        options[:extended] = !!options[:extended] ? 1 : 0 if options[:extended]
        options[:filter] = options[:filter].map(&:to_s).join(',') if options[:filter]
        options[:fields] = options[:fields].map(&:to_s).join(',') if options[:fields]
        request(:get, options)
      end

      def get_by_id(group_id, options = {})
        group_param = group_id.is_a?(Array) ? :group_ids : :group_id
        options[group_param] = group_id
        result = request('getById', options)
        if group_param == :group_id
          result.first
        else
          result
        end
      end
    end
  end
end
