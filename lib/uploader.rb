class Uploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  version :thumb do
    process :resize_to_fit => [400,400]
  end

  storage :file

end
