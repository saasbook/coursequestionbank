class UploadController < ApplicationController
    skip_before_filter  :verify_authenticity_token
     
      #def upload
      #  post = Problem.save(params[:upload])
      #  render :text => "File has been uploaded successfully"
      #end  
     
      def upload()
      @tag1 = Tag.create(name: "quiz 1")
      #@collection1 = Collection.create(name: "Fall 14")	
      question_open = false
      p = Problem.new
      File.open(params["myfile"].tempfile, 'r') do |f1|
        col = f1.gets
        col2 = /'(.*?)'/.match(col).to_s.gsub! /'/, ''
        
        @collection1 = Collection.create(name: col2)
        @tag1 = Tag.create(name: col2)

        while line = f1.gets
          #next if line =~ /\s*quiz*/
          if question_open
            if not line =~ /\s*end.*/
                    p.text << line
                    #puts line
                    question_open = true
            else
                    p.instructor = @current_user
                    p.tags << @tag1
                    p.collections<< @collection1
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
                    p.collections<< @collection1
                    p.tags << @tag1
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
    render 'complete'  
    end
end
