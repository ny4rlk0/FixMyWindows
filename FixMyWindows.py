import os,subprocess,ctypes,time
fname=str(os.path.basename(__file__))
print(fname)
if ".py" in fname.lower():
    os.system("pip install tk")
from tkinter import *
from tkinter.ttk import *
from tkinter import messagebox
import requests as rq
cred="https://github.com/ny4rlk0/FixMyWindows"
w=Tk();w.title('Windows Repair');w.configure(background='white');status='Waiting for user click.'
stat=Label (w, text=status ,background="white",font="none 12 bold");stat.place(rely=0, relx=0.3, x=0, y=0)
credit=Label (w, text=cred ,background="white",font="none 12 bold");credit.place(rely=0.8, relx=0.1, x=0, y=0)
w.geometry("400x200")

def isAdmin():
    try:
        is_admin = (os.getuid() == 0)
    except AttributeError:
        is_admin = ctypes.windll.shell32.IsUserAnAdmin() != 0
    return is_admin
def download(url,filename):
    try:
        r = rq.get(url, allow_redirects=True)
        open(filename, 'wb').write(r.content)
    except:
        pass
def Main():
    fixButton["state"] = "disabled"
    fixButton["text"] = "Repairing..."
    stat["text"] = "Downloading files."
    download("https://raw.githubusercontent.com/ny4rlk0/FixMyWindows/main/repairmywindows.bat","repairmywindows.bat")
    stat["text"] = "Initiating the repair."
    subprocess.Popen("repairmywindows.bat")
if isAdmin():
    pass
else:
    messagebox.showinfo("Opps","This tool requires to run as Administrator. Will exit now!")
    os.sys.exit(0)
#fixButton
fixButton=Button(w,text="Repair Windows OS",width=25,command=Main)
fixButton.place(rely=0.5, relx=0.5, x=0, y=0, anchor=S)
w.mainloop()
os.sys.exit(0)
