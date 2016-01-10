local monstersTable=nil
local interval=0
num=0
local flag=0
which=0
local wavesArr=0
local pathPoints=0
local parent=0

function createMonGroup( dt )
	-- body
	if #monstersTable==0 then
		waveNum=wavesArr:objectAtIndex(num)
		tolua.cast(waveNum,"CCArray")
	end
	interval=interval+dt
	if interval>1 and which<waveNum:count() then
		--todo
		local str=waveNum:objectAtIndex(which)
		tolua.cast(str, "CCString")
		local monster= Monster:create(str:getCString())
		table.insert(monster.monstersTable,monster)
		parent:addChild(monster)
		which=which+1
		interval=0
	end
	if #monstersTable~=0 then
		--todo
		for i,v in ipairs(monstersTable) do
			v:move( pathPoints )
			if v.beginPoint:equals(pathPoints[#pathPoints]) then
				v:removeFromParentAndCleanup(true)
				table.remove(monstersTable, i)
				if #monstersTable==0  then
					--todo
					num=num+1
					which=0
				end
			end
		end
	end
end
function getOutData( waves,pathTable,Parent,monTable )
	-- body
	wavesArr=waves
	pathPoints=pathTable
	parent=Parent
	monstersTable=monTable
end
