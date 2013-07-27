# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :picture do
    caption "Picture Caption"
    image { fixture_file_upload(Rails.root.join('spec', 'photos', 'images.jpg'), 'image/jpg') }
  end
end
