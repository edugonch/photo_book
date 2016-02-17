include ActionDispatch::TestProcess
FactoryGirl.define do
  factory :image do
    lat '9.924824'
    lng '-84.087899'
    description 'This is the test description'
    file { fixture_file_upload(Rails.root.join('spec', 'photos', 'test.jpg'), 'image/jpg') }
    tags %w{'animals', 'japan'}
    user
  end
end
