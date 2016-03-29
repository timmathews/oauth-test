class User < ActiveRecord::Base
  def self.from_omniauth auth_hash
    user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
    user.name = auth_hash['info']['name']
    user.url = auth_hash['info']['urls']['Google'] || auth_hash['info']['urls']['Twitter']
    user.token = auth_hash['credentials']['token']
    user.save!
    user
  end
end
