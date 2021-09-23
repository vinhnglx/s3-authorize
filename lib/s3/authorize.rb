require 'base64'
require 'openssl'
require 'digest/sha1'
require 'json'
require 'time'
require 's3/authorize/version'

module S3
  class Authorize
    # Attributes reader
    attr_reader :bucket, :acl, :secret_key

    # Create constructor for S3Authorize
    #
    # args - A hash of parameters.
    #
    # Examples
    #
    #   S3Authorize.new({bucket: 'example', acl: 'private', secret_key: '123456789'})
    #
    # Returns nothing
    def initialize(args)
      raise ArgumentError, 'Make sure your parameters exists' unless args_present?(args)
      @bucket = args[:bucket]
      @acl = args[:acl]
      @secret_key = args[:secret_key]
      @min_file_size = args[:min_file_size] || 0
      @max_file_size = args[:max_file_size] || (10 * 1024 * 1024)
    end

    # Generate policy
    # A Base64-encoded policy document that applies rules to file uploads
    #
    # Examples
    #
    #   s3_authorize = S3Authorize.new({bucket: 'example', acl: 'private', secret_key: '123456789'})
    #   s3.policy
    #   # => eyJleHBpcmF0aW9uIjoiMjAxNi0wNC0yNlQxNzoxODowOVoiLCJjb25kaXRpb25zIjpb....
    #
    # Returns Base64-encoded
    def policy
      Base64.encode64(
        {
          "expiration" => (Time.now + 60 * 60).utc.xmlschema,
          "conditions" => [
            { "bucket" => bucket },
            [ "starts-with", "$key", "" ],
            { "acl" => acl },
            [ "starts-with", "$Content-Type", "" ],
            [ "starts-with", "$filename", "" ],
            [ "content-length-range", @min_file_size, @max_file_size ]
          ]
        }.to_json).gsub(/\n/,'')
    end

    # Generate signature
    # A Base64-encoded policy document with your AWS Secret Key
    #
    # s3_policy - The Base64-encoded policy document
    #
    # Examples
    #
    #   s3_authorize = S3Authorize.new({bucket: 'example', acl: 'private', secret_key: '123456789'})
    #   s3_authorize.signature
    #   # => 1bFFNUyrZ2qLz34bM8a0kNJi6U
    #
    # Returns Base64-encoded
    def signature(s3_policy)
      Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha1'), secret_key, s3_policy)).gsub("\n","")
    end

    private

      # Private: Check parameters exists or not
      #
      # Examples
      #
      #   args_present?
      #
      # Returns Boolean
      def args_present?(args)
        !(args[:bucket].nil? || args[:acl].nil? || args[:secret_key].nil?)
      end
  end
end
