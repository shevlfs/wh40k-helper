import mongoengine as me
from mongoengine import Document, StringField, IntField, ListField
me.connect(host="mongodb+srv://admin:ff7777@lycwine2.57swz.mongodb.net/warhammer")
class Unit(Document):
    id = IntField()
    name = StringField()
    cost = IntField()
    mr = StringField()
    ws = IntField()
    bs = IntField()
    sth = IntField()
    tcs = IntField()
    wpn = IntField()
    agility = IntField()
    ldship = IntField()
a = Unit()
unitObjects = Unit.objects
units = {k.id: k for k in unitObjects}
units[0] = Unit()
units[0].name = "test"
units[0].save()

import cv2
import pytesseract

img = cv2.imread('image.jpg')

h, w, c = img.shape
boxes = pytesseract.image_to_boxes(img)
for b in boxes.splitlines():
    b = b.split(' ')
    img = cv2.rectangle(img, (int(b[1]), h - int(b[2])), (int(b[3]), h - int(b[4])), (0, 255, 0), 2)

cv2.imshow('img', img)
cv2.waitKey(0)
img = cv2.imread('image.jpg')

# Adding custom options
custom_config = r'--oem 3 --psm 6'
pytesseract.image_to_string(img, config=custom_config)