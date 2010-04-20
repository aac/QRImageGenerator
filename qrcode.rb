require "rubygems"
require "RMagick"
require "rqrcode"

class QRImageGenerator
  def self.image str, scale=3
    black = [0,0,0].pack("CCC")
    white = [255,255,255].pack("CCC")
    qr = RQRCode::QRCode.new(str)
    flattened = qr.modules.flatten
    copied = flattened.inject("") {|s,v| s << (!v ? white : black)}
    res = Magick::Image.new(33,33)
    res.import_pixels(0,0,33,33, "RGB", copied, Magick::CharPixel)
    res.resize(res.rows * scale, res.columns * scale,Magick::BoxFilter)
  end
end
