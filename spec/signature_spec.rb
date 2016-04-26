require 'spec_helper'

describe S3::Signature do
  it 'has a version number' do
    expect(S3::Signature::VERSION).not_to be nil
  end
end
