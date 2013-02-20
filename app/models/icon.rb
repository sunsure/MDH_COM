class Icon < Asset
  mount_uploader :attachment, IconUploader

  def pretty_filename
    attachment.file.filename
  end
end