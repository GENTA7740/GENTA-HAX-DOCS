function ChoosedItem(itm)
console("Name: "..GetItemByID(itm).Name)
console("Type: "..GetItemByID(itm).ItemType)
console("File Name: "..GetItemByID(itm).FileName)
console("Rarity: "..GetItemByID(itm).Rarity)
console("Growth: "..GetItemByID(itm).Growth)
console("VisualStyle: "..GetItemByID(itm).VisualStyle)
end

addHook(ChoosedItem,"OnChooseItem")
