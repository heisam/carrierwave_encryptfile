module CarrierWave
  module EncryptFile
    module Uploader

      def self.encrypt_file(file, file_field, model=nil)
        if !model.nil? && model.id.nil?
          ext_file = file + ".x1"
          File.rename(file, ext_file)
          # use the same password for all versions
          if @password
            model.send("#{file_field}_password=", @password)
          else
            @password = model.send("#{file_field}_password=", SecureRandom.hex(32)) unless @password
          end
          encryptor = CarrierWave::EncryptFile::GibberishFileEncrypt.new(@password)
          encryptor.do(ext_file, file)
          File.unlink(ext_file)
          file
        end
      end

    end
  end
end