MetricFu::Configuration.run do |config|
    # define which metrics you want to use
    config.metrics  = [ :churn, :stats, :flog, :flay, :reek, :rcov ]
    config.graphs   = [ :flog, :flay, :reek, :roodi, :rcov ]
    config.flay     = { :dirs_to_flay => ['lib'],
                        :minimum_score => 100,
                        :filetypes => ['rb'] }
    config.flog     = { :dirs_to_flog => ['lib'] }
    config.reek     = { :dirs_to_reek => ['lib'] }
    config.churn    = { :start_date => "1 year ago", :minimum_churn_count => 10 }
    config.rcov     = { :environment => 'test',
                        :test_files => ['spec/**/*_spec.rb'],
                        :rcov_opts => ["--sort coverage",
                                       "--no-html",
                                       "--text-coverage",
                                       "--no-color",
                                       "--profile",
                                       "--exclude /gems/,/Library/,/usr/",
                                       "--include spec"],
                        :external => nil
                      }
    config.graph_engine = :bluff
end
