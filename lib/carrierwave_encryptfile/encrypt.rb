module CarrierWave
  module EncryptFile

    class Encryptor

      def initialize(secret_key)
        @cipher = Gibberish::AES.new(secret_key)
      end

      def do(from_file, to_file)
        @cipher.enc_file(from_file, to_file)
      end

    end

    class Decryptor

      def initialize(secret_key)
        @cipher = Gibberish::AES.new(secret_key)
      end

      def do(from_file, to_file)
        @cipher.dec_file(from_file, to_file)
      end

    end

  end
end