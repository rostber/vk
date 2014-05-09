# coding: utf-8
require 'vk'
require 'vk/dsl/base'
require 'active_support/core_ext/string/inflections'

module Vk
  module DSL
    # @return [Vk::DSL::Database]
    def database
      @database ||=
        begin
          require 'vk/dsl/database'
          Vk::DSL::Database.new(self)
        end
    end

    # @return [Vk::DSL::Photos]
    def photos
      @photos ||=
        begin
          require 'vk/dsl/photos'
          Vk::DSL::Photos.new(self)
        end
    end

    # @return [Vk::DSL::Groups]
    def groups
      @groups ||=
        begin
          require 'vk/dsl/groups'
          Vk::DSL::Groups.new(self)
        end
    end

    # Have user installed app?
    # @param  [String] uid user’s identifier
    # @return [Boolean]             does user installed app
    def app_user?(uid)
      request('isAppUser', uid: uid) == '1'
    end

    # Profile information for provided uids or domain names
    # @param [Array<String>] uids array of users’ identifiers in numbers or domain names
    # @param [Hash] options the options to request profile information
    # @option options [:user_id, :first_name, :last_name, :nickname, :domain, :sex, :bdate, :birthdate, :city, :country, :timezone, :photo, :photo_medium, :photo_big, :has_mobile, :rate, :contacts, :education, :online] :fields ([:user_id, :first_name, :last_name]) profile fields to requests
    # @option options [:nom, :gen, :dat, :acc, :ins, :abl] :name_case (:nom) case of returned names
    # @return [Array<Hash>] array of user profile data
    def get_profiles(uids, options = {})
      uids = Array(uids)
      if uids.first.to_i == 0
        options[:domains] = uids.join ','
      else
        options[:uids] = uids.join ','
      end
      options[:fields] = Array(options[:fields]).join(',') if options.key?(:fields)
      request('getProfiles', options)
    end

    def get_profile(uid, options = {})
      get_profiles(uid, options).try(:first) || {}
    end

    # Friends information
    # @param [Fixnum] uid user identifier
    # @param [Hash] options
    # @option options [Array<String>] :fields ([:user_id, :first_name, :last_name]) what fields to request
    # @option options [Fixnum] :count how many friends to request
    # @option options [Fixnum] :offset offset of friends to request
    def get_friends(uid, options = {})
      request('friends.get', options.merge(uid: uid))
    end

    # Statuses from user’s wall
    # @param [Fixnum] uid user identifier
    # @param [Hash] options
    # @option options [Fixnum] :count how many statuses to request
    # @option options [Fixnum] :offset offset of statuses to request
    # @option options [:owner, :others, :all] :filter (:all) what kind of statuses to request
    # @return [Array<Fixnum, *Hash>] count of statuses and each status in hash
    def get_wall(uid, options = {})
      options[:filter] ||= :all
      request('wall.get', options.merge(owner_id: uid))
    end

    def get_wall_statuses(posts)
      request('wall.getById', posts: posts)
    end

    def get_wall_status(id)
      get_wall_statuses(id)[0]
    end
  end
end
