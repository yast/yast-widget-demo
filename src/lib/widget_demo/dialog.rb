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
require "widget_demo/page_navigator"
require "widget_demo/pages/overview"
require "widget_demo/pages/simple_widgets"

Yast.import "UI"
Yast.import "Wizard"
Yast.import "Label"

module Yast
  module WidgetDemo
    # Dialog to showcase UI widgets
    class Dialog
      include Yast::UIShortcuts
      include Yast::Logger

      def initialize
        @page_navigator = PageNavigator.new
      end

      # Displays the dialog
      def run
        create_dialog
        nav.add_page(Pages::Overview.new)
        nav.add_page(Pages::SimpleWidgets.new)
        set_wizard_steps
        show_current_page

        begin
          return event_loop
        ensure
          close_dialog
        end
      end

      def nav
        @page_navigator
      end

      def current_page
        nav.current_page
      end

      def pages
        nav.pages
      end

      private

      def create_dialog
        Wizard.OpenNextBackStepsDialog
      end

      def close_dialog
        UI.CloseDialog
      end

      def show_current_page
        page = current_page
        # Always enable the "Next" button: If there is no more next page,
        # it will have the label "Finish", but we still need it to work
        Wizard.SetContents(page.name, page.content, help_text, nav.back?, true)
        page.widgets_created
        mark_wizard_step(page.id)
        update_wizard_buttons
      end

      def help_text
        # Intentionally no translations in this module
        "Help text"
      end

      def set_wizard_steps
        delete_wizard_steps
        add_wizard_step_heading("Widget Demo")
        nav.pages.each { |page| add_wizard_step(page.name, page.id) }
        # FIXME: TO DO
        ### add_wizard_step_heading("Package Management")
        ### add_wifzard_step("PatternSelector", "pattern-sel")
        ### add_wizard_step("PackageSelector", "pkg-sel")
      end

      def delete_wizard_steps
        UI.WizardCommand(Yast.term(:DeleteSteps))
      end

      def add_wizard_step_heading(text)
        # This is safe to use even with NCurses: It does nothing
        UI.WizardCommand(Yast.term(:AddStepHeading, text))
      end

      def add_wizard_step(text, step_id = nil)
        # Steps without an ID are ignored
        UI.WizardCommand(Yast.term(:AddStep, text, step_id))
      end

      def mark_wizard_step(step_id)
        UI.WizardCommand(Yast.term(:UpdateSteps))
        UI.WizardCommand(Yast.term(:SetCurrentStep, step_id))
      end

      def update_wizard_buttons
        if nav.next?
          Wizard.SetNextButton(:next, Label.NextButton)
        else
          Wizard.SetNextButton(:finish, Label.FinishButton)
        end
      end

      def event_loop
        loop do
          event = UI.WaitForEvent
          event_id = current_page.handle_event(event) || event["ID"]
          # log.info("Handling #{event_id}")
          case event_id
          when :next
            nav.next_page
            show_current_page
          when :back
            nav.prev_page
            show_current_page
          when :finish, :abort, :cancel # :cancel is WM_CLOSE
            # Break the loop
            log.info("Closing")
            break
          end
        end
      end
    end
  end
end
