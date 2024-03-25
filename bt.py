from TikTokLive import TikTokLiveClient
from TikTokLive.types.events import GiftEvent,LikeEvent,CommentEvent,FollowEvent,ShareEvent
import sqlite3
try:
    miconexion=sqlite3.connect("prueba.db")

    micursor=miconexion.cursor()

    micursor.execute("""
         Create table if not exists prueba(
                 Rosas INTEGER
                 
                 )

""")
except sqlite3.OperationalError:
    print("Error al crear database")
    
client = TikTokLiveClient("@ht123_online")

@client.on("gift")
async def on_gift(event: GiftEvent):
    if event.gift.streakable and not event.gift.streaking:
        #print(f"combo de {event.gift.count}")
        print(f"{event.user.unique_id} sent {event.gift.count}x \"{event.gift.info.name}\"")
        if event.gift.info.name=="Rose":
            print("Se mandó una rosa")
            #nombre=event.gift.info.name
            añadirdatos=[("R")]

            micursor.executemany("INSERT INTO prueba VALUES (?)",añadirdatos)

            miconexion.commit()
            #miconexion.close()
        
    # Non-streakable gift
    elif not event.gift.streakable:
        print("Espacial: ")
        print(f"{event.user.unique_id} sent \"{event.gift.info.name}\"")
        print("")
        
    
@client.on("like")
async def on_like(event: LikeEvent):
    #print(f"@{event.user.unique_id} liked the stream!")
    #print(f"{event.total_likes}")
    if event.likes<=3:
        añadirdatos=[("L")]
        micursor.executemany("INSERT INTO prueba VALUES (?)",añadirdatos)
        miconexion.commit()

    #if event.total_likes%10==0:
    else:
        añadirdatos=[("L")]
        micursor.executemany("INSERT INTO prueba VALUES (?)",añadirdatos)
        miconexion.commit()
    
@client.on("follow")
async def on_follow(event: FollowEvent):
    print(f"@{event.user.unique_id} followed the streamer!")
    añadirdatos=[("F")]
    micursor.executemany("INSERT INTO prueba VALUES (?)",añadirdatos)
    miconexion.commit()

@client.on("share")
async def on_share(event: ShareEvent):
    print(f"@{event.user.unique_id} shared the stream!")
    añadirdatos=[("S")]
    micursor.executemany("INSERT INTO prueba VALUES (?)",añadirdatos)
    miconexion.commit()

def test():
    aña=input("que deseaa agregar:")
    if aña=="L":
        añadirdatos=[("L")]
        micursor.executemany("INSERT INTO prueba VALUES (?)",añadirdatos)
        miconexion.commit()
    if aña=="l":
        añadirdatos=[("l")]
        micursor.executemany("INSERT INTO prueba VALUES (?)",añadirdatos)
        miconexion.commit()
    if aña=="S":
        añadirdatos=[("S")]
        micursor.executemany("INSERT INTO prueba VALUES (?)",añadirdatos)
        miconexion.commit()
    if aña=="R":
        añadirdatos=[("R")]
        micursor.executemany("INSERT INTO prueba VALUES (?)",añadirdatos)
        miconexion.commit()
    if aña=="F":
        añadirdatos=[("F")]
        micursor.executemany("INSERT INTO prueba VALUES (?)",añadirdatos)
        miconexion.commit()

if __name__ == '__main__':
    # Run the client and block the main thread
    # await client.start() to run non-blocking
    #for i in range(10):
    #  test()
    client.run()

