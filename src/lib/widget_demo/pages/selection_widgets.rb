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

        # Overwrite the wizard heading for this page to avoid the menu bar
        # "hanging" somewhere in the upper third of the page
        def wizard_heading
          ""
        end

        # The content of this wizard page.
        # Make sure this still fits into an NCurses 80x24 screen!
        def content
          VBox(
            VSpacing(0.4),
            MenuBar(Id(:menu_bar), main_menus),
            VSpacing(1),
            HCenter(
              HSquash(
                MinWidth(
                  100,
                  HBox(
                    HWeight(1, selbox),
                    HSpacing(1),
                    HWeight(1, multi_selbox),
                    HSpacing(1),
                    HWeight(1, tree)
                  )
                )
              )
            ),
            VSpacing(0.4)
          )
        end

        def widgets_created
          disable_some_menu_items
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
            Menu("Men&uBar", menu_1_items),
            Menu("Menu &2", items(7, "MenuItem 2&0")),
            Menu("Menu &3", items(4, "MenuItem 3&0")),
            Menu("Menu &4", items(7, "MenuItem 4&0"))
          ]
        end

        # Make the first menu a bit special with a submenu and a separator
        def menu_1_items
          menu_items = items(3, "MenuItem 1&0")
          menu_items << Menu("S&ubmenu", items(4, "MenuItem 140"))
          menu_items << Item("MenuItem 1&5")
          menu_items << Item("---")
          menu_items << Item("MenuItem 1&6")
          menu_items << Item("MenuItem 1&7")
        end

        def disable_some_menu_items
          UI.ChangeWidget(
            :menu_bar,
            :EnabledItems,
            "MenuItem 12"  => false,
            "MenuItem 17"  => false,
            "MenuItem 142" => false,
            "MenuItem 22"  => false,
            "MenuItem 33"  => false,
            "MenuItem 44"  => false
          )
        end
      end
    end
  end
end
