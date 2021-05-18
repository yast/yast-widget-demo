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
      class Overview < Base
        def name
          "Overview"
        end

        def content
          HVSquash(
            MinSize(
              50, 28,
              VBox(
                HBox(
                  VBox(
                    input_widgets,
                    VStretch()
                  ),
                  HSpacing(3),
                  VBox(
                    labels,
                    VSpacing(1),
                    radio_box,
                    VSpacing(1),
                    check_boxes,
                    VStretch()
                  )
                ),
                rich_text,
                VSpacing(0.4), # maintain some minimum spacing
                Bottom(buttons)
              )
            )
          )
        end

        private

        def labels
          VBox(
            Left(Label("Label")),
            Left(Label(Opt(:outputField), "OutputField"))
          )
        end

        def check_boxes
          VBox(
            Left(CheckBox("Checkbo&x 1", false)),
            Left(CheckBox("Chec&kbox 2", true))
          )
        end

        def radio_box
          Frame(
            "Frame",
            MarginBox(
              1, 0.2,
              RadioButtonGroup(
                VBox(
                  Left(RadioButton("RadioButton &1", true)),
                  Left(RadioButton("RadioButton &2")),
                  Left(RadioButton("RadioButton &3"))
                )
              )
            )
          )
        end

        def input_widgets
          CheckBoxFrame(
            "CheckBox&Frame", true,
            MarginBox(
              0.5, 0.2,
              VBox(
                Left(ComboBox("C&omboBox", items(5))),
                Left(InputField(Opt(:hstretch), "&InputField")),
                Left(
                  ComboBox(
                    Opt(:editable, :hstretch),
                    "ComboBox (&editable)",
                    items(5)
                  )
                ),
                Left(MultiLineEdit("M&ultiLineEdit", lorem_ipsum))
              )
            )
          )
        end

        def lorem_ipsum
          txt = "Lorem ipsum dolor sit amet,\n"
          txt << "consectetur adipiscing elit,\n"
          txt << "sed do eiusmod tempor incididunt."
          txt
        end

        def rich_text
          text = "<h2>RichText</h2>"
          text << lorem_html("dolor")
          text << lorem_html("amet")
          RichText(text)
        end

        # Return a piece of "lorem ipsum" text formatted as HTML with a regexp
        # 'anchor' turned into a hyperlink
        #
        # @param anchor [String]
        # @return [String]
        def lorem_html(anchor)
          html = "<p>#{lorem_ipsum}</p>"
          html.gsub!(anchor, "<a href=\"#{anchor}\">#{anchor}</a>")
          html
        end

        def buttons
          HBox(
            PushButton("&PushButton"),
            menu_button
          )
        end

        def menu_button
          MenuButton(
            "&MenuButton",
            [
              Item(Id(:menu_item1), "MenuItem &1"),
              Item(Id(:menu_item2), "MenuItem &2"),
              Menu("&Submenu", items(3, "MenuItem 3&0")),
              Item(Id(:menu_item4), "MenuItem &4")
            ]
          )
        end
      end
    end
  end
end
