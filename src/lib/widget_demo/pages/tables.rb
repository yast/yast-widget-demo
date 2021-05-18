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
      class Tables < Base
        def name
          "Tables"
        end

        def content
          MarginBox(
            2, 0.4,
            VBox(
              Left(Heading("Table (standard)")),
              standard_table,
              VSpacing(0.4),
              Left(Heading("Table (nested items, multi-selection)")),
              nested_items_table
            )
          )
        end

        private

        def standard_table
          Table(
            Id(:table),
            Header("Column 1", "Column 2", "Column 3", "Column 4", "Column 5"),
            table_items(8, 5, "Cell 0")
          )
        end

        # Generate an array of table items from 'cell_template':
        #
        #   [
        #     Item("Cell 11", "Cell 12", "Cell 13", ...),
        #     Item("Cell 21", "Cell 22", "Cell 23", ...),
        #     ...
        #   ]
        #
        # @param row_count [Integer] number of table rows
        # @param column_count [Integer] number of table columns
        # @param cell_template [String] template for cell text ("Cell 0")
        #
        # @return [Yast::Term]
        def table_items(row_count, column_count, cell_template)
          items = []
          row_count.times { items << table_row(column_count, cell_template.next!.dup + "0") }
          items
        end

        # Generate a cell row from 'cell_template':
        #
        #   Item("Cell 11", "Cell 12", "Cell 13", ...)
        #
        # @param column_count [Integer] number of columns
        # @param cell_template [String] template for cell text ("Cell 10")
        #
        # @return [Yast::Term]
        def table_row(column_count, cell_template)
          item_term = Item()
          column_count.times { item_term << cell_template.next!.dup }
          item_term
        end

        # Table setup and content taken from ycp-ui-bindings/examples/Table-nested-multiSel.rb
        def nested_items_table
          Table(
            Id(:table),
            Opt(:multiSelection),
            Header("Device", "Size", "Type", "Mount Point"),
            disk_items
          )
        end

        def disk_items
          [
            Item(Id(:sda), "/dev/sda", "931.5G", "", "", sda_items, :open),
            Item(Id(:sdb), "/dev/sdb", "931.5G", "", "", sdb_items, :closed),
            Item(Id(:sdc), "/dev/sdc", "232.9G", "", "", sdc_items, :open)
          ]
        end

        def sda_items
          [
            Item(Id(:sda1), "/dev/sda1", "97.7G", "ntfs", "/win/boot"),
            Item(Id(:sda2), "/dev/sda2", "833.9G", "ntfs", "/win/app")
          ]
        end

        def sdb_items
          [
            Item(Id(:sdb1), "/dev/sdb1", "2.0G", "swap"),
            Item(Id(:sdb2), "/dev/sdb2", "29.4G", "ext4", "/hd-root-leap-42"),
            Item(Id(:sdb3), "/dev/sdb3", "29.4G", "ext4", "/hd-root-leap-15-0"),
            Item(Id(:sdb4), "/dev/sdb4", "855.8G", "xfs", "/work")
          ]
        end

        def sdc_items
          [
            Item(Id(:sdc1), "/dev/sdc1", "2.0G", "swap", "[swap]"),
            Item(Id(:sdc2), "/dev/sdc2", "29.4G", "ext4", "/ssd-root-leap-15-1"),
            Item(Id(:sdc3), "/dev/sdc3", "29.4G", "ext4", "/"),
            Item(Id(:sdc4), "/dev/sdc4", "167.2G", "ext4", "/ssd-work")
          ]
        end
      end
    end
  end
end
