#sg converter
from PIL import Image

im=Image.open('../sideb/gfx/dragon_raccoon2.png','r')
rgb_im=im.convert('RGB')

for y in range(96):
    for x in range(32):
        r,g,b=rgb_im.getpixel((x,y))

        if r==0 and g==0 and b==0:          #black
            print('128', end=',')
        elif r==0 and g==255 and b==0:      #green
            print('143', end=',')
        elif r==255 and g==255 and b==68:   #yellow
            print('159', end=',')
        elif r==34 and g==17 and b==187:    #blue
            print('175', end=',')
        elif r==187 and g==0 and b==34:     #red
            print('191', end=',')
        elif r==255 and g==255 and b==255:  #white
            print('207', end=',')
        elif r==0 and g==221 and b==119:    #other green
            print('223', end=',')
        elif r==255 and g==17 and b==255:   #pink
            print('239', end=',')
        elif r==255 and g==68 and b==0:     #orange
            print('255', end=',')
        elif r==102 and g==0 and b==0:
            print('32', end=',')
        elif r==255 and g==187 and b==68:
            print('96', end=',')