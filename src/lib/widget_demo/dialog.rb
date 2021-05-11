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

Yast.import "UI"

module Yast
  module WidgetDemo
    # Dialog to showcase UI widgets
    class Dialog
  
      include Yast::UIShortcuts
      include Yast::Logger
  
      def initialize
        # to do
      end
  
      # Displays the dialog
      def run
        return unless create_dialog
  
        begin
          return event_loop
        ensure
          close_dialog
        end
      end
  
    private
  
      def create_dialog
        # Intentionally no translation in this module
        UI.OpenDialog(
          MinSize( 50, 10,
            HVCenter(
              VBox(
                Label("Hello, world!"),
                VSpacing( 1 ),
                PushButton(Id(:ok), Opt(:default), "&OK")
              )
            )
          )
        )
      end
  
      def close_dialog
        UI.CloseDialog
      end
  
      def event_loop
        loop do
          case input = UI.UserInput
          when :ok, :cancel # :cancel is WM_CLOSE
            # Break the loop
            break
          else
            log.warn "Unexpected input #{input}"
          end
        end
      end
    end
  end
end
