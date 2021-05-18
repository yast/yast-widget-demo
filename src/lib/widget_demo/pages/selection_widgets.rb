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
      # Page with selection widgets (tree, multi selection box)
      class SelectionWidgets < Base
        def name
          "Selection Widgets"
        end

        def content
          VBox(
            VSpacing(0.4),
            MenuBar(main_menus),
            HVCenter(
              HVSquash(
                MinSize(
                  100, 25,
                  HBox(
                    HWeight(1, selbox),
                    HSpacing(1),
                    HWeight(1, multi_selbox),
                    HSpacing(1),
                    HWeight(1, tree)
                  )
                )
              )
            )
          )
        end

        private

        def tree
          Tree("Tree", tree_items)
        end

        def tree_items
          [
            Item("Item 1", items(3, "Item 10")),
            Item(
              "Item 2",
              [
                Item("Item 21"),
                Item("Item 22"),
                Item("Item 23", items(5, "Item 230"), true),
                Item("Item 24", items(5, "Item 240"), true),
                Item("Item 25"),
                Item("Item 26")
              ],
              true # open
            ),
            Item("Item 3", items(4, "Item 30")),
            Item("Item 4", items(7, "Item 40"))
          ]
        end

        def selbox
          SelectionBox("&SelectionBox", items(30))
        end

        def multi_selbox
          MultiSelectionBox("MultiSelectionBox", multi_selbox_items)
        end

        def multi_selbox_items
          items(30) do |item, i|
            # Set the checkmark / "selected" state for some of the items
            item << [3, 4, 5, 11, 12, 14, 17].include?(i)
            item
          end
        end

        def main_menus
          [
            Menu("Men&uBar", items(5, "MenuItem 10")),
            Menu("Menu &2", items(7, "MenuItem 20")),
            Menu("Menu &3", items(4, "MenuItem 30")),
            Menu("Menu &4", items(7, "MenuItem 40"))
          ]
        end
      end
    end
  end
end
