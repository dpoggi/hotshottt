class Shot
  include DataMapper::Resource

  property :id, Serial
  property :dribbble_id, Integer
  property :title, Text
  property :author_name, Text
  property :image_url, Text
  property :creation_url, Text
  property :upvotes, Integer
  property :downvotes, Integer
end

class IP
  include DataMapper::Resource
  
  property :id, Serial
  property :ip_address, String
  property :vote_combo_list, Text
end

DataMapper.finalize
