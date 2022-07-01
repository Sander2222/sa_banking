--made by Sander#2211

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--Sendet alle Daten zu Client
RegisterServerEvent('sa_banking:GetBalance')
AddEventHandler('sa_banking:GetBalance', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    balance = xPlayer.getAccount('bank').money
    name = xPlayer.getName()
    TriggerClientEvent('sa_banking:SendNUI', _source, balance, name, true)

end)

--Auszahlen
RegisterServerEvent('sa_banking:Withdraw')
AddEventHandler('sa_banking:Withdraw', function(amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local balance = xPlayer.getAccount('bank').money 
    local amount = tonumber(amount)

    if amount == nil or amount <= 0 then
      TriggerClientEvent('esx:showAdvancedNotification', _source, Language['Bank'], Language['Withdraw'], Language['NotValid'], Language['NotifyIcon'], 3)
    else 
        if amount <= balance then
            xPlayer.removeAccountMoney('bank', amount)
            xPlayer.addMoney(amount)
            TriggerClientEvent('esx:showAdvancedNotification', _source, Language['Bank'], Language['Withdraw'], Language['WithdrawMoney'] ..amount.. Language['money'], Language['NotifyIcon'], 3)
        else
          TriggerClientEvent('esx:showAdvancedNotification', _source, Language['Bank'], Language['Withdraw'], Language['NotEnoughMoney'], Language['NotifyIcon'], 3)
        end
    end
end)


--Einzahlen
RegisterServerEvent('sa_banking:Deposit')
AddEventHandler('sa_banking:Deposit', function(amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local amount = tonumber(amount)
    local HandMoney = xPlayer.getMoney()

    if amount == nil or amount <= 0 then
      TriggerClientEvent('esx:showAdvancedNotification', _source, Language['Bank'], Language['Deposit'], Language['NotValid'], Language['NotifyIcon'], 3)
    else
        if amount <= HandMoney then
            xPlayer.removeMoney(amount)
            xPlayer.addAccountMoney('bank', tonumber(amount))
                  TriggerClientEvent('esx:showAdvancedNotification', _source, Language['Bank'], Language['Deposit'], Language['DepositMoney'] ..amount.. Language['money'], Language['NotifyIcon'], 3)
        else
            TriggerClientEvent('bcs_radialmenu:showNotify',_source, 'Bank', 'Einzahlen', 'Du hast nicht genug ~r~Geld~w~ auf deinem Konto',  'CHAR_BANK_MAZE')
        end
    end
end)


--Übwerweisen
RegisterServerEvent('sa_banking:Transfer')
AddEventHandler('sa_banking:Transfer', function(amount, Target)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xTarget = ESX.GetPlayerFromId(Target)
    local xPlayerBank = xPlayer.getAccount('bank').money
    amount = tonumber(amount)

     if xTarget ~= nil and GetPlayerEndpoint(Target) ~= nil then
        --idk warum das funktioniert, aber es funktioniert
        if xPlayer == xTarget then
            if balance <= 0 or balance < amount or amount <= 0 then
                TriggerClientEvent('bcs_radialmenu:showNotify',_source, 'Bank', 'Übwerweisen', 'du hast nicht genug Geld auf deiner Bank',  'CHAR_BANK_MAZE')
            else 
                xPlayer.removeAccountMoney('bank', amount)
                xTarget.addAccountMoney('bank', amount)
                TriggerClientEvent('bcs_radialmenu:showNotify',_source, 'Bank', 'Übwerweisen', 'Du hast: ~g~' ..amount.. '~w~$ Geld an ' ..xTarget.getName().. 'gesendet',  'CHAR_BANK_MAZE')
                TriggerClientEvent('bcs_radialmenu:showNotify',Target, 'Bank', 'Übwerweisen', 'Du hast: ~g~' ..amount.. '~w~$ Geld von ' ..xPlayer.getName().. 'bekommen',  'CHAR_BANK_MAZE')
            end
        else 
            TriggerClientEvent('bcs_radialmenu:showNotify',Target, 'Bank', 'Übwerweisen', 'Du kannst dir selber kein Geld überweisen',  'CHAR_BANK_MAZE')
        end
     else
        TriggerClientEvent('bcs_radialmenu:showNotify',Target, 'Bank', 'Übwerweisen', 'Dieser Spieler existiert nicht',  'CHAR_BANK_MAZE')
     end
end)

