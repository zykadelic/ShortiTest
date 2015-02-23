class STShortiView < UIView
	def initWithShorti(shorti)
		if initWithFrame(CGRectMake(0, 0, Device.screen.width, Device.screen.height))
			self.backgroundColor = UIColor.whiteColor

			contentView			= UIView.alloc.initWithFrame(App.delegate.navigationViewRect)
			sideMargins			= 16
			contentView.frame	= CGRectMake(contentView.frame.origin.x + sideMargins, contentView.frame.origin.y, contentView.frame.size.width - sideMargins * 2, contentView.frame.size.height)
			addSubview(contentView)

			marginTop = 4 # FIXME Is there a better way to do this?

			# title		= titleLabel(shorti['title'])
			# titleFrame	= title.frame
			# marginTop	+= titleFrame.size.height
			# contentView.addSubview(title)

			body				= bodyLabel(shorti['body'])
			bodyFrame			= body.frame
			marginTop			+= 16
			bodyFrame.origin	= CGPointMake(bodyFrame.origin.x, bodyFrame.origin.y + marginTop)
			marginTop			+= bodyFrame.size.height
			body.frame			= bodyFrame
			contentView.addSubview(body)

			thumbnail				= thumbnailView(shorti['thumbnail'])
			thumbnailFrame			= thumbnail.frame
			marginTop				+= 10
			thumbnailFrame.origin	= CGPointMake(thumbnailFrame.origin.x, thumbnailFrame.origin.y + marginTop)
			marginTop				+= thumbnailFrame.size.height
			thumbnail.frame			= thumbnailFrame
			contentView.addSubview(thumbnail)
		end
		self
	end

	def titleLabel(title)
		label			= UILabel.alloc.initWithFrame(CGRectZero)
		label.text		= title
		label.textColor	= UIColor.blackColor
		label.sizeToFit
		return label
	end

	def bodyLabel(body)
		label				= UILabel.alloc.initWithFrame(CGRectZero)
		label.text			= body
		label.textColor		= UIColor.blueColor
		label.numberOfLines	= 0

		label.sizeToFit
		# Given maximum allowable size, how big do you need to be to fit?
		size = label.sizeThatFits(CGSizeMake(bounds.size.width, Float::MAX))
		# Set the entire frame with a position & a size
		label.frame = CGRectMake(0, 0, size.width, size.height)
		return label
	end

	def thumbnailView(urlString)
		imageURL	= NSURL.URLWithString(urlString)
		placeholder	= UIImage.imageNamed('Shorti-thumbnail-placeholder.png')
		imageView	= AsyncImageView.alloc.initWithImage(placeholder)
		imageView.imageURL = imageURL
		return imageView
	end
end
