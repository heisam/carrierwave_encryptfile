module CarrierWave
  module EncryptFile
    module Uploader

      def self.encrypt_file(file, mounted_as, uploader_model)
        if uploader_model && uploader_model.new_record?
          ext_file = file + ".x1"
          File.rename(file, ext_file)

          # use the same password for all versions
          if @password
            uploader_model.send("#{mounted_as}_password=", @password)
          else
            @password = uploader_model.send("#{mounted_as}_password=", SecureRandom.hex(32))
          end

          encryptor = CarrierWave::EncryptFile::Encryptor.new(@password)
          encryptor.do(ext_file, file)

          File.unlink(ext_file)
          file
        end
      end

    end
  end
end