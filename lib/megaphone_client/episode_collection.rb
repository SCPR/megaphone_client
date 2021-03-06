require "ostruct"
require "json"
require "rest-client"

module MegaphoneClient

  # @author Jay Arella
  class EpisodeCollection

    # @return a MegaphoneClient::EpisodeCollection instance
    # @note This is used to initialize the podcast id and episode id when creating a new Episode instance
    # @example Initialize a new instance of MegaphoneClient::EpisodeCollection
    #   MegaphoneClient::EpisodeCollection.new("{podcast_id}") #=> #<MegaphoneClient::EpisodeCollection @id=nil, @podcast_id="{podcast_id}">

    def initialize(podcast_id=nil)
      @podcast_id = podcast_id
    end

    # @return a MegaphoneClient
    # @note This is used as a way to access top level attributes
    # @example Accessing a network id configuration
    #   config.network_id #=> '{network id specified in initialization}'

    def config
      @config ||= MegaphoneClient
    end

    # @return an array of structs that represent a list of episodes for a given podcast
    # @note If a @podcast_id is not given, it raises an error
    # @see MegaphoneClient#connection
    # @example List a podcast's episodes
    #   megaphone.podcast("12345").episodes.list
    #   #=> An array of structs representing a list of episodes for a given podcast

    def list options={}
      if !@podcast_id
        raise ArgumentError.new("The @podcast_id variable is required.")
      end

      MegaphoneClient.connection({
        :url => "#{config.api_base_url}/networks/#{config.network_id}/podcasts/#{@podcast_id}/episodes",
        :method => :get
      })
    end

    # @return an array of structs that represents the search results by episode
    # @see MegaphoneClient#connection
    # @example Search for an episode with externalId 'show_episode-12345'
    #   megaphone.episode.search({
    #     externalId: 'show_episode-1245'
    #   })
    #   #=> An array of one struct representing 'show_episode-12345'

    def search params={}
      MegaphoneClient.connection({
        :url => "#{config.api_base_url}/search/episodes",
        :method => :get,
        :params => params
      })
    end
  end
end