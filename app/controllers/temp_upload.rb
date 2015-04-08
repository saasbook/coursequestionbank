class UploadController < ApplicationController
    skip_before_filter  :verify_authenticity_token
     
      #def upload
      #  post = Problem.save(params[:upload])
      #  render :text => "File has been uploaded successfully"
      #end  
    def read_TF(file)
    end
    def read_

    def upload
    question_open = false
    p = Problem.new
    File.open(params["myfile"].tempfile, 'r') do |file|
      col = file.gets
      p.tags << Tag.create(:name => 'YOLO')
      col2 = /'(.*?)'/.match(col).to_s.gsub! /'/, ''

      while line = file.gets
        #next if line =~ /\s*quiz*/
        if question_open
          if not line =~ /\s*end.*/
            p.text << line
            #puts line
            question_open = true
          else
            p.instructor = @current_user
            p.text<<line
            p.save!
            p = Problem.new
            puts line
            question_open = false
          end
        else
          if line =~ /\s*truefalse.*/
            #puts line
            p.text = line
            p.instructor = @current_user
            p.save!
            p = Problem.new
            question_open = false
          elsif line =~ /\s*fill_in.*/
            question_open = true
            p.text = line
              #puts line
          elsif line =~ /\s*choice.*/             
            p.text = line
            question_open = true             
              #p.text = line
              #puts line
          elsif line =~ /\s*select_multiple.*/             
            question_open = true             
            p.text = line
              #puts line
          end
        end
      end
    end
  flash[:notice] = "Sucessfully uploaded file"
  redirect_to problems_path 
  end
end
