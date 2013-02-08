class Image < Asset
  mount_uploader :attachment, ImageUploader

  def pretty_filename
    attachment.file.filename
  end
end