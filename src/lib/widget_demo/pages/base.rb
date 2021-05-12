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
        #   @return [<YaST::Term] the widget content of this page
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
        # @param event [<UI::Event]
        # @return [symbol, nil]
        def handle_event(event)
          nil
        end
      end
    end
  end
end
