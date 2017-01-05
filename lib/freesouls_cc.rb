require 'flickraw'

module FreesoulsCC

  class Jekyll
    @@template = "---\ntitle: Picture\n---"

    def initialize(filename)
      file = File.read("_data/#{filename}.json")
      @photos = JSON.parse(file)
    end

    def gen(queries)
      queries[:tags].each { |tag|
        dir = "_#{tag}"
        unless Dir.exist?(dir)
          Dir.mkdir(dir)
        end
        @photos.select { |id,photo|
          photo["tags"].split(" ").include?(tag)
        }.keys.each { |id|
          f = File.open("#{dir}/#{id}.md", "w")
          f.write(@@template)
        }
      }
    end

    def clean(queries)
      queries[:tags].each { |tag|
        dir = "_#{tag}"
        FileUtils.rm_r dir
      }
    end
  end

  class Flickr
    @@per_page = 500
    @@sort = "date-posted-desc"
    @@extras = "url_m,url_sq,path_alias,date_taken,tags"

    def initialize(flickr_api_key, flickr_api_secret)
      FlickRaw.api_key = flickr_api_key
      FlickRaw.shared_secret = flickr_api_secret
    end

    def sync(queries, filename)
      s = "id"
      photos = fetch(queries).map { |p|
        p.to_hash
      }.sort {|x,y|
        x[s] <=> y[s]
      }.reduce({}) { |memo, p|
        memo[p["id"]] = p
        memo
      }

      File.open("_data/#{filename}.json", "w") do |f|
        f.write(JSON.pretty_generate(photos))
      end
    end

    def fetch(queries)
      tags = queries[:tags].join(",")

      photos = queries[:usernames].map { |username|
        user = flickr.people.findByUsername(:username => username)
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
