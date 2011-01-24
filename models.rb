class Shot
  include DataMapper::Resource

  property :id, Serial
  property :dribbble_id, Integer
  property :title, String
  property :author_name, String
  property :image_url, Text
  property :creation_url, Text
  property :votes, Integer
end

DataMapper.finalize
