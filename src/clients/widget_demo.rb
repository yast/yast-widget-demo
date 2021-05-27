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

require "widget_demo/dialog"

# YaST client to showcase UI widgets in a wizard sequence.
#
# In the Qt UI, this uses one of the .qss widget style sheets from the YaST
# theme directory /usr/share/YaST2/theme/current/wizard; by default, it
# uses style.qss.
#
# Set the Y2STYLE environment variable to select a different style sheet:
#
#   export Y2STYLE=installation.qss
#
# Start the style sheet editor with Ctrl-Shift-Alt-S.
#
demo = Yast::WidgetDemo::Dialog.new
### Uncomment to override the default settings:
# demo.enable_dialog_title = false
# demo.enable_wizard_steps = false
demo.run
