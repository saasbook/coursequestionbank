class UploadController < ApplicationController

  def upload
    puts params[:ruql_file].read
    # File.open(params["ruql_file"].tempfile, 'r').each do |lines|
    #   puts lines
    # end
    flash[:notice] = "Sucessfully uploaded file"
    redirect_to problems_path 
  end
  # def upload
  #   uploaded_io = params[:ruql_file]
  #   File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
  #     file.write(uploaded_io.read)
  #   end
  # end
end