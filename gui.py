import sys
from PySide6 import QtCore, QtWidgets, QtGui
from PySide6.QtCore import Qt
from PySide6.QtGui import QPixmap
from PySide6.QtWidgets import (
    QApplication,
    QVBoxLayout,
    QCheckBox,
    QComboBox,
    QDial,
    QDoubleSpinBox,
    QWidget, 
    QLabel,
    QLineEdit,
    QListWidget,
    QMainWindow,
    QSlider,
    QSpinBox,
)

class MainWindow(QMainWindow):
    def __init__(self):
        super().__init__()
        with open("style.qss", "r") as f:
            self.style = f.read()
        self.setWindowTitle("Lively Wallpaper Playlist")

        container = QWidget()
        self.setCentralWidget(container)

        self.layout = QVBoxLayout(container)

        self.setStyleSheet(self.style)

        self.stack = QtWidgets.QStackedWidget()
        self.layout.addWidget(self.stack)

        self.pages = {}
        self.pages["home"] = HomePage()
        self.pages["settings"] = SettingsPage()
        self.pages["wallpaper_grouping"] = WallpaperGroupingPage()
        self.pages["shuffle_rules"] = ShuffleRulesPage()
        self.pages["report_bug"] = ReportBugPage()

        self.stack.addWidget(self.pages["home"])
        self.stack.addWidget(self.pages["settings"])
        self.stack.addWidget(self.pages["wallpaper_grouping"])
        self.stack.addWidget(self.pages["shuffle_rules"])
        self.stack.addWidget(self.pages["report_bug"])

        self.topbar = TopBar(stack=self.stack, pages=self.pages)
        self.topbar.setStyleSheet(self.style)
        self.layout.insertWidget(0, self.topbar)

class TopBar(QtWidgets.QWidget):
    def __init__(self, stack=None, pages=None):
        super().__init__()
        self.stack = stack
        self.pages = pages
        self.button_margin = 10
        self.setup_ui()

    def setup_ui(self):
        layout = QtWidgets.QHBoxLayout(self)
        layout.setContentsMargins(10, 10, 10, 10)

        self.topbar_widgets = {}
        self.topbar_widgets["home_button"] = QtWidgets.QPushButton("  Home")
        self.topbar_widgets["wallpaper_grouping_button"] = QtWidgets.QPushButton("  Wallpaper Grouping")
        self.topbar_widgets["shuffle_rules_button"] = QtWidgets.QPushButton("  Shuffle Rules")
        self.topbar_widgets["report_bug_button"] = QtWidgets.QPushButton("")
        self.topbar_widgets["settings_button"] = QtWidgets.QPushButton("")

        layout.addWidget(self.topbar_widgets["home_button"])
        self.topbar_widgets["home_button"].setSizePolicy(QtWidgets.QSizePolicy.Policy.Fixed, QtWidgets.QSizePolicy.Policy.Fixed)
        layout.setSpacing(self.button_margin)
        layout.addWidget(self.topbar_widgets["wallpaper_grouping_button"])
        self.topbar_widgets["wallpaper_grouping_button"].setSizePolicy(QtWidgets.QSizePolicy.Policy.Fixed, QtWidgets.QSizePolicy.Policy.Fixed)
        layout.setSpacing(self.button_margin)
        layout.addWidget(self.topbar_widgets["shuffle_rules_button"])
        self.topbar_widgets["shuffle_rules_button"].setSizePolicy(QtWidgets.QSizePolicy.Policy.Fixed, QtWidgets.QSizePolicy.Policy.Fixed)
        layout.setSpacing(self.button_margin)
        layout.addSpacing(100)
        layout.addStretch()
        layout.addWidget(self.topbar_widgets["report_bug_button"])
        self.topbar_widgets["report_bug_button"].setSizePolicy(QtWidgets.QSizePolicy.Policy.Fixed, QtWidgets.QSizePolicy.Policy.Fixed)
        layout.setSpacing(self.button_margin)
        layout.addWidget(self.topbar_widgets["settings_button"])
        self.topbar_widgets["settings_button"].setSizePolicy(QtWidgets.QSizePolicy.Policy.Fixed, QtWidgets.QSizePolicy.Policy.Fixed)
        layout.setSpacing(self.button_margin)

        self.topbar_widgets["home_button"].clicked.connect(lambda: self.stack.setCurrentWidget(self.pages["home"]))
        self.topbar_widgets["wallpaper_grouping_button"].clicked.connect(lambda: self.stack.setCurrentWidget(self.pages["wallpaper_grouping"]))
        self.topbar_widgets["shuffle_rules_button"].clicked.connect(lambda: self.stack.setCurrentWidget(self.pages["shuffle_rules"]))
        self.topbar_widgets["report_bug_button"].clicked.connect(lambda: self.stack.setCurrentWidget(self.pages["report_bug"]))
        self.topbar_widgets["settings_button"].clicked.connect(lambda: self.stack.setCurrentWidget(self.pages["settings"]))

        self.topbar_widgets["home_button"].setIcon(QtGui.QIcon("icons/home.png"))
        self.topbar_widgets["home_button"].setIconSize(QtCore.QSize(24,24))
        self.topbar_widgets["wallpaper_grouping_button"].setIcon(QtGui.QIcon("icons/folder.png"))
        self.topbar_widgets["wallpaper_grouping_button"].setIconSize(QtCore.QSize(24,24))
        self.topbar_widgets["shuffle_rules_button"].setIcon(QtGui.QIcon("icons/settings.png"))
        self.topbar_widgets["shuffle_rules_button"].setIconSize(QtCore.QSize(24,24))
        self.topbar_widgets["report_bug_button"].setIcon(QtGui.QIcon("icons/bug.png"))
        self.topbar_widgets["report_bug_button"].setIconSize(QtCore.QSize(24,24))
        self.topbar_widgets["settings_button"].setIcon(QtGui.QIcon("icons/gear.png"))
        self.topbar_widgets["settings_button"].setIconSize(QtCore.QSize(24,24))

class HomePage(QtWidgets.QWidget):
    def __init__(self):
        super().__init__()
        self.setup_ui()

    def setup_ui(self):
        layout = QtWidgets.QVBoxLayout(self)
        title = QLabel("Home")
        font = title.font()
        font.setPointSize(30)
        title.setFont(font)

        layout.addWidget(title, alignment=Qt.AlignmentFlag.AlignCenter)
        layout.addStretch()   

class SettingsPage(QtWidgets.QWidget):
    def __init__(self):
        super().__init__()
        self.setup_ui()

    def setup_ui(self):
        layout = QtWidgets.QVBoxLayout(self)

        title = QLabel("Settings")
        font = title.font()
        font.setPointSize(30)
        title.setFont(font)

        layout.addWidget(title, alignment=Qt.AlignmentFlag.AlignCenter)
        layout.addStretch()   

class WallpaperGroupingPage(QtWidgets.QWidget):
    def __init__(self):
        super().__init__()
        self.setup_ui()

    def setup_ui(self):
        layout = QtWidgets.QVBoxLayout(self)
        title = QLabel("Wallpaper Grouping")
        font = title.font()
        font.setPointSize(30)
        title.setFont(font)
        
        layout.addWidget(title, alignment=Qt.AlignmentFlag.AlignCenter)
        layout.addStretch()   

class ShuffleRulesPage(QtWidgets.QWidget):
    def __init__(self):
        super().__init__()
        self.setup_ui()

    def setup_ui(self):
        layout = QVBoxLayout(self)
        title = QLabel("Shuffle Rules")
        font = title.font()
        font.setPointSize(30)
        title.setFont(font)

        layout.addWidget(title, alignment=Qt.AlignmentFlag.AlignCenter)
        layout.addStretch()   

class ReportBugPage(QtWidgets.QWidget):
    def __init__(self):
        super().__init__()
        self.setup_ui()
        self.include_diagnostics = True

    def setup_ui(self):
        layout = QVBoxLayout(self)

        title = QLabel("Report a bug")
        font = title.font()
        font.setPointSize(30)
        title.setFont(font)

        checkbox = QCheckBox("Include diagnostic data")
        checkbox.setCheckState(Qt.CheckState.Checked)
        checkbox.stateChanged.connect(
            lambda state: setattr(
                self,
                "include_diagnostics",
                state == Qt.CheckState.Checked.value
            )
        )

        layout.addWidget(title, alignment=Qt.AlignmentFlag.AlignCenter)
        layout.addStretch()      # takes up all extra space
        layout.addWidget(checkbox)
        

if __name__ == "__main__":
    app = QtWidgets.QApplication([])

    widget = MainWindow()
    widget.resize(750, 800)
    widget.show()

    sys.exit(app.exec())