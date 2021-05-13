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

        def content
          HVSquash(
            MinSize(
              50, 28,
              VBox(
                labels,
                VSpacing(1),
                input_fields,
                VSpacing(0.4), # maintain some minimum spacing
                Bottom(buttons)
              )
            )
          )
        end

        private

        def labels
          VBox(
            Left(Label("Heading")),
            Left(Label("Label")),
            Left(Label(Opt(:boldFont), "Label(Opt(:boldFont)")),
            VSpacing(0.3),
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
            Left(Password("Password"))
          )
        end

        def buttons
          HBox(
            PushButton("PushButton 1"),
            PushButton("PushButton 2"),
            menu_button
          )
        end

        def menu_button
          MenuButton(
            "&MenuButton",
            [
              Item(Id(:menu_item1), "MenuItem &1"),
              Item(Id(:menu_item2), "MenuItem &2"),
              Menu(
                "&Submenu",
                [
                  Item(Id(:menu_item_31), "MenuItem 3&1"),
                  Item(Id(:menu_item_32), "MenuItem 3&2"),
                  Item(Id(:menu_item_33), "MenuItem 3&3")
                ]
              ),
              Item(Id(:menu_item4), "MenuItem &4")
            ]
          )
        end
      end
    end
  end
end
