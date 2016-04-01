module CollectionsHelper
  def num_problems(collections)
    collections.inject(0){|sum, c| c.problems.size + sum}
  end
end
