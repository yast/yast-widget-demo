require "yast/rake"

Yast::Tasks.submit_to :sle15sp7

Yast::Tasks.configuration do |conf|
  # let's ignore the license check for now
  conf.skip_license_check << /.*/
end
