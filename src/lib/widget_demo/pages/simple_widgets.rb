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

Yast.import "UI"

module Yast
  module WidgetDemo
    module Pages
      # Page with simple widgets
      class SimpleWidgets < Base
        def name
          "Simple Widgets"
        end

        # The content of this wizard page.
        # Make sure this still fits into an NCurses 80x24 screen!
        def content
          HSquash(
            Opt(:vstretch),
            MinWidth(
              50,
              VBox(
                VStretch(),
                labels,
                VStretch(),
                input_fields,
                VStretch()
              )
            )
          )
        end

        private

        def labels
          VBox(
            Left(Heading("Heading")),
            Left(Label("Label")),
            Left(Label(Opt(:boldFont), "Label(Opt(:boldFont)")),
            VSpacing(0.3),
            VSpacing(0.3), # 2 * 0.3 because < 0.5 is ignored in NCurses
            Left(Label(Opt(:outputField), "OutputField")),
            VSpacing(0.3),
            Left(Label(Opt(:outputField, :hstretch), "OutputField(Opt(:hstretch))"))
          )
        end

        def input_fields
          VBox(
            Left(InputField("InputField 1")),
            Left(InputField("InputField 2")),
            Left(InputField(Opt(:hstretch), "InputField(Opt(:hstretch)")),
            VSquash(
              HBox(
                InputField(Opt(:shrinkable), "Input"),
                HSpacing(2),
                Top(Label("InputField(Opt(:shrinkable))")),
                HStretch()
              )
            ),
            Left(Password("Password")),
            Left(HSquash(IntField("IntField", 0, 999, 42)))
          )
        end
      end
    end
  end
end
