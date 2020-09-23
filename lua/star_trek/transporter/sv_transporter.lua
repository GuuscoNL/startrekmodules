---------------------------------------
---------------------------------------
--        Star Trek Utilities        --
--                                   --
--            Created by             --
--       Jan 'Oninoni' Ziegler       --
--                                   --
-- This software can be used freely, --
--    but only distributed by me.    --
--                                   --
--    Copyright © 2020 Jan Ziegler   --
---------------------------------------
---------------------------------------

---------------------------------------
--        Transporter | Server       --
---------------------------------------

-- TODO: Check if transport in Progress at target location (No 2 Beams at the same pos at the same time.)
-- TODO: Buffer Decay

local setupBuffer = function()
    for _, ent in pairs(ents.GetAll()) do
        if string.StartWith(ent:GetName(), "beamBuffer") then
            Star_Trek.Transporter.Buffer = {
                Entities = {},
                Pos = ent:GetPos(),
            }

            return
        end
    end
end
hook.Add("InitPostEntity", "Star_Trek.Transporter.Setup", setupBuffer)
hook.Add("PostCleanupMap", "Star_Trek.Transporter.Setup", setupBuffer)

hook.Add("SetupPlayerVisibility", "Star_Trek.Transporter.PVS", function(ply, viewEntity)
    AddOriginToPVS(Star_Trek.Transporter.Buffer.Pos)
end)

function Star_Trek.Transporter:CleanUpSourcePatterns(patterns)
    if not istable(patterns) then return patterns end
    local invalidPatterns = {}

    for name, pattern in pairs(patterns) do
        if istable(pattern) then
            if table.Count(pattern.Entities) == 0 then
                table.insert(invalidPatterns, pattern)
            end
        end
    end

    for _, pattern in pairs(invalidPatterns) do
        table.RemoveByValue(patterns, pattern)
    end

    return patterns
end

function Star_Trek.Transporter:CleanUpTargetPatterns(patterns)
    if not istable(patterns) then return patterns end
    local invalidPatterns = {}

    for _, pattern in pairs(patterns) do
        if istable(pattern) then
            if patterns.SingleTarget and table.Count(pattern.Entities) > 0 then
                table.insert(invalidPatterns, pattern)
            end
        end
    end

    for _, pattern in pairs(invalidPatterns) do
        table.RemoveByValue(patterns, pattern)
    end

    return patterns
end

function Star_Trek.Transporter:ActivateTransporter(sourcePatterns, targetPatterns)
    local sourcePatterns = self:CleanUpSourcePatterns(sourcePatterns)
    local targetPatterns = self:CleanUpTargetPatterns(targetPatterns)

    local remainingEntities = {}
    if not istable(targetPatterns) then
        for _, sourcePattern in pairs(sourcePatterns) do
            if istable(sourcePattern) then
                for _, ent in pairs(sourcePattern.Entities) do
                    table.insert(remainingEntities, ent)
                end
            end
        end
    else
        if targetPatterns.SingleTarget then
            local i = 1

            for _, sourcePattern in pairs(sourcePatterns) do
                if istable(sourcePattern) then
                    for _, ent in pairs(sourcePattern.Entities) do
                        local targetPattern = targetPatterns[i]
                        if istable(targetPattern) then
                            self:BeamObject(ent, targetPattern.Pos, sourcePattern.Pad, targetPattern.Pad, false)

                            if sourcePattern.IsBuffer then
                                table.RemoveByValue(Star_Trek.Transporter.Buffer.Entities, ent)
                            end

                            i = i + 1
                        elseif isbool(targetPattern) then
                            continue
                        else
                            if not sourcePattern.IsBuffer then
                                table.insert(remainingEntities, ent)
                                ent.Pad = sourcePattern.Pad
                            end
                        end
                    end 
                end
            end
        else
            local i = 1
            local targetPatternCount = #targetPatterns

            for _, sourcePattern in pairs(sourcePatterns) do
                if istable(sourcePattern) then
                    for _, ent in pairs(sourcePattern.Entities) do
                        local targetPattern = targetPatterns[i%targetPatternCount]
                        if istable(targetPattern) then
                            local pos = targetPattern.Pos
                            pos = Star_Trek.Util:FindEmptyPosWithin(pos, pos - Vector(200, 200, 200), pos + Vector(200, 200, 200))
                            if pos then
                                self:BeamObject(ent, pos, sourcePattern.Pad, targetPattern.Pad, false)
                                
                                if sourcePattern.IsBuffer then
                                    table.RemoveByValue(Star_Trek.Transporter.Buffer.Entities, ent)
                                end
                            else
                                table.insert(remainingEntities, ent)
                                ent.Pad = sourcePattern.Pad
                            end
                            
                            i = i + 1
                        end
                    end
                end
            end
        end
    end

    for _, ent in pairs(remainingEntities) do
        table.insert(Star_Trek.Transporter.Buffer.Entities, ent)
        self:BeamObject(ent, Vector(), ent.Pad, nil, true)
    end
end