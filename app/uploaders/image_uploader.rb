# frozen_string_literal: true

class ImageUploader < Shrine
  plugin :determine_mime_type, analyzer: :marcel
  plugin :derivatives

  Attacher.validate do
    validate_mime_type %w[image/jpeg image/png image/webp image/tiff]
    validate_extension %w[jpg jpeg png webp tiff tif]
    validate_max_size 5 * 1024 * 1024
  end

  Attacher.derivatives do |original|
    magick = ImageProcessing::MiniMagick.source(original)
    {
      small: magick.resize_to_limit(300, 300),
      large: magick.resize_to_limit(800, 800)
    }
  end
end
