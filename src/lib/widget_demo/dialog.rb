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
require "widget_demo/pages/simple_widgets"

Yast.import "UI"
Yast.import "Wizard"

module Yast
  module WidgetDemo
    # Dialog to showcase UI widgets
    class Dialog
      include Yast::UIShortcuts
      include Yast::Logger

      def initialize
        @next_step_id = "step_00"
        @page = Pages::SimpleWidgets.new
      end

      # Displays the dialog
      def run
        create_dialog
        show_page(@page.content)
        set_wizard_steps

        begin
          return event_loop
        ensure
          close_dialog
        end
      end

      private

      def create_dialog
        Wizard.OpenNextBackStepsDialog
      end

      def close_dialog
        UI.CloseDialog
      end

      def show_page(page_contents)
        title = "Wizard Dialog"
        has_back = false
        has_next = true
        Wizard.SetContents(title, page_contents, help_text, has_back, has_next)
      end

      def page1
        # Intentionally no translations in this module
        Label("Hello, world!")
      end

      def help_text
        # Intentionally no translations in this module
        "Help text"
      end

      def set_wizard_steps
        delete_wizard_steps
        add_wizard_step_heading("Widget Demo")
        add_wizard_step("Simple Widgets")
        add_wizard_step("Selection Widgets")
        add_wizard_step("Table")
        add_wizard_step("Tree")
        add_wizard_step_heading("Package Management")
        add_wizard_step("PatternSelector")
        add_wizard_step("PackageSelector")
        mark_wizard_step("step_01")
      end

      def delete_wizard_steps
        UI.WizardCommand(Yast.term(:DeleteSteps))
        @next_step_id = "step_00"
      end

      def add_wizard_step_heading(text)
        # This is safe to use even with NCurses: It does nothing
        UI.WizardCommand(Yast.term(:AddStepHeading, text))
      end

      def add_wizard_step(text, step_id = nil)
        # Steps without an ID are ignored
        step_id ||= @next_step_id.next!
        UI.WizardCommand(Yast.term(:AddStep, text, step_id))
      end

      def mark_wizard_step(step_id)
        UI.WizardCommand(Yast.term(:SetCurrentStep, step_id))
      end

      def event_loop
        loop do
          event = UI.WaitForEvent
          # event_id = @navigator.current_page.handle_event(event) || event["ID"]
          event_id = event["ID"]
          log.info("Handling #{event_id}")
          case event_id
          when :next
            @navigator.next_page
          when :back
            @navigator.prev_page
          when :close, :abort, :cancel # :cancel is WM_CLOSE
            # Break the loop
            log.info("Closing")
            break
          end
        end
      end
    end
  end
end
