Ransack.configure do |config|
  config.add_predicate "lteq_end_of_day",
                      arel_predicate: "lteq",
                      formatter: proc { |v|
                        DateTime.parse(v).end_of_day rescue nil
                      },
                      type: :date_time
end
