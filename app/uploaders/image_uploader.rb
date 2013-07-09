# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  #Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
     # For Rails 3.1+ asset pipeline compatibility:
     ActionController::Base.helpers.image_path("fallback/" + [version_name, "default.jpg"].compact.join('_'))
  end


   version :tiled_2x do
     process :resize_to_fill=> [678, 340]
   end

   version :tiled_4x do
     process :resize_to_fill=> [332, 332]
   end

   version :top_game do
     process :resize_to_fill=> [1356 , 700]
   end


  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
     %w(jpg jpeg png)
  end

end
