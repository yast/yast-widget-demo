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
require "abstract_method"

Yast.import "UI"

module Yast
  module WidgetDemo
    module Pages
      # Base class for wizard pages
      class Base
        include Yast::UIShortcuts
        include Yast::Logger

        # @!method name
        #   @return [String] a name for this page
        abstract_method :name

        # @!method content
        #   @return [<YaST::Term>] the widget content of this page
        abstract_method :content

        # @return [String] the wizard step ID for this page
        def id
          name
        end

        # Event handler for this page. This gives the page a chance to react to
        # events from widgets from this page. Return a symbol for the caller to
        # process (:close) as an event ID or 'nil' to let the caller handle
        # this event.
        #
        # Do not handle the wizard buttons (:next, :back, :abort) here.
        #
        # @param event [<UI::Event>]
        # @return [symbol, nil]
        def handle_event(_event)
          nil
        end

        # Additional initializations to be done after the page's widgets are
        # created, but before the event handler. This can be used to populate
        # lists and tables with content.
        def widgets_created
          nil
        end

        protected

        # Generate an array of UI item-terms based on the specified
        # template string:
        #
        #   [
        #     Item("Item 1"),
        #     Item("Item 2"),
        #     Item("Item 3")
        #   ]
        #
        # An optional code block can be used to modify each item, e.g. to add a
        # boolean for a selected state.
        #
        # @param count [Integer] number of items
        # @param template [String] template for the item
        #
        # @return [Array<Term<String>>]
        #
        def items(count, item_template = nil)
          item_template ||= (count < 10) ? "Item 0" : "Item 00"
          result = []
          count.times do |i|
            item_term = Item(item_template.next!.dup)
            item_term = yield(item_term, i) if block_given?
            result << item_term unless item_term.nil?
          end
          result
        end
      end
    end
  end
end
