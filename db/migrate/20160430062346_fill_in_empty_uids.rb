class FillInEmptyUids < ActiveRecord::Migration
  def up
    probs = Problem.all
    
    probs.each do |p|
      if p.uid.nil?
        p.uid = SecureRandom.uuid
        p.save
      end
    end
  end

  def down
  end
end
