module DisableSolr
  def self.included(base)
    Rails.logger.warn "\n\n*************   WARNING:  Solr is disabled    *************\n\n Until we get it working again, the search features will not work - the search function is aliased to just return everything in the collection.\n\nTo re-enable it, uncomment 'sunspot_solr' and 'sunspot_rails' in the Gemfile, and then delete this file (#{__FILE__})."
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    # Solr's `search` method returns an object whose `results` is an ARel.
    def search(&block)
      FakeSolr.new(all)
    end
    def searchable(&block) ; end
  end

  class FakeSolr
    attr_reader :results
    def initialize(arel)
      @results = arel.paginate(:page => 1, :per_page => 10)
    end
  end
end
