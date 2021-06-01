# ------------------------------------------------------------------------------
# Copyright (c) 2021 SUSE LLC, All Rights Reserved.
#
# This program is free software; you can redistribute it and/or modify it under
# the terms of version 2 of the GNU General Public License as published by the
# Free Software Foundation.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
#
# ------------------------------------------------------------------------------

require "yast"

module Installation
  module Console
    # extend the console commands definitions
    class Commands
      # define the "widget_demo" command in the expert console
      def widget_demo
        run_yast_module("widget_demo")
      end

      private

      # description of the command
      # @return [String] the description text displayed when running
      #  the "commands" command
      def widget_demo_description
        description = "Starts a widget demo application, designed for testing\n" \
          "the UI style and colors."

        if !Yast::UI.TextMode
          # Qt UI has a special shortcut to start the style editor
          description += " Use the Ctrl+Alt+Shift+S keyboard shortcut\nto start " \
            "the style editor."
        end

        description
      end
    end
  end
end
