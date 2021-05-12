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

require "yast"
require "widget_demo/pages/base"

module Yast
  module WidgetDemo
    # Class to navigate forward and backward between wizard pages
    class PageNavigator
      attr_reader :pages, :current_index

      def initialize
        @pages = []
        @current_index = 0
      end

      # Add a page.
      # @param page [<Pages::Base>]
      def add_page(page)
        @pages << page
      end

      # Return the current page or nil if there is none.
      # @return [<Pages::Base>]
      def current_page
        return nil if @pages.empty?

        @pages[current_index]
      end

      # Navigate to the next page if there is one.
      def next_page
        @current_index += 1 if next?
      end

      # Navigate to the previous page if there is one.
      def prev_page
        @current_index -= 1 if back?
      end

      # Check if the current page has a next page.
      # @return [Boolean]
      def next?
        @current_index < @pages.size - 1
      end

      # Check if the current page has a previous page.
      # @return [Boolean]
      def back?
        @current_index > 0
      end
    end
  end
end
