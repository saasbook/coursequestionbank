module DisableSolr
  def self.included(base)
    # override the class's search method (mixed in from Solr gem) with ours:
    base.instance_eval do
      def search(&block)
        DisableSolr::FakeSolr.new(all)
      end
    end
  end
  class FakeSolr
    attr_reader :results
    def initialize(arel)
      @results = arel.paginate(:page => 1, :per_page => 10)
    end
  end
end

if Rails.configuration.try(:without_solr)
  puts "\n\n*************   WARNING:  Solr is disabled in development  *************\n\n To enable it, see config/development.rb\n\n"

  # eagerly load the two classes into which we want to mix the above module, which stubs Solr...
  require 'collection'
  require 'problem'
  # ...and command them to mix in the module
  Collection.send(:include, DisableSolr)
  Problem.send(:include, DisableSolr)
end
