# import tkinter module
from tkinter import *
  
# import other necessery modules
import random
import time
import datetime
  
# creating root object
root = Tk()
  
# defining size of window
root.geometry("1200x6000")
  
# setting up the title of window
root.title("Message Encryption and Decryption")

photo = PhotoImage(file="5.png")

l1 = Label(root,image=photo)

l1.pack(fill = BOTH,expand = True)
  
Tops = Frame(l1, width = 1600, relief = SUNKEN)
Tops.pack(side = TOP)
  
f1 = Frame(l1, width = 800, height = 700, relief = SUNKEN)
f1.pack(pady = 100, padx = 50)

f2 = Frame(l1, width = 800, height = 300, relief = SUNKEN)
f2.pack(pady = 50, padx = 50)

lbl = Label(f2, font = ('helvetica', 25, 'bold'),
          text = "  CRYPTOGRAPHY  ",
                     fg = "blue", bd = 10, anchor='w')
                       
lbl.grid(row = 0, column = 0)
  
# ==============================================
#                  TIME
# ==============================================
localtime = time.asctime(time.localtime(time.time()))
  
lblInfo = Label(Tops, font = ('helvetica', 25, 'bold'),
          text = "Message Encode & Decode ",
                     fg = "Black", bd = 10, anchor='w')
                       
lblInfo.grid(row = 0, column = 0)
  
lblInfo = Label(Tops, font=('arial', 20, 'bold'),
             text = localtime, fg = "green",
                           bd = 10, anchor = 'w')
                          
lblInfo.grid(row = 1, column = 0)
  
rand = StringVar()
Msg = StringVar()
key = StringVar()
mode = StringVar()
Result = StringVar()
  
# exit function
def qExit():
    root.destroy()
  
# Function to reset the window
def Reset():
    rand.set("")
    Msg.set("")
    key.set("")
    mode.set("")
    Result.set("")
  
  
# reference
lblReference = Label(f1, font = ('arial', 16, 'bold'),
                text = "Name:", bd = 16, anchor = "w")
                  
lblReference.grid(row = 0, column = 0)
  
txtReference = Entry(f1, font = ('arial', 16, 'bold'),
               textvariable = rand, insertwidth = 4,
                        bg = "powder blue", justify = 'left')
                          
txtReference.grid(row = 0, column = 1)
  
# labels
lblMsg = Label(f1, font = ('arial', 16, 'bold'),
         text = "MESSAGE", anchor = "w")
           
lblMsg.grid(row = 1, column = 0)
  
txtMsg = Entry(f1, font = ('arial', 16, 'bold'),
         textvariable = Msg, insertwidth = 4,
                bg = "powder blue", justify = 'left')
                  
txtMsg.grid(row = 1, column = 1)
  
lblkey = Label(f1, font = ('arial', 16, 'bold'),
            text = "KEY", anchor = "w")
              
lblkey.grid(row = 2, column = 0)
  
txtkey = Entry(f1, font = ('arial', 16, 'bold'),
         textvariable = key, insertwidth = 4,
                bg = "powder blue", justify = 'left')
                  
txtkey.grid(row = 2, column = 1)
  
lblmode = Label(f1, font = ('arial', 16, 'bold'),
          text = "MODE(e for encrypt, d for decrypt)",
                                 anchor = "w")
                                  
lblmode.grid(row = 3, column = 0)
  
txtmode = Entry(f1, font = ('arial', 16, 'bold'),
          textvariable = mode, insertwidth = 4,
                  bg = "powder blue", justify = 'left')
                    
txtmode.grid(row = 3, column = 1)
  
lblService = Label(f1, font = ('arial', 16, 'bold'),
             text = "The Result-",  anchor = "w")
               
lblService.grid(row = 2, column = 2)
  
txtService = Entry(f1, font = ('arial', 16, 'bold'), 
             textvariable = Result, insertwidth = 4,
                       bg = "powder blue", justify = 'left')
                         
txtService.grid(row = 2, column = 3)
  
# Vigenère cipher
import base64
  
# Function to encode
def encode(key, clear):
    enc = []
      
    for i in range(len(clear)):
        key_c = key[i % len(key)]
        enc_c = chr((ord(clear[i]) +
                     ord(key_c)) % 256)
                       
        enc.append(enc_c)
          
    return base64.urlsafe_b64encode("".join(enc).encode()).decode()
  
# Function to decode
def decode(key, enc):
    dec = []
      
    enc = base64.urlsafe_b64decode(enc).decode()
    for i in range(len(enc)):
        key_c = key[i % len(key)]
        dec_c = chr((256 + ord(enc[i]) -
                           ord(key_c)) % 256)
                             
        dec.append(dec_c)
    return "".join(dec)
  
  
def Ref():
    print("Message= ", (Msg.get()))
  
    clear = Msg.get()
    k = key.get()
    m = mode.get()
  
    if (m == 'e'):
        Result.set(encode(k, clear))
    else:
        Result.set(decode(k, clear))
  
# Show message button
btnTotal = Button(f1, padx = 10, pady = 8,  fg = "black",
                        font = ('arial', 16, 'bold'), width = 10,
                       text = "Show Message", bg = "green",
                         command = Ref).grid(row = 9, column = 0)
  
# Reset button
btnReset = Button(f1, padx = 10, pady = 8, 
                  fg = "black", font = ('arial', 16, 'bold'),
                    width = 10, text = "Reset", bg = "gray",
                   command = Reset).grid(row = 9, column = 1)
  
# Exit button
btnExit = Button(f1, padx = 10, pady = 8,
                 fg = "black", font = ('arial', 16, 'bold'),
                      width = 10, text = "Exit", bg = "red",
                  command = qExit).grid(row = 9, column = 3)
  
# keeps window alive
root.mainloop()