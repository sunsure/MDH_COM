FactoryGirl.define do
  factory(:icon) do |icon|
    icon.attachment { File.open(File.join(Rails.root, 'spec', 'support', 'images', 'pfp_logo.jpg')) }
    icon.assetable { |i| i.association(:article) }
  end
end
