for _, inv in pairs(GetInventory())do
console("ID:"..inv.id.." Amount:"..inv.amount.." Name:"..GetNameOfItem(inv.id))
end
