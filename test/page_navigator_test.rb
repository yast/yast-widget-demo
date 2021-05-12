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
require "widget_demo/page_navigator"
require "widget_demo/pages/simple_widgets"

describe Yast::WidgetDemo::PageNavigator do
  context "empty" do
    subject(:nav) { described_class.new }
    describe "#pages" do
      it "is empty" do
        expect(subject.pages).to be_empty
      end
    end

    describe "#current_page" do
      it "is nil" do
        expect(subject.current_page).to be_nil
      end
    end

    describe "#current_index" do
      it "is 0" do
        expect(subject.current_index).to be == 0
      end
    end

    describe "#next?" do
      it "is false" do
        expect(subject.next?).to be false
      end
    end

    describe "#back?" do
      it "is false" do
        expect(subject.back?).to be false
      end
    end
  end

  context "with 3 pages" do
    subject(:nav) do
      nav = described_class.new
      nav.add_page(Yast::WidgetDemo::Pages::SimpleWidgets.new)
      nav.add_page(Yast::WidgetDemo::Pages::SimpleWidgets.new)
      nav.add_page(Yast::WidgetDemo::Pages::SimpleWidgets.new)
      nav
    end

    describe "#pages" do
      it "has 3 pages" do
        expect(subject.pages.size).to be == 3
      end
    end

    describe "#current_page" do
      it "is a page" do
        expect(subject.current_page.is_a?(Yast::WidgetDemo::Pages::Base)).to be true
      end
    end

    describe "#current_index" do
      it "is 0" do
        expect(subject.current_index).to be == 0
      end
    end

    describe "#next_page" do
      it "moves to the next page" do
        expect(subject.current_index).to be == 0
        subject.next_page
        expect(subject.current_index).to be == 1
        subject.next_page
        expect(subject.current_index).to be == 2
        expect(subject.current_page.is_a?(Yast::WidgetDemo::Pages::Base)).to be true
      end

      it "does not move beyond the last page" do
        subject.next_page
        subject.next_page
        expect(subject.current_index).to be == 2
        subject.next_page
        expect(subject.current_index).to be == 2
        expect(subject.current_page.is_a?(Yast::WidgetDemo::Pages::Base)).to be true
      end
    end

    describe "#prev_page" do
      it "moves back one page" do
        subject.next_page
        subject.next_page
        expect(subject.current_index).to be == 2
        subject.prev_page
        expect(subject.current_index).to be == 1
        expect(subject.current_page.is_a?(Yast::WidgetDemo::Pages::Base)).to be true
      end

      it "does not move back beyond the first page" do
        subject.prev_page
        expect(subject.current_index).to be == 0
        expect(subject.current_page.is_a?(Yast::WidgetDemo::Pages::Base)).to be true
      end
    end

    describe "#next?" do
      it "is true for all pages but the last" do
        expect(subject.next?).to be true
        subject.next_page
        expect(subject.next?).to be true
        subject.next_page
        expect(subject.next?).to be false
        subject.next_page
        # Try to go one page beyond
        expect(subject.next?).to be false
        subject.next_page
      end
    end

    describe "#back?" do
      it "is true for all pages but the first" do
        expect(subject.back?).to be false
        subject.next_page
        expect(subject.back?).to be true
        subject.next_page
        expect(subject.back?).to be true
      end
    end
  end
end
