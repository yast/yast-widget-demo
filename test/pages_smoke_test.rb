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
require "widget_demo/pages/simple_widgets.rb"

describe Yast::WidgetDemo::Pages do

  shared_examples "page smoke test" do
    subject(:page) { described_class.new }

    it "has a non-empty name" do
      expect(subject.name).to match(/[A-Za-z0-9_]+/)
    end

    it "has a non-empty page ID" do
      expect(subject.id).to match(/[A-Za-z0-9_]+/)
    end

    it "has non-nil content and does not crash" do
      expect(page.content).not_to be_nil
    end
  end

  describe Yast::WidgetDemo::Pages::SimpleWidgets do
    include_examples "page smoke test"
  end
end
