
local OBJ = RDV.DATAPAD.GetPlugin("AI Commands")

if !OBJ then return end

local COL_1 = Color(255,255,255)

function OBJ:DoClick(ply, frame, PAGE)
    PAGE.PaintOver = function() end

    local w, h = PAGE:GetSize()
    local SCROLL = vgui.Create("DScrollPanel", PAGE)
    SCROLL:GetVBar():SetWide(0)
    SCROLL:Dock(FILL)
    SCROLL:DockMargin(w * 0.01, h * 0.01, w * 0.01, h * 0.01)
    SCROLL.Think = function(self)
        for k, v in pairs(rpcc.config.Commands) do
            local commandObj = v
            

            
            if commandObj.map and not commandObj.map[game.GetMap()] then continue end

            if not rpcc.config.bypassRank[ply:GetUserGroup()] and (DarkRP and not rpcc.config.bypassCatergory[ply:getJobTable().category]) then 
                if DarkRP then
                    if commandObj.allowedCatergory and not commandObj.allowedCatergory[ply:getJobTable().category] then
                        continue
                    end
                    if commandObj.allowedJob and not commandObj.allowedJob[ply:getJobTable().name] then 
                        continue
                    end
                end

                if commandObj.allowedRank and not commandObj.allowedRank[ply:GetUserGroup()] then 
                    continue
                end
            end

            if hide == true then continue end


            local LABEL = self:Add("DButton")
            LABEL:Dock(TOP)
            LABEL:SetText("")
            LABEL:SetHeight(h * 0.1)
            LABEL:SetFont("RD_FONTS_CORE_LABEL_LOWER")
            LABEL:DockMargin(w * 0.01, h * 0.01, w * 0.01, h * 0.01)
            LABEL.Paint = function(self, w, h)
                surface.SetDrawColor(PIXEL.CopyColor(PIXEL.Colors.Header))
                surface.DrawRect(0, 0, w, h)
                local name = commandObj.name or k
                draw.SimpleText(name, "RD_FONTS_CORE_LABEL_LOWER", w * 0.05, h * 0.5, COL_1, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            end

            local BUT = vgui.Create("PIXEL.TextButton", LABEL)
            BUT:Dock(RIGHT)
            BUT:SetText("Activate")
            BUT.DoClick = function()
                net.Start("roplaycommands.send")
                    net.WriteString(k)
                net.SendToServer()
            end
        end

        self.Think = nil
    end
end

