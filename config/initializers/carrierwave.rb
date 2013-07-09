# largely taken from https://gist.github.com/cblunt/1303386

CarrierWave.configure do |config|
  config.fog_credentials = {
    # Configuration for Amazon S3 should be made available through an Environment variable.
    # In Heroku, follow http://devcenter.heroku.com/articles/config-vars
    #
    # $ heroku config:add S3_KEY=your_s3_access_key S3_SECRET=your_s3_secret S3_REGION=eu-west-1 S3_ASSET_URL=http://assets.example.com/ S3_BUCKET_NAME=s3_bucket/folder
 
    # Configuration for Amazon S3
    :provider              => 'AWS',
    :aws_access_key_id     => ENV['S3_KEY'],
    :aws_secret_access_key => ENV['S3_SECRET'],
    :region                => 'eu-west-1'
  }
 
  # only use fog/s3 in production, use file storeage for all other cases
  if Rails.env.production?
    config.storage = :fog
	config.root = Rails.root.join('tmp')
  else
    config.storage = :file
    config.root = Rails.root.join('tmp')
  end
 
  # To let CarrierWave work on heroku
  config.cache_dir = "#{Rails.root}/tmp/uploads"
 
  config.fog_directory  = ENV['S3_BUCKET_NAME']
  config.fog_public  	= true
  config.asset_host  	= "#{ENV['S3_ASSET_URL']}/#{ENV['S3_BUCKET_NAME']}"
end