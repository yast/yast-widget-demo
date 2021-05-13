#! rspec
#
#  Copyright (c) 2021 SUSE LLC.
#  All Rights Reserved.
#
#  This program is free software; you can redistribute it and/or
#  modify it under the terms of version 2 or 3 of the GNU General
#  Public License as published by the Free Software Foundation.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.   See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, contact SUSE LLC.
#
#  To contact SUSE about this file by physical or electronic mail,
#  you may find current contact information at www.suse.com

require_relative "spec_helper"
require "widget_demo/dialog"

describe Yast::WidgetDemo::Dialog do
  subject(:client) { described_class.new }

  describe "#run" do
    it "does not crash" do
      allow(Yast::UI).to receive(:WaitForEvent).and_return("ID" => :cancel)
      client.run
    end
  end
end
