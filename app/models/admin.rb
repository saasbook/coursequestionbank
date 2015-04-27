class Admin < Instructor
  # attr_accessible :title, :body
  def is_admin?
    false
  end
end
