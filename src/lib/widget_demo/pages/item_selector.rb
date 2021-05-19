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
      class ItemSelector < Base
        def initialize
          @single_selection = true
        end

        def name
          "Item Selector"
        end

        # The content of this wizard page.
        # Make sure this still fits into an NCurses 80x24 screen!
        def content
          HVSquash(
            MinSize(
              50, 28,
              VBox(
                Left(Heading("ItemSelector")),
                ReplacePoint(
                  Id(:rp_item_selector),
                  item_selector
                ),
                VSpacing(2),
                radio_box
              )
            )
          )
        end

        def handle_event(event)
          return nil if event.nil?

          event_id = event["ID"]
          case event_id
          when :single_selection, :multi_selection
            replace_item_selector
            return :event_handled # Random symbol that the caller doesn't handle
          end
          nil # Let the caller handle this event
        end

        private

        def item_selector
          items = sel_items(7)

          if @single_selection
            SingleItemSelector(items)
          else
            MultiItemSelector(items)
          end
        end

        def sel_items(count)
          # Use the standard items from the parent class,
          # but add some "lorem ipsum" text as multi-line description
          items(count) do |item|
            item << lorem_ipsum
            item
          end
        end

        def radio_box
          Left(
            RadioButtonGroup(
              Frame(
                "Selection Mode",
                MarginBox(
                  1, 0.2,
                  VBox(
                    Left(
                      RadioButton(
                        Id(:single_selection), Opt(:notify),
                        "&Single Selection", @single_selection
                      )
                    ),
                    Left(
                      RadioButton(
                        Id(:multi_selection), Opt(:notify),
                        "&Multi-Selection", !@single_selection
                      )
                    )
                  )
                )
              )
            )
          )
        end

        def replace_item_selector
          @single_selection = UI.QueryWidget(Id(:single_selection), :Value)
          log.info("Replacing ItemSelector; single selection: #{@single_selection}")
          UI.ReplaceWidget(Id(:rp_item_selector), item_selector)
        end

        def lorem_ipsum
          txt = "Lorem ipsum dolor sit amet, consectetur adipiscing\n"
          txt << "elit, sed do eiusmod tempor incididunt."
          txt
        end
      end
    end
  end
end
