pkt = {}
pkt.type = 3
pkt.posX = GetLocal().posX
pkt.posY = GetLocal().posY
pkt.px = math.floor(GetLocal().posX / 32) + 1
pkt.py = math.floor(GetLocal().posY / 32)
pkt.value = 18

SendPacketRaw(false, pkt)
