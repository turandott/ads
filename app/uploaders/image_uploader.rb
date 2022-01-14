class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  # include CarrierWave::MiniMagick
  include CarrierWave::MiniMagick
  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  version :thumb do
    process :resize_to_limit => [500, 500]
  end
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    "/images/fallback" + [version_name,"default.png"].compact.join('_')
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
  end
