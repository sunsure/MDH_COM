FactoryGirl.define do
  factory(:image) do |image|
    image.attachment { File.open(File.join(Rails.root, 'spec', 'support', 'images', 'pfp_logo.jpg')) }
    image.assetable { |i| i.association(:article) }
  end
end
