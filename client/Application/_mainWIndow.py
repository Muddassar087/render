# Main window for our interface
import tkinter as tk
from tkinter import filedialog as fileSelector
from tkinter import simpledialog
from tkinter.ttk import Style
from tkinter import font
from tkinter.constants import S
import scripts.model as model
from filepanel import Panel as file_panel
from tablepanel import Panel as table_panel, ServerStatus as server_status
import scripts.__init__ as init

class MainApp(tk.Tk):
	def __init__(self):
		super().__init__()
		self._config()
		self.render()
	
	def _config(self):
		self.config(menu=self.__renderMenu())
		self.geometry("1400x850+200+100")
		self.bind('<Control-o>', self._filesSelected)

	def __renderMenu(self):

		def getServer():
			init.serverIp["ip"] = simpledialog.askstring(title="Add server", prompt="Add servers IP")
			self.serverStatus.update(color="green")

		menubar = tk.Menu(self, background="#F9F9F9", font=("Roboto", 12))
		filemenu = tk.Menu(menubar, tearoff=0,)
		filemenu.add_command(label="Open Files",command=self._filesSelected)
		
		servermenu = tk.Menu(menubar, tearoff=False)
		servermenu.add_command(label='Add server', command=getServer)

		menubar.add_cascade(label='File',menu=filemenu)
		menubar.add_cascade(label='Server',menu=servermenu)
		menubar.add_cascade(label='Renderer About us',menu=servermenu)
		return menubar

	def _filesSelected(self, event=None):
		__names = fileSelector.askopenfilenames()
		model.paths = __names
		model.names = model.getFileNames()
		self.filepanel.buildList(list(model.names.keys()))

	def render(self):
		self.filepanel = file_panel(self)
		self.tablepanel = table_panel(self)
		self.serverStatus = server_status(self)
		init._instances["serverStatus"] = self.serverStatus
		init._instances["filepnanel"] = self.filepanel
		init._instances["tablepanel"] = self.tablepanel
		


if __name__ == "__main__":
	window = MainApp()
	init._instances["root"] = window
	# a = int(input("Debug: enter -1 to exit \n"))
	# while a > 0:
	# 	p = list(transferringFilesFrames.keys())[a]
	# 	pan = transferringFilesFrames[p]
	# 	pan.update(val="12")
	# 	a = int(input("enter more"))
	
	window.mainloop()