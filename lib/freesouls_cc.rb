require 'flickraw'
require_relative '../config/config.rb'

module FreesoulsCC

  class Flickr
    @@per_page = 500
    @@sort = "date-posted-desc"
    @@extras = "url_m,url_sq,path_alias,date_taken"

    def initialize
      FlickRaw.api_key = FLICKR_API_KEY
      FlickRaw.shared_secret = FLICKR_API_SECRET

      @users = FLICKR_USERS.map { |username|
        flickr.people.findByUsername(:username => username)
      }
    end

    def users()
      @users
    end

    def sync(tags)
      s = "title"
      photos = fetch(tags).map { |p|
        p.to_hash
      }.sort {|x,y|
        x[s] <=> y[s]
      }.reduce({}) { |memo, p|
        memo[p["id"]] = p
        memo
      }

      File.open("_data/#{tags}.json", "w") do |f|
        f.write(JSON.pretty_generate(photos))
      end
    end

    def fetch(tags)
      photos = @users.map { |user|
        results = search(user.id, tags)
      }.flatten
    end

    def search(user_id, tags)
      query = {user_id: user_id, tags: tags, per_page: @@per_page, page: 1,
               sort: @@sort , extras: @@extras, private_filter: 1}
      results = flickr.photos.search(query).to_a
      photos = results
      while !results.empty?
        query[:page] += 1
        results = flickr.photos.search(query).to_a
        photos.concat(results)
      end

      photos
    end
  end
end
