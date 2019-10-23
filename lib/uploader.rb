class Uploader < CarrierWave::Uploader::Base

  # include CarrierWave::RMagick
  #
  # version :thumb do
  #   process :resize_to_fill => [200,200s]
  # end

  storage :file

end
