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
      # Page with check boxes and radio buttons
      class CheckBoxes < Base
        def name
          "Check Boxes"
        end

        # The content of this wizard page.
        # Make sure this still fits into an NCurses 80x24 screen!
        def content
          HVSquash(
            HBox(
              HWeight(3, Top(check_boxes)),
              HWeight(2, HStretch()),
              HWeight(3, Top(radio_boxes))
            )
          )
        end

        def widgets_created
          # Set some of the check boxes to tri-state ("don't care")
          UI.ChangeWidget(Id(:cb3), :Value, nil)
          UI.ChangeWidget(Id(:cb6), :Value, nil)
        end

        private

        def check_boxes
          Frame(
            "Frame",
            MarginBox(
              1, 0.2,
              VBox(
                Left(CheckBox(Id(:cb1), "Checkbox 1", false)),
                Left(CheckBox(Id(:cb2), "Checkbox 2", true)),
                Left(CheckBox(Id(:cb3), "Checkbox 3", false)),
                VSpacing(1),
                Left(CheckBox(Id(:cb4), Opt(:disabled), "Checkbox 4", true)),
                Left(CheckBox(Id(:cb5), Opt(:disabled), "Checkbox 5", false)),
                Left(CheckBox(Id(:cb6), Opt(:disabled), "Checkbox 6", false)),
                VStretch()
              )
            )
          )
        end

        def radio_boxes
          VBox(
            radio_box("RadioButton &0"),
            VSpacing(2),
            radio_box("RadioButton &3", Opt(:disabled))
          )
        end

        # Return a widget term for a radio box
        #
        # @param label [String] label pattern for the radio buttons
        # @param opt [<Yast::Term>] widget options term for each radio button
        #
        # @return [<Yast::Term>] widget term
        #
        def radio_box(label, opt = nil)
          Frame(
            "Frame",
            MarginBox(
              1, 0.2,
              RadioButtonGroup(
                VBox(
                  Left(radio_button(opt, label.next!.dup)),
                  Left(radio_button(opt, label.next!.dup, true)),
                  Left(radio_button(opt, label.next!.dup))
                )
              )
            )
          )
        end

        # Return a term for a RadioButton with or without widget options
        # @param opt [<Yast::Term>, nil] widget options term
        # @param label [String] widget label for the radio button
        # @param checked [Boolean] radio button checked or unchecked?
        #
        # @return [<Yast::Term>] widget term
        #
        def radio_button(opt, label, checked = false)
          if opt.nil?
            RadioButton(label, checked)
          else
            RadioButton(opt, label, checked)
          end
        end
      end
    end
  end
end
