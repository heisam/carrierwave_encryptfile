module CarrierWave
  module EncryptFile

    class GibberishFileEncrypt

      def initialize(secret_key)
        @cipher = Gibberish::AES.new(secret_key)
      end

      def do(from_file, to_file)
        @cipher.enc_file(from_file, to_file)
      end

    end

    class GibberishFileDecrypt

      def initialize(secret_key)
        @cipher = Gibberish::AES.new(secret_key)
      end

      def do(from_file, to_file)
        @cipher.dec_file(from_file, to_file)
      end

    end

  end
end