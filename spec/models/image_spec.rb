require 'rails_helper'

RSpec.describe Image, type: :model do
  it { should have_attached_file(:file) }
  it { should validate_attachment_presence(:file) }
  it { should validate_attachment_content_type(:file).
                allowing('image/png', 'image/gif').
                rejecting('text/plain', 'text/xml') }
end
