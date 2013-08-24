module CarrierWave
  module EncryptFile
    module Downloader

      class << self

        def call(uploader_model, mounted_as, version=nil)
          if version
            downloader = uploader_model.send(mounted_as).send(version)
          else
            downloader = uploader_model.send(mounted_as)
          end

          encrypted_file = nil
          begin
            downloader.retrieve_from_store!(File.basename(downloader.url))
            encrypted_file = downloader.file.path
          rescue Exception => e
            Rails.logger.debug "Unable to retrieve file: #{e}"
          end

          if File.exists? encrypted_file
            decrypted_file = Tempfile.new([ encrypted_file, 'dec' ].compact.join("."))
            password = uploader_model.send("#{mounted_as}_password")

            decryptor = CarrierWave::EncryptFile::Decryptor.new(password)
            decryptor.do(encrypted_file, decrypted_file)

            return { 
              :file => decrypted_file, 
              :content_type => uploader_model.send("#{mounted_as}_content_type") 
            }
          else
            Rails.logger.debug "Unable to find file."
            nil
          end
        end

      end
    end
  end
end