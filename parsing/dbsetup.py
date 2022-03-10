import mongoengine as me
from mongoengine import Document, StringField, IntField, ListField
me.connect(host="mongodb+srv://admin:ff7777@lycwine2.57swz.mongodb.net/warhammer")
class Unit(Document):
    unit_id = IntField()
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
units = {k.unit_id: k for k in unitObjects}
units[0] = Unit()
units[0].name = "test"
units[0].save()
