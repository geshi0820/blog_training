module ApplicationHelper
	def tokyotime(time)
		time.strftime("%Y年%m月%d日 %H:%M")
	end

	def image_30_30(image)
		image_name = image
		img = Magick::ImageList.new(image)
		new_img = img.scale(0.25)
		new_img.write(image_name)
	end
end
