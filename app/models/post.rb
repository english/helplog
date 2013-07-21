class Post < ActiveRecord::Base
  def self.published
    where(published: true)
  end

  def self.unpublished
    where(published: false)
  end
end
