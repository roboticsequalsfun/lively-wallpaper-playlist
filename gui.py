import sys
from PySide6 import QtCore, QtWidgets, QtGui

class MainWindow(QtWidgets.QWidget):
    def __init__(self):
        super().__init__()
        self.setup_ui()
        self.create_pages()
        self.register_pages()
        self.setup_topbar()

    def setup_topbar(self):
        self.topbar = TopBar(stack=self.stack, pages=self.pages)
        self.layout.insertWidget(0, self.topbar)

    def setup_ui(self):
        self.layout = QtWidgets.QVBoxLayout(self)
        self.stack = QtWidgets.QStackedWidget()
        self.layout.addWidget(self.stack)

    def create_pages(self):
        self.pages = {}
        self.pages["home"] = HomePage()
        self.pages["settings"] = SettingsPage()
        self.pages["wallpaper_grouping"] = WallpaperGroupingPage()
        self.pages["shuffle_rules"] = ShuffleRulesPage()
        self.pages["report_bug"] = ReportBugPage()

    def register_pages(self):
        self.stack.addWidget(self.pages["home"])
        self.stack.addWidget(self.pages["settings"])
        self.stack.addWidget(self.pages["wallpaper_grouping"])
        self.stack.addWidget(self.pages["shuffle_rules"])
        self.stack.addWidget(self.pages["report_bug"])

class TopBar(QtWidgets.QWidget):
    def __init__(self, stack=None, pages=None):
        super().__init__()
        self.stack = stack
        self.pages = pages
        self.setup_ui()

    def setup_ui(self):
        layout = QtWidgets.QVBoxLayout(self)
        self.topbar_widgets = {}
        self.topbar_widgets["home_button"] = QtWidgets.QPushButton("Home")
        self.topbar_widgets["settings_button"] = QtWidgets.QPushButton("Settings")
        self.topbar_widgets["wallpaper_grouping_button"] = QtWidgets.QPushButton("Wallpaper Grouping")
        self.topbar_widgets["shuffle_rules_button"] = QtWidgets.QPushButton("Shuffle Rules")
        self.topbar_widgets["report_bug_button"] = QtWidgets.QPushButton("Report Bug")

        layout.addWidget(self.topbar_widgets["home_button"])
        layout.addWidget(self.topbar_widgets["settings_button"])
        layout.addWidget(self.topbar_widgets["wallpaper_grouping_button"])
        layout.addWidget(self.topbar_widgets["shuffle_rules_button"])
        layout.addWidget(self.topbar_widgets["report_bug_button"])

        self.topbar_widgets["home_button"].clicked.connect(lambda: self.stack.setCurrentWidget(self.pages["home"]))
        self.topbar_widgets["settings_button"].clicked.connect(lambda: self.stack.setCurrentWidget(self.pages["settings"]))
        self.topbar_widgets["wallpaper_grouping_button"].clicked.connect(lambda: self.stack.setCurrentWidget(self.pages["wallpaper_grouping"]))
        self.topbar_widgets["shuffle_rules_button"].clicked.connect(lambda: self.stack.setCurrentWidget(self.pages["shuffle_rules"]))
        self.topbar_widgets["report_bug_button"].clicked.connect(lambda: self.stack.setCurrentWidget(self.pages["report_bug"]))

class HomePage(QtWidgets.QWidget):
    def __init__(self):
        super().__init__()
        self.setup_ui()

    def setup_ui(self):
        layout = QtWidgets.QVBoxLayout(self)
        label = QtWidgets.QLabel("Welcome to the Home Page!")
        layout.addWidget(label)

class SettingsPage(QtWidgets.QWidget):
    def __init__(self):
        super().__init__()
        self.setup_ui()

    def setup_ui(self):
        layout = QtWidgets.QVBoxLayout(self)
        label = QtWidgets.QLabel("Settings Page")
        layout.addWidget(label)

class WallpaperGroupingPage(QtWidgets.QWidget):
    def __init__(self):
        super().__init__()
        self.setup_ui()

    def setup_ui(self):
        layout = QtWidgets.QVBoxLayout(self)
        label = QtWidgets.QLabel("Wallpaper Grouping Page")
        layout.addWidget(label)

class ShuffleRulesPage(QtWidgets.QWidget):
    def __init__(self):
        super().__init__()
        self.setup_ui()

    def setup_ui(self):
        layout = QtWidgets.QVBoxLayout(self)
        label = QtWidgets.QLabel("Shuffle Rules Page")
        layout.addWidget(label)

class ReportBugPage(QtWidgets.QWidget):
    def __init__(self):
        super().__init__()
        self.setup_ui()

    def setup_ui(self):
        layout = QtWidgets.QVBoxLayout(self)
        label = QtWidgets.QLabel("Report Bug Page")
        layout.addWidget(label)

if __name__ == "__main__":
    app = QtWidgets.QApplication([])

    widget = MainWindow()
    widget.resize(750, 800)
    widget.show()

    sys.exit(app.exec())