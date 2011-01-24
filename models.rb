class Shot
  include DataMapper::Resource

  property :id, Serial
  property :dribbble_id, Integer
  property :title, String
  property :author_name, String
  property :image_url, String
  property :creation_url, String
  property :votes, Integer
end

DataMapper.finalize