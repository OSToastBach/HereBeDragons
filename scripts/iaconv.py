#ia text converter, exports to asm6809 fcb

import os

from PIL import Image

open("gfxout.txt", "w").close()
f=open('gfxout.txt','a')

dirpath = "../gfx/chars/"

files=[]

#sort thru files
for path in os.listdir(dirpath):
    if os.path.isfile(os.path.join(dirpath, path)):
        files.append(path)

fileslen=len(files)
#print(files)

#files in alphabetical order
chars = ['a', 'apostrophe', 'b', 'c', 'comma', 'd', 'dash', 'e', 'eight', 'exclamation', 'f', 'five', 'four', 'fullstop', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'nine', 'o', 'one', 'p', 'q', 'question', 'r', 's', 'seven', 'six', 'space', 't', 'three', 'two', 'u', 'v', 'w', 'x', 'y', 'z', 'zero', 'circumflex']


#check if needs different colours depending on y value
def checkbase(base):
    if y >=0 and y<=2:
        base+=48            #red
    elif y >=3 and y<=6:
        base+=112           #orange
    elif y >=7 and y<=10:
        base+=16            #yellow
    elif y >=11 and y<=14:
        base +=64           #white
    return str(base)

#for every file
for i in range(0,fileslen):

    im=Image.open('../gfx/chars/'+files[i],'r')
    rgb_im=im.convert('RGB')

    f.write('char_'+chars[i])
    f.write('\n\t\tfcb ')

    #16x16 res
    for x in range(0,15,2):
        for y in range(0,15,2):

            r,g1,b=rgb_im.getpixel((x,y))
            r,g2,b=rgb_im.getpixel((x+1,y))
            r,g3,b=rgb_im.getpixel((x,y+1))
            r,g4,b=rgb_im.getpixel((x+1,y+1))

            #ah yes, big table of else-if's
            #could've done it a better way using bitwise stuff
            #but i cba, if it works it works ;)

            if g1==0 and g2==0 and g3==0 and g4 == 0:
                f.write('128,')
            elif g1==0 and g2==0 and g3==0 and g4==255:
                base=129
                n_base=checkbase(base)
                f.write(n_base+',')
            elif g1==0 and g2==0 and g4==0 and g3==255:
                base=130
                n_base=checkbase(base)
                f.write(n_base+',')
            elif g1==0 and g2==0 and g3==255 and g4==255:
                base=131
                n_base=checkbase(base)
                f.write(n_base+',')
            elif g1==0 and g3==0 and g4==0 and g2==255:
                base=132
                n_base=checkbase(base)
                f.write(n_base+',')
            elif g1==0 and g3==0 and g2==255 and g4==255:
                base=133
                n_base=checkbase(base)
                f.write(n_base+',')
            elif g2==255 and g3==255 and g1==0 and g4==0:
                base=134
                n_base=checkbase(base)
                f.write(n_base+',')
            elif g2==255 and g3==255 and g3==255 and g1==0:
                base=135
                n_base=checkbase(base)
                f.write(n_base+',')
            elif g1==255 and g2==0 and g3==0 and g4==0:
                base=136
                n_base=checkbase(base)
                f.write(n_base+',')
            elif g1==255 and g4==255 and g2==0 and g3==0:
                base=137
                n_base=checkbase(base)
                f.write(n_base+',')
            elif g1==255 and g3==255 and g2==0 and g4==0:
                base=138
                n_base=checkbase(base)
                f.write(n_base+',')
            elif g1==255 and g3==255 and g4==255 and g2==0:
                base=139
                n_base=checkbase(base)
                f.write(n_base+',')
            elif g1==255 and g2==255 and g3==0 and g4==0:
                base=140
                n_base=checkbase(base)
                f.write(n_base+',')
            elif g1==255 and g2==255 and g4==255 and g3==0:
                base=141
                n_base=checkbase(base)
                f.write(n_base+',')
            elif g1==255 and g2==255 and g3==255 and g4==0:
                base=142
                n_base=checkbase(base)
                f.write(n_base+',')
            elif g1==255 and g2==255 and g3==255 and g4==255:
                base=143
                n_base=checkbase(base)
                f.write(n_base+',')

    #end column padding
    f.write('128,128,128,128,128,128,128,128\n')