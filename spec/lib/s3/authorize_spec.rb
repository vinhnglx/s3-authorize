require "spec_helper"

describe S3::Authorize do
  let(:bucket) { 'example' }
  let(:acl) { 'public-read' }
  let(:secret_key) { 'khb1BuGTjjdlkKelknVMoi' }
  let(:s3_authorize) { S3::Authorize.new({acl: acl, bucket: bucket, secret_key: secret_key}) }
  let(:base64_regex) { /^(?:[A-Za-z0-9+\/]{4}\n?)*(?:[A-Za-z0-9+\/]{2}==|[A-Za-z0-9+\/]{3}=)?$/ }

  context '.initialize' do
    describe 'with parameters' do
      it 'returns a constructor' do
        expect(s3_authorize).to be_an_instance_of S3::Authorize
      end
    end

    describe 'without parameters' do
      let(:wrong_s3_authorize) { S3::Authorize.new({acl: nil, bucket: nil}) }
      it 'raise an error' do
        expect do
          wrong_s3_authorize
        end.to raise_error(ArgumentError, 'Make sure your parameters exists')
      end
    end
  end

  context '.policy' do
    it 'returns base64 encoded' do
      expect(s3_authorize.policy).to match(base64_regex)
    end
  end

  context '.signature' do
    it 'returns signature encoded' do
      policy = s3_authorize.policy
      expect(s3_authorize.signature(policy)).to match(base64_regex)
    end
  end
end
