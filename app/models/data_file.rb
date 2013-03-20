class DataFile < ActiveRecord::Base
  def self.save(upload)
    name =  upload.original_filename
    directory = "public"
    
    path = File.join(directory, name)
    
    File.open(path, "wb") { |f| f.write(upload.read) }
  end
end