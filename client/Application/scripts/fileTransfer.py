from typing import Sized
from scripts.__init__ import *
import sys ,time, socket, json,colorama, math

class Client:
    # client always connects with the server
    def __init__(self) -> None:
        self.client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self._connect()

    def _connect(self):
        args = self.getArgs()
        if type(args) == tuple and len(args) > 1:
            self.client.connect((sys.argv[4], 5000))
            self.start()
        if self.getArgs() == None:
            self._displayMenu()

    def getArgs(self):
        try:
            return (sys.argv[2] ,sys.argv[4])
        except Exception as err:
            return None

    def _displayMenu(self):
        time.sleep(1)
        print(colorama.Fore.LIGHTRED_EX,"\nNote:",colorama.Style.RESET_ALL," You can pass argument such as command and file destination given as follows if connection cannot be made try send with ip as well:\n")
        print("Commands\tArguments\n")
        print("-s\t\t\"file_name.ext\" (File must exist)\n")
        print(colorama.Fore.LIGHTYELLOW_EX,"-s \"file_name.ext\" -ip <your ip address> '::without braces::'\n", colorama.Style.RESET_ALL)

    def start(self):
        _fileName = self.getArgs()[0]
        fileName = self.getFileName(_fileName)
        fileType = self.getFileType(fileName)
        size = self.getFileSize(_fileName)
        buffer = BUFFER
        if fileType == "video":
            buffer = VIDEOBUFFER
        dictionary = {
            "size":size,
            "type":fileType,
            "fileName":fileName
        }
        dictionary = json.dumps(dictionary)
        
        self.client.send(f"{dictionary}".encode(FORMAT))
        
        while True:
            data = self.client.recv(VIDEOBUFFER).decode(FORMAT)
            if data == START_SENDING:
                print("SENDING file...")
                file = open(_fileName, 'rb')
                if file:
                    s = 0.0
                    _chunck = file.read(buffer)
                    while _chunck:
                        s += len(_chunck)
                        self.pBar(math.floor((s/1024/1024/size) * 100))
                        self.client.sendall(_chunck)
                        _chunck = file.read(buffer)
                else:
                    raise FileNotFoundError().strerror
                file.close()
                break
        self.client.close()
        
    def getFileType(self, filename):
        _ext = filename[-3:] if filename[-4] == '.' else filename[-4:]
        if IMAGE_EXT.__contains__(_ext):
            return "image"
        elif VIDEO_EXT.__contains__(_ext):
            return "video"
        elif DOC_EXT.__contains__(_ext):
            return "doc"
        elif MUSIC_EXT.__contians__(_ext):
            return "audio"

    def getFileSize(self, fileName):
        file = open(fileName, 'rb')
        size = len(file.read())
        file.close()
        return (size/1024/1024) # in MB's
    
    def getFileName(self, fileName):
        if fileName.find("\\"):
            arr = fileName.split("\\")
        else:
            return fileName
        return arr[-1]

    def pBar(self, i):
        time.sleep(0.1)
        sys.stdout.write(('='*i)+(''*(100-i))+("\r [ %d"%i+"% ] "))
        sys.stdout.flush()

if __name__=="__main__":
    Client()    

    # 10.127.113.5 ip
    # "vid.mp4" file
