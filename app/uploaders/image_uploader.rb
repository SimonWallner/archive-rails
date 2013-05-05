# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  #include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  # include Sprockets::Helpers::RailsHelper
  # include Sprockets::Helpers::IsolatedHelper

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"  # include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  # include Sprockets::Helpers::RailsHelper
  # include Sprockets::Helpers::IsolatedHelper

  # Choose what kind of storage to use for this uploader:
  end

  # don't set cache dir for now, if the default works...
  # def cache_dir
  #   Rails.root.join('public/uploads/tmp')
  # end

  #Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
     # For Rails 3.1+ asset pipeline compatibility:
     # asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))

     "/defaultpics/" + [version_name.to_s + "_example.jpg"].compact.join('_')

  end



  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
 #def scale(width, height)
  #   # do something
 #end

   #Create different versions of your uploaded files:
   version :tiled_2x do
     # double image size
     # process :resize_to_fill=> [339, 170]
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

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
