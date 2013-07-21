module CarrierWave
  module EncryptFile
    module Downloader

      class << self

        def call(uploaded_file, file_field, version=nil)
          if version
            downloader = uploaded_file.send(file_field.to_s).send(version)
          else
            downloader = uploaded_file.send(file_field.to_s)
          end

          file = nil
          begin
            downloader.retrieve_from_store!(File.basename(uploaded_file.send(file_field.to_s).url))
            file = downloader.file.path.to_s
          rescue Exception => e
            Rails.logger.debug "Unable to retrieve file: #{e}"
          end

          if File.exists? file
            decrypted_file = Tempfile.new([ file, 'dec' ].compact.join("."))
            decryptor = CarrierWave::EncryptFile::GibberishFileDecrypt.new(uploaded_file.send("#{file_field.to_s}_password"))
            decryptor.do file, decrypted_file
            return { :file => decrypted_file, :content_type => uploaded_file.send("#{file_field.to_s}_content_type") }
          else
            Rails.logger.debug "Unable to find the target file."
            nil
          end
        end

      end
    end
  end
end