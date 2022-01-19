# Copyright (c) 2021 SUSE LLC
#
# All Rights Reserved.
#
# This program is free software; you can redistribute it and/or modify it
# under the terms of version 2 of the GNU General Public License as published
# by the Free Software Foundation.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
# more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, contact SUSE LLC.
#
# To contact SUSE LLC about this file by physical or electronic mail, you may
# find current contact information at www.suse.com.

# Set the paths
SRC_PATH = File.expand_path("../src", __dir__)
DATA_PATH = File.expand_path("data", __dir__)
TEST_PATH = File.expand_path(__dir__)
ENV["Y2DIR"] = SRC_PATH

require "yast"

# configure RSpec
RSpec.configure do |config|
  config.mock_with :rspec do |c|
    # verify that the mocked methods actually exist
    # https://relishapp.com/rspec/rspec-mocks/v/3-0/docs/verifying-doubles/partial-doubles
    c.verify_partial_doubles = true
  end
end
