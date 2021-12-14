ESX = nil

TriggerEvent('esx:getSharedObject', function(object)
	ESX = object
end)

TriggerEvent('esx:getSharedObject', function(ESX)
	ESX.RegisterServerCallback('esx_sommen_motel:execute', function(source, callback, query, params)
		MySQL.Async.execute(tostring(query), params, function(result)
			callback(result)
		end)
	end)

	ESX.RegisterServerCallback('esx_sommen_motel:fetchAll', function(source, callback, query, params)
		MySQL.Async.fetchAll(tostring(query), params, function(result)
			callback(result)
		end)
	end)

	ESX.RegisterServerCallback('esx_sommen_motel:fetchScalar', function(source, callback, query, params)
		MySQL.Async.fetchScalar(tostring(query), params, function(result)
			callback(result)
		end)
	end)

	ESX.RegisterServerCallback('esx_sommen_motel:insert', function(source, callback, query, params)
		MySQL.Async.insert(tostring(query), params, function(result)
			callback(result)
		end)
	end)

	ESX.RegisterServerCallback('esx_sommen_motel:sync:execute', function(source, callback, query, params)
		callback(MySQL.Sync.execute(tostring(query), params))
	end)

	ESX.RegisterServerCallback('esx_sommen_motel:sync:fetchAll', function(source, callback, query, params)
		callback(MySQL.Sync.fetchAll(tostring(query), params))
	end)

	ESX.RegisterServerCallback('esx_sommen_motel:sync:fetchScalar', function(source, callback, query, params)
		callback(MySQL.Sync.fetchScalar(tostring(query), params))
	end)

	ESX.RegisterServerCallback('esx_sommen_motel:sync:insert', function(source, callback, query, params)
		callback(MySQL.Sync.insert(tostring(query), params))
	end)
end)
