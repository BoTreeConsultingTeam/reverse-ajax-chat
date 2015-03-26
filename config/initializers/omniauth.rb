Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '232193500233565', 'd7d043200598a9a81074d24ba0656398',
           scope: 'public_profile', display: 'page', image_size: 'square'

  #provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET'], image_size: 'normal'
end