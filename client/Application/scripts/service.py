import json
import math
import socket
from tkinter import Widget
import scripts.model as model
from scripts.__init__ import _instances, serverIp, BUFFER, VIDEO_EXT, VIDEOBUFFER, FORMAT, START_SENDING, transferringFilesFrames, IMAGE_EXT, DOC_EXT,MUSIC_EXT

def main():
    root = _instances['root']
    _listFiles = model.names
    ind = 0
    t = _listFiles.__len__()
    for _file, path in _listFiles.items():
        soc = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        soc.connect((serverIp["ip"], 5000))
        _fileName = path
        fileName = _file
        fileType = getFileType(filename=fileName)
        size = getFileSize(path=path)
        buffer = BUFFER
        if fileType == "video":
            buffer = VIDEOBUFFER
        dictionary = {
            "size":size,
            "type":fileType,
            "fileName":fileName
        }
        dictionary = json.dumps(dictionary)
        soc.send(f"{dictionary}".encode(FORMAT))
        while True:
            root.update()
            data = soc.recv(VIDEOBUFFER).decode(FORMAT)
            if data == START_SENDING:
                print("SENDING file...")
                file_ = open(_fileName, 'rb')
                if file_:
                    s = 0.0
                    _chunck = file_.read(buffer)
                    while _chunck:
                        s += len(_chunck)
                        f = transferringFilesFrames[_file]
                        soc.sendall(_chunck)
                        f.update(val=math.floor((s/1024/1024/size)*100))
                        _chunck = file_.read(buffer)
                else:
                    raise FileNotFoundError().strerror
                file_.close()
                break
        soc.close()
        ind+=1
        af = _instances["tablepanel"]
        af.af.update(val=(ind/t)*100)

def getFileType(filename):
    _ext = filename[-3:] if filename[-4] == '.' else filename[-4:]
    if IMAGE_EXT.__contains__(_ext):
        return "image"
    elif VIDEO_EXT.__contains__(_ext):
        return "video"
    elif DOC_EXT.__contains__(_ext):
        return "doc"
    elif MUSIC_EXT.__contians__(_ext):
        return "audio"

def getFileSize(path):
    file = open(path, 'rb')
    size = len(file.read())
    file.close()
    return (size/1024/1024) # in MB's