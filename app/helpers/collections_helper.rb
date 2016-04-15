module CollectionsHelper
  def num_problems(collections)
    collections.inject(0){|sum, c| c.problems.size + sum}
  end
  
  def privacy_options(is_public)
    attr = {true => ' selected', false => ''}
    "<option#{attr[is_public]}>Public</option><option#{attr[!is_public]}>Private</option>"
  end
end
