require "interpolations"
require "misc"

local uivi = {}
uivi.defaultFont = love.graphics.newFont("Quicksand-Bold.ttf", 16)

function uivi.newLabel(x, y, text, visible)
    local label = {}
    label.x = x
    label.y = y
    label.realX = x
    label.realY = y
    label.alignment = "top-left"
    label.color = {}
    label.color.r = 255
    label.color.g = 255
    label.color.b = 255
    label.color.a = 255
    label.visible = visible
    label.text = text
    label.width = uivi.defaultFont:getWidth(label.text)
    label.height = uivi.defaultFont:getHeight()
    label.textCentered = false

    function label:draw()
        if label.visible == true then

            --set alignment
            if label.alignment == "top-left" then
                label.realX = label.x
                label.realY = label.y
            end
            if label.alignment == "center-left" then
                label.realX = label.x
                label.realY = love.graphics.getHeight() / 2 + label.y
            end
            if label.alignment == "bottom-left" then
                label.realX = label.x
                label.realY = love.graphics.getHeight() + label.y
            end
            if label.alignment == "top-center" then
                label.realX = love.graphics.getWidth() / 2 + label.x
                label.realY = label.y
            end
            if label.alignment == "center" then
                label.realX = love.graphics.getWidth() / 2 + label.x
                label.realY = love.graphics.getHeight() / 2 + label.y
            end
            if label.alignment == "bottom-center" then
                label.realX = love.graphics.getWidth() / 2 + label.x
                label.realY = love.graphics.getHeight() + label.y
            end
            if label.alignment == "top-right" then
                label.realX = love.graphics.getWidth() + label.x
                label.realY = label.y
            end
            if label.alignment == "center-right" then
                label.realX = love.graphics.getWidth() + label.x
                label.realY = love.graphics.getHeight() / 2 + label.y
            end
            if label.alignment == "bottom-right" then
                label.realX = love.graphics.getWidth() + label.x
                label.realY = love.graphics.getHeight() + label.y
            end

            if label.textCentered == true then
                love.graphics.print(label.text, label.realX-label.width / 2, label.realY)
            else
                love.graphics.print(label.text, label.realX, label.realY)
            end
        end
    end

    function label:setAlignment(alignment)
        label.alignment = alignment
    end

    function label:setVisible(visible)
        label.visible = visible
    end

    return label
end

function uivi.newPanel(x, y, width, height, visible)
    local panel = {}
    panel.x = x
    panel.y = y
    panel.realX = x
    panel.realY = y
    panel.alignment = "top-left"
    panel.width = width
    panel.height = height
    panel.color = {}
    panel.color.r = 40
    panel.color.g = 40
    panel.color.b = 40
    panel.color.a = 255
    panel.contourSize = 2
    panel.accent = {}
    panel.accent.r = 255
    panel.accent.g = 255
    panel.accent.b = 255
    panel.accent.a = 255
    panel.visible = visible
    panel.onClick = function()
        -- print("printing from panel")
    end
    panel.onClickOutside = function()

    end

    function panel:isClicked(x, y, mousePress)
        
        local result = false
        if x >= panel.realX and x <= panel.realX + panel.width and y >= panel.realY and y <= panel.realY + panel.height then
            if mousePress == true then
                result = true
                --print("wot")
            end
        end

        if panel.visible == false then
            result = false
        end

        if panel.pressed == true and result == false then
            
        
            -- button:onReleased()
        end

        panel.pressed = result
        return result
    end

    function panel:draw()
        if panel.visible == true then

            --set alignment
            if panel.alignment == "top-left" then
                panel.realX = panel.x
                panel.realY = panel.y
            end
            if panel.alignment == "center-left" then
                panel.realX = panel.x
                panel.realY = love.graphics.getHeight() / 2 + panel.y
            end
            if panel.alignment == "bottom-left" then
                panel.realX = panel.x
                panel.realY = love.graphics.getHeight() + panel.y
            end
            if panel.alignment == "top-center" then
                panel.realX = love.graphics.getWidth() / 2 + panel.x
                panel.realY = panel.y
            end
            if panel.alignment == "center" then
                panel.realX = love.graphics.getWidth() / 2 + panel.x
                panel.realY = love.graphics.getHeight() / 2 + panel.y
            end
            if panel.alignment == "bottom-center" then
                panel.realX = love.graphics.getWidth() / 2 + panel.x
                panel.realY = love.graphics.getHeight() + panel.y
            end
            if panel.alignment == "top-right" then
                panel.realX = love.graphics.getWidth() + panel.x
                panel.realY = panel.y
            end
            if panel.alignment == "center-right" then
                panel.realX = love.graphics.getWidth() + panel.x
                panel.realY = love.graphics.getHeight() / 2 + panel.y
            end
            if panel.alignment == "bottom-right" then
                panel.realX = love.graphics.getWidth() + panel.x
                panel.realY = love.graphics.getHeight() + panel.y
            end

            --draw contour
            love.graphics.setColor(panel.accent.r / 255, panel.accent.g / 255, panel.accent.b / 255, panel.accent.a / 255)
            --love.graphics.rectangle("fill", panel.realX + 12, panel.realY, panel.width - 24, panel.height)
            love.graphics.rectangle("fill", panel.realX + 12, panel.realY, panel.width - 24, panel.height)
            

            --left side curvature
            love.graphics.circle("fill", panel.realX + 12, panel.realY + 12, 12)
            love.graphics.circle("fill", panel.realX + 12, panel.realY - 12 + panel.height, 12)
            love.graphics.rectangle("fill", panel.realX, panel.realY + 12, 24, panel.height - 24)

            --right side curvature
            love.graphics.circle("fill", panel.realX - 12 + panel.width, panel.realY + 12, 12)
            love.graphics.circle("fill", panel.realX - 12 + panel.width, panel.realY - 12 + panel.height, 12)
            love.graphics.rectangle("fill", panel.realX + panel.width - 24, panel.realY + 12, 24, panel.height - 24)


            
            --draw panel
            love.graphics.setColor(panel.color.r / 255, panel.color.g / 255, panel.color.b / 255, panel.color.a / 255)
            love.graphics.rectangle("fill", panel.realX + 12, panel.realY + panel.contourSize / 2, panel.width - 24, panel.height - panel.contourSize)
            

            --left side curvature
            love.graphics.circle("fill", panel.realX + 12 + panel.contourSize / 2, panel.realY + 12 +panel.contourSize / 2, 12)
            love.graphics.circle("fill", panel.realX + 12 + panel.contourSize / 2, panel.realY - 12 + panel.height - panel.contourSize / 2, 12)
            love.graphics.rectangle("fill", panel.realX + panel.contourSize / 2, panel.realY + 12 + panel.contourSize / 2, 24, panel.height - 24 - panel.contourSize)

            --right side curvature
            love.graphics.circle("fill", panel.realX - 12 + panel.width - panel.contourSize / 2, panel.realY + 12 + panel.contourSize / 2, 12)
            love.graphics.circle("fill", panel.realX - 12 + panel.width - panel.contourSize / 2, panel.realY - 12 + panel.height - panel.contourSize / 2, 12)
            love.graphics.rectangle("fill", panel.realX + panel.width - 24 - panel.contourSize / 2, panel.realY + 12 + panel.contourSize / 2, 24, panel.height - 24 - panel.contourSize)

            love.graphics.setColor(1,1,1,1)
        end
    end

    function panel:setVisible(toggle)
        panel.visible = toggle
    end

    function panel:isVisible()
        return panel.visible
    end

    function panel:setAlignment(alignment)
        panel.alignment = alignment
    end

    function panel:setColor(color)
        panel.color.r, panel.color.g, panel.color.b, panel.color.a = unpack(color)
    end

    return panel
end

function uivi.newRoundButton(x, y, radius, visible, text, hasEdge)
    local button = {}
    button.x = x
    button.y  = y
    button.realX = x
    button.realY = y
    button.radius = radius
    button.maxRadius = radius
    button.visible = visible
    button.color = {}
    button.color.r = 255
    button.color.g = 255
    button.color.b = 255
    button.color.a = 255
    button.pressed = false
    button.hasEdge = hasEdge
    button.text = text
    button.alignment = "bottom-left"

    local textWidth = uivi.defaultFont:getWidth(button.text)
    local textHeight = uivi.defaultFont:getHeight()

    button.onClick = function()
    end

    function button:draw()
        
        if button.alignment == "top-left" then
            button.realX = button.x
            button.realY = button.y
        end
        if button.alignment == "center-left" then
            button.realX = button.x
            button.realY = love.graphics.getHeight() / 2 + button.y
        end
        if button.alignment == "bottom-left" then
            button.realX = button.x
            button.realY = love.graphics.getHeight() + button.y
        end
        if button.alignment == "top-center" then
            button.realX = love.graphics.getWidth() / 2 + button.x
            button.realY = button.y
        end
        if button.alignment == "center" then
            button.realX = love.graphics.getWidth() / 2 + button.x
            button.realY = love.graphics.getHeight() / 2 + button.y
        end
        if button.alignment == "bottom-center" then
            button.realX = love.graphics.getWidth() / 2 + button.x
            button.realY = love.graphics.getHeight() + button.y
        end
        if button.alignment == "top-right" then
            button.realX = love.graphics.getWidth() + button.x
            button.realY = button.y
        end
        if button.alignment == "center-right" then
            button.realX = love.graphics.getWidth() + button.x
            button.realY = love.graphics.getHeight() / 2 + button.y
        end
        if button.alignment == "bottom-right" then
            button.realX = love.graphics.getWidth() + button.x
            button.realY = love.graphics.getHeight() + button.y
        end

        if button.hasEdge then
            love.graphics.setColor(1,1,1,1)
            love.graphics.circle("fill", button.realX, button.realY, button.radius+4)
        end

        if button.pressed == false then
            button.radius = lerp(button.radius, button.maxRadius, .16)
        else
            button.radius = lerp(button.radius, button.maxRadius - 8, .16)
        end

        love.graphics.circle("fill", button.realX, button.realY, button.radius)
        love.graphics.setColor(0,0,0,1)
        --love.graphics.setColor(1,1,1,1)
        love.graphics.printf(text, button.realX - textWidth / 2, button.realY - textHeight / 2, textWidth, 'center')
        love.graphics.setColor(1,1,1,1)
    end

    function button:isClicked(x, y, mousePress)
        
        local result = false
        if (button.realX - x) *(button.realX - x) + (button.realY - y) * (button.realY - y) <= button.radius * button.radius then
            if mousePress == true then
                result = true
            end
        end

        if button.visible == false then
            result = false
        end

        button.pressed = result
        return result
    end

    function button:setAlignment(alignment)
        button.alignment = alignment
    end

    function button:setColor(color)
        button.color.r, button.color.g, button.color.b, button.color.a = unpack(color)
    end

    return button
end

function uivi.newExpandingRoundButton(x, y, radius, expandedRadius, visible, text)
    local button = {}
    button.x = x
    button.y  = y
    button.realX = x
    button.realY = y
    button.radius = radius
    button.maxRadius = radius
    button.expandedRadius = expandedRadius
    button.visible = visible
    button.color = {}
    button.color.r = 255
    button.color.g = 255
    button.color.b = 255
    button.color.a = 255
    button.pressed = false
    button.hasEdge = hasEdge
    button.text = text
    button.expanded = false
    button.alignment = "top-left"

    local textWidth = uivi.defaultFont:getWidth(button.text)
    local textHeight = uivi.defaultFont:getHeight()

    button.onClick = function()
    end

    function button:draw()
        
        if button.alignment == "top-left" then
            button.realX = button.x
            button.realY = button.y
        end
        if button.alignment == "center-left" then
            button.realX = button.x
            button.realY = love.graphics.getHeight() / 2 + button.y
        end
        if button.alignment == "bottom-left" then
            button.realX = button.x
            button.realY = love.graphics.getHeight() + button.y
        end
        if button.alignment == "top-center" then
            button.realX = love.graphics.getWidth() / 2 + button.x
            button.realY = button.y
        end
        if button.alignment == "center" then
            button.realX = love.graphics.getWidth() / 2 + button.x
            button.realY = love.graphics.getHeight() / 2 + button.y
        end
        if button.alignment == "bottom-center" then
            button.realX = love.graphics.getWidth() / 2 + button.x
            button.realY = love.graphics.getHeight() + button.y
        end
        if button.alignment == "top-right" then
            button.realX = love.graphics.getWidth() + button.x
            button.realY = button.y
        end
        if button.alignment == "center-right" then
            button.realX = love.graphics.getWidth() + button.x
            button.realY = love.graphics.getHeight() / 2 + button.y
        end
        if button.alignment == "bottom-right" then
            button.realX = love.graphics.getWidth() + button.x
            button.realY = love.graphics.getHeight() + button.y
        end

        love.graphics.setColor(1,1,1,1)
        love.graphics.circle("fill", button.realX, button.realY, button.radius+4)
        love.graphics.setColor(button.color.r/255, button.color.g/255, button.color.b/255, button.color.a/255)
        love.graphics.circle("fill", button.realX, button.realY, button.radius)

        if button.pressed == false and button.expanded == false then
            button.radius = lerp(button.radius, button.maxRadius, .16)
        elseif button.pressed == true and button.expanded == false then
            button.radius = lerp(button.radius, button.maxRadius - 16, .16)
        elseif button.pressed == false and button.expanded == true then
            button.radius = lerp(button.radius, button.expandedRadius, .16)
        end

        love.graphics.setColor(0,0,0,1)
        --love.graphics.setColor(1,1,1,1)
        love.graphics.printf(text, button.realX - textWidth / 2, button.realY - textHeight / 2, textWidth, 'center')
        love.graphics.setColor(1,1,1,1)
    end

    function button:isClicked(x, y, mousePress)
        
        local result = false
        if button.expanded == false then
            if (button.realX - x) *(button.realX - x) + (button.realY - y) * (button.realY - y) <= button.maxRadius * button.maxRadius then
                if mousePress == true then
                    result = true
                end
            end
        else
            if (button.realX - x) * (button.realX - x) + (button.realY - y) * (button.realY - y) <= button.expandedRadius * button.expandedRadius then
                if mousePress == true then
                    result = true
                end
                
            else
                result = false
                button.expanded = false
            end
        end

        if button.visible == false then
            result = false
        end

        if button.pressed == true and result == false then
            if button.expanded == false then
                button.expanded = true
            end
            button:onReleased()
        end

        button.pressed = result
        return result
    end

    function button:onReleased()
        
    end

    function button:setAlignment(alignment)
        button.alignment = alignment
    end

    function button:setColor(color)
        button.color.r, button.color.g, button.color.b, button.color.a = unpack(color)
    end

    return button
end

function uivi.newColorPicker(x, y, radius, expandedRadius, visible, text)
    local button = {}
    button.x = x
    button.y  = y
    button.realX = x
    button.realY = y
    button.radius = radius
    button.maxRadius = radius
    button.expandedRadius = expandedRadius
    button.visible = visible
    button.color = {}
    button.color.r = 255
    button.color.g = 255
    button.color.b = 255
    button.color.a = 255
    button.pressed = false
    button.hasEdge = hasEdge
    button.text = text
    button.expanded = false
    button.alignment = "top-right"
    button.returnedColor = {}
    button.returnedColor.r = 255
    button.returnedColor.g = 255
    button.returnedColor.b = 255
    button.returnedColor.a = 255
    button.holdingOnPicker = false

    local textWidth = uivi.defaultFont:getWidth(button.text)
    local textHeight = uivi.defaultFont:getHeight()

    button.onClick = function()
    end

    function button:draw()
        
        if button.alignment == "top-left" then
            button.realX = button.x
            button.realY = button.y
        end
        if button.alignment == "center-left" then
            button.realX = button.x
            button.realY = love.graphics.getHeight() / 2 + button.y
        end
        if button.alignment == "bottom-left" then
            button.realX = button.x
            button.realY = love.graphics.getHeight() + button.y
        end
        if button.alignment == "top-center" then
            button.realX = love.graphics.getWidth() / 2 + button.x
            button.realY = button.y
        end
        if button.alignment == "center" then
            button.realX = love.graphics.getWidth() / 2 + button.x
            button.realY = love.graphics.getHeight() / 2 + button.y
        end
        if button.alignment == "bottom-center" then
            button.realX = love.graphics.getWidth() / 2 + button.x
            button.realY = love.graphics.getHeight() + button.y
        end
        if button.alignment == "top-right" then
            button.realX = love.graphics.getWidth() + button.x
            button.realY = button.y
        end
        if button.alignment == "center-right" then
            button.realX = love.graphics.getWidth() + button.x
            button.realY = love.graphics.getHeight() / 2 + button.y
        end
        if button.alignment == "bottom-right" then
            button.realX = love.graphics.getWidth() + button.x
            button.realY = love.graphics.getHeight() + button.y
        end

        

        if button.pressed == false and button.expanded == false then
            button.radius = lerp(button.radius, button.maxRadius, .16)
        elseif button.pressed == true and button.expanded == false then
            button.radius = lerp(button.radius, button.maxRadius - 16, .16)
        elseif button.pressed == false and button.expanded == true then
            button.radius = lerp(button.radius, button.expandedRadius, .16)
        end

        --print(button.holdingOnPicker and "true" or "false")

        if button.holdingOnPicker == true then
            local dist = math.sqrt( (button.realX - love.mouse.getX()) * (button.realX - love.mouse.getX()) + (button.realY - love.mouse.getY()) * (button.realY - love.mouse.getY()))
            local angle = math.deg( math.atan2(button.realY - love.mouse.getY(), button.realX - love.mouse.getX()) ) + 360
            if angle > 360 then
                angle = angle - 360
            end
            button.returnedColor.r, button.returnedColor.g, button.returnedColor.b, button.returnedColor.a = unpack(hsv2rgb({angle ,dist/button.radius,1,1}))
            print("r:" .. button.returnedColor.r * 255 .."  g:" .. button.returnedColor.g * 255 .. "  b:" .. button.returnedColor.b * 255 .. "  angle:" .. angle)
        end
        
        local alpha = (button.radius - button.maxRadius) / (button.radius - button.expandedRadius)
        alpha = alpha * -1
        
        love.graphics.setColor(1,1,1,alpha)
        love.graphics.circle("fill", button.realX, button.realY, button.radius+12)
        
        
        love.graphics.setColor(button.color.r / 255, button.color.g / 255, button.color.b / 255, alpha)
        love.graphics.circle("fill", button.realX, button.realY, button.radius+8)
        love.graphics.setColor(1,1,1,1)
        --love.graphics.circle("fill", button.realX, button.realY, button.radius+4)
        
        love.graphics.setColor(1,1,1,1)
        love.graphics.circle("fill", button.realX, button.realY, button.radius+4)

        for x = -button.radius, button.radius, 1 do
            for y = -button.radius, button.radius, 1 do
                if math.sqrt( x * x + y * y ) <= button.radius then
                    local angle = math.deg( math.atan2(y, x) )

                    color = {}
                    color.r, color.g, color.b, color.a = hsv2rgb({angle+180,math.sqrt( x * x + y * y )/button.radius,1,1})

                    --local alpha = (button.radius - button.maxRadius) / (button.radius - button.expandedRadius)

                    love.graphics.setColor(color.r, color.g, color.b, 1)

                    love.graphics.points(x + button.realX, y + button.realY)
                    
                end
            end
        end

        
        local alpha = (button.radius - button.maxRadius) / (button.radius - button.expandedRadius)
        alpha = alpha * -1
        love.graphics.setColor(button.color.r / 255, button.color.g / 255, button.color.b / 255, 1-alpha)
        love.graphics.circle("fill", button.realX, button.realY, button.radius)
        love.graphics.setColor(1, 1, 1, 1)
    end

    function button:isClicked(x, y, mousePress)
        
        local result = false
        if button.expanded == false then
            if (button.realX - x) *(button.realX - x) + (button.realY - y) * (button.realY - y) <= button.maxRadius * button.maxRadius then
                if mousePress == true then
                    result = true
                    --print("wot")
                end
            end
        else
            if (button.realX - x) * (button.realX - x) + (button.realY - y) * (button.realY - y) <= button.expandedRadius * button.expandedRadius then
                if mousePress == true then
                    result = true
                    button.holdingOnPicker = true
                    --print("tow")
                end
                
            else
                result = false
                button.expanded = false
            end
        end

        if button.visible == false then
            result = false
        end

        if button.pressed == true and result == false then
            if button.expanded == false then
                button.expanded = true
            else
                button.expanded = false
                button.holdingOnPicker = false
            end
        
            button:onReleased()
        end

        button.pressed = result
        return result
    end

    function button:onReleased()
        button.holdingOnPicker = false
    end

    function button:setAlignment(alignment)
        button.alignment = alignment
    end

    function button:setColor(color)
        button.color.r = color.r
        button.color.g = color.g
        button.color.b = color.b
        button.color.a = color.a
    end

    return button
end

function uivi.newSquareButton(x, y, width, height, text, visible)
    local button = {}
    button.x = x
    button.y = y
    button.realX = x
    button.realY = y
    button.alignment = "top-left"
    button.width = width
    button.height = height
    button.text = text
    button.textOffsetX = 0
    button.textOffsetY = 0
    button.color = {}
    button.color.r = 40
    button.color.g = 40
    button.color.b = 40
    button.color.a = 255
    button.accentSize = 4
    button.shadowSize = 8
    button.accentColor = {}
    button.accentColor.r = 255
    button.accentColor.g = 255
    button.accentColor.b = 255
    button.accentColor.a = 255
    button.visible = visible
    button.pressed = false
    button.textWidth = uivi.defaultFont:getWidth(text)
    button.textHeight = uivi.defaultFont:getHeight()
    button.onClick = function()
    
    end

    button.onClickOutside = function()

    end

    button.onRelease = function()

    end

    function button:draw()
        if button.visible == true then

            --set alignment
            if button.alignment == "top-left" then
                button.realX = button.x
                button.realY = button.y
            end
            if button.alignment == "center-left" then
                button.realX = button.x
                button.realY = love.graphics.getHeight() / 2 + button.y
            end
            if button.alignment == "bottom-left" then
                button.realX = button.x
                button.realY = love.graphics.getHeight() + button.y
            end
            if button.alignment == "top-center" then
                button.realX = love.graphics.getWidth() / 2 + button.x
                button.realY = button.y
            end
            if button.alignment == "center" then
                button.realX = love.graphics.getWidth() / 2 + button.x
                button.realY = love.graphics.getHeight() / 2 + button.y
            end
            if button.alignment == "bottom-center" then
                button.realX = love.graphics.getWidth() / 2 + button.x
                button.realY = love.graphics.getHeight() + button.y
            end
            if button.alignment == "top-right" then
                button.realX = love.graphics.getWidth() + button.x
                button.realY = button.y
            end
            if button.alignment == "center-right" then
                button.realX = love.graphics.getWidth() + button.x
                button.realY = love.graphics.getHeight() / 2 + button.y
            end
            if button.alignment == "bottom-right" then
                button.realX = love.graphics.getWidth() + button.x
                button.realY = love.graphics.getHeight() + button.y
            end
            --draw button

            if button.pressed == false then
                -- draw the accent
                love.graphics.setColor(button.accentColor.r / 255, button.accentColor.g / 255, button.accentColor.b / 255, button.accentColor.a / 255)
                love.graphics.rectangle("fill", button.realX + 12, button.realY, button.width - 24, button.height + button.shadowSize)
                
                --left side curvature
                love.graphics.circle("fill", button.realX + 12, button.realY + 12, 12)
                love.graphics.circle("fill", button.realX + 12, button.realY - 12 + button.height + button.shadowSize, 12)
                love.graphics.rectangle("fill", button.realX, button.realY + 12, 24, button.height - 24 + button.shadowSize)

                --right side curvature
                love.graphics.circle("fill", button.realX - 12 + button.width, button.realY + 12, 12)
                love.graphics.circle("fill", button.realX - 12 + button.width, button.realY - 12 + button.height + button.shadowSize, 12)
                love.graphics.rectangle("fill", button.realX + button.width - 24, button.realY + 12, 24, button.height - 24 + button.shadowSize)


                -- draw the actual button
                love.graphics.setColor(button.color.r / 255, button.color.g / 255, button.color.b / 255, button.color.a / 255)
                love.graphics.rectangle("fill", button.realX + 12, button.realY + button.accentSize / 2, button.width - 24, button.height - button.accentSize)

                --left side curvature
                love.graphics.circle("fill", button.realX + 12 + button.accentSize / 2, button.realY + 12 + button.accentSize / 2, 12)
                love.graphics.circle("fill", button.realX + 12 + button.accentSize / 2, button.realY - 12 + button.height - button.accentSize / 2, 12)
                love.graphics.rectangle("fill", button.realX + button.accentSize / 2, button.realY + 12, 24, button.height - 24)

                --right side curvature
                love.graphics.circle("fill", button.realX - 12 + button.width - button.accentSize / 2, button.realY + 12 + button.accentSize / 2, 12)
                love.graphics.circle("fill", button.realX - 12 + button.width - button.accentSize / 2, button.realY - 12 + button.height - button.accentSize / 2, 12)
                love.graphics.rectangle("fill", button.realX + button.width - 24 - button.accentSize / 2, button.realY + 12, 24, button.height - 24)
                love.graphics.setColor(1,1,1,1)

                love.graphics.setFont(uivi.defaultFont)
                love.graphics.printf(button.text, button.realX + button.textOffsetX, button.realY + button.height / 2 - button.textHeight / 2 - 4 + button.textOffsetY, button.width, "center")
            else
                -- draw the accent
                love.graphics.setColor(button.accentColor.r / 255, button.accentColor.g / 255, button.accentColor.b / 255, button.accentColor.a / 255)
                love.graphics.rectangle("fill", button.realX + 12, button.realY + 3 * button.shadowSize / 4, button.width - 24, button.height + button.shadowSize / 4)
                
                --left side curvature
                love.graphics.circle("fill", button.realX + 12, button.realY + 12 + 3 * button.shadowSize / 4, 12)
                love.graphics.circle("fill", button.realX + 12, button.realY - 12 + button.height + button.shadowSize, 12)
                love.graphics.rectangle("fill", button.realX, button.realY + 12 + 3 * button.shadowSize / 4, 24, button.height - 24)

                --right side curvature
                love.graphics.circle("fill", button.realX - 12 + button.width, button.realY + 12 + 3 * button.shadowSize / 4, 12)
                love.graphics.circle("fill", button.realX - 12 + button.width, button.realY - 12 + button.height + button.shadowSize, 12)
                love.graphics.rectangle("fill", button.realX + button.width - 24, button.realY + 12 + 3 * button.shadowSize / 4, 24, button.height - 24)


                -- draw the actual button
                love.graphics.setColor(button.color.r / 255, button.color.g / 255, button.color.b / 255, button.color.a / 255)
                love.graphics.rectangle("fill", button.realX + 12, button.realY + button.accentSize / 2 + 3 * button.shadowSize / 4, button.width - 24, button.height - button.accentSize)

                --left side curvature
                love.graphics.circle("fill", button.realX + 12 + button.accentSize / 2, button.realY + 12 + button.accentSize / 2 + 3 * button.shadowSize / 4, 12)
                love.graphics.circle("fill", button.realX + 12 + button.accentSize / 2, button.realY - 12 + button.height - button.accentSize / 2 + 3 * button.shadowSize / 4, 12)
                love.graphics.rectangle("fill", button.realX + button.accentSize / 2, button.realY + 12 + 3 * button.shadowSize / 4, 24, button.height - 24)

                --right side curvature
                love.graphics.circle("fill", button.realX - 12 + button.width - button.accentSize / 2, button.realY + 12 + button.accentSize / 2 + 3 * button.shadowSize / 4, 12)
                love.graphics.circle("fill", button.realX - 12 + button.width - button.accentSize / 2, button.realY - 12 + button.height - button.accentSize / 2 + 3 * button.shadowSize / 4, 12)
                love.graphics.rectangle("fill", button.realX + button.width - 24 - button.accentSize / 2, button.realY + 12 + 3 * button.shadowSize / 4, 24, button.height - 24)
                love.graphics.setColor(1,1,1,1)

                love.graphics.setFont(uivi.defaultFont)
                love.graphics.printf(button.text, button.realX + button.textOffsetX, button.realY + button.height / 2 - button.textHeight / 2 - 4 + button.textOffsetY + 3 * button.shadowSize / 4, button.width, "center")
            end
            love.graphics.setColor(1,1,1,1)
        end
    end

    function button:isClicked(x, y, mousePress)
        
        local result = false
        if x >= button.realX and x <= button.realX + button.width and y >= button.realY and y <= button.realY + button.height then
            if mousePress == true then
                result = true
                --print("wot")
            end
        end

        if button.visible == false then
            result = false
        end

        if button.pressed == true and result == false then
            
        
            button:onReleased()
        end

        button.pressed = result
        return result
    end

    function button:onReleased()    

    end

    function button:setVisible(toggle)
        button.visible = toggle
    end

    function button:isVisible()
        return button.visible
    end

    function button:setAlignment(alignment)
        button.alignment = alignment
    end

    function button:setText(text)
        button.text = text
        button.textWidth = uivi.defaultFont:getWidth(text)
    end

    function button:setColor(color)
        button.color.r, button.color.g, button.color.b, button.color.a = unpack(color)
    end

    return button
end

function uivi.newTextBox(x, y, width, height, text, visible)
    local textBox = {}
    textBox.x = x
    textBox.y = y
    textBox.realX = x
    textBox.realY = y
    textBox.alignment = "top-left"
    textBox.width = width
    textBox.height = height
    textBox.text = text
    textBox.textOffsetX = 0
    textBox.textOffsetY = 0
    textBox.color = {}
    textBox.color.r = 40
    textBox.color.g = 40
    textBox.color.b = 40
    textBox.color.a = 255
    textBox.accentSize = 4
    textBox.shadowSize = 8
    textBox.accentColor = {}
    textBox.accentColor.r = 255
    textBox.accentColor.g = 255
    textBox.accentColor.b = 255
    textBox.accentColor.a = 255
    textBox.visible = visible
    textBox.pressed = false
    textBox.textWidth = uivi.defaultFont:getWidth(text)
    textBox.textHeight = uivi.defaultFont:getHeight()
    textBox.editingText = false
    textBox.numericalOnly = false
    textBox.flashTimer = 0
    textBox.flashInterval = 0.1
    
    textBox.onClick = function()
    
    end

    textBox.onClickOutside = function()

    end

    textBox.onRelease = function()

    end

    function textBox:draw()
        if textBox.visible == true then

            --set alignment
            if textBox.alignment == "top-left" then
                textBox.realX = textBox.x
                textBox.realY = textBox.y
            end
            if textBox.alignment == "center-left" then
                textBox.realX = textBox.x
                textBox.realY = love.graphics.getHeight() / 2 + textBox.y
            end
            if textBox.alignment == "bottom-left" then
                textBox.realX = textBox.x
                textBox.realY = love.graphics.getHeight() + textBox.y
            end
            if textBox.alignment == "top-center" then
                textBox.realX = love.graphics.getWidth() / 2 + textBox.x
                textBox.realY = textBox.y
            end
            if textBox.alignment == "center" then
                textBox.realX = love.graphics.getWidth() / 2 + textBox.x
                textBox.realY = love.graphics.getHeight() / 2 + textBox.y
            end
            if textBox.alignment == "bottom-center" then
                textBox.realX = love.graphics.getWidth() / 2 + textBox.x
                textBox.realY = love.graphics.getHeight() + textBox.y
            end
            if textBox.alignment == "top-right" then
                textBox.realX = love.graphics.getWidth() + textBox.x
                textBox.realY = textBox.y
            end
            if textBox.alignment == "center-right" then
                textBox.realX = love.graphics.getWidth() + textBox.x
                textBox.realY = love.graphics.getHeight() / 2 + textBox.y
            end
            if textBox.alignment == "bottom-right" then
                textBox.realX = love.graphics.getWidth() + textBox.x
                textBox.realY = love.graphics.getHeight() + textBox.y
            end
            --draw textBox

            if textBox.pressed == false then
                -- draw the accent
                love.graphics.setColor(textBox.accentColor.r / 255, textBox.accentColor.g / 255, textBox.accentColor.b / 255, textBox.accentColor.a / 255)
                love.graphics.rectangle("fill", textBox.realX + 12, textBox.realY, textBox.width - 24, textBox.height + textBox.shadowSize)
                
                --left side curvature
                love.graphics.circle("fill", textBox.realX + 12, textBox.realY + 12, 12)
                love.graphics.circle("fill", textBox.realX + 12, textBox.realY - 12 + textBox.height + textBox.shadowSize, 12)
                love.graphics.rectangle("fill", textBox.realX, textBox.realY + 12, 24, textBox.height - 24 + textBox.shadowSize)

                --right side curvature
                love.graphics.circle("fill", textBox.realX - 12 + textBox.width, textBox.realY + 12, 12)
                love.graphics.circle("fill", textBox.realX - 12 + textBox.width, textBox.realY - 12 + textBox.height + textBox.shadowSize, 12)
                love.graphics.rectangle("fill", textBox.realX + textBox.width - 24, textBox.realY + 12, 24, textBox.height - 24 + textBox.shadowSize)


                -- draw the actual textBox
                love.graphics.setColor(textBox.color.r / 255, textBox.color.g / 255, textBox.color.b / 255, textBox.color.a / 255)
                love.graphics.rectangle("fill", textBox.realX + 12, textBox.realY + textBox.accentSize / 2, textBox.width - 24, textBox.height - textBox.accentSize)

                --left side curvature
                love.graphics.circle("fill", textBox.realX + 12 + textBox.accentSize / 2, textBox.realY + 12 + textBox.accentSize / 2, 12)
                love.graphics.circle("fill", textBox.realX + 12 + textBox.accentSize / 2, textBox.realY - 12 + textBox.height - textBox.accentSize / 2, 12)
                love.graphics.rectangle("fill", textBox.realX + textBox.accentSize / 2, textBox.realY + 12, 24, textBox.height - 24)

                --right side curvature
                love.graphics.circle("fill", textBox.realX - 12 + textBox.width - textBox.accentSize / 2, textBox.realY + 12 + textBox.accentSize / 2, 12)
                love.graphics.circle("fill", textBox.realX - 12 + textBox.width - textBox.accentSize / 2, textBox.realY - 12 + textBox.height - textBox.accentSize / 2, 12)
                love.graphics.rectangle("fill", textBox.realX + textBox.width - 24 - textBox.accentSize / 2, textBox.realY + 12, 24, textBox.height - 24)
                love.graphics.setColor(1,1,1,1)

                love.graphics.setFont(uivi.defaultFont)
                love.graphics.printf(textBox.text, textBox.realX + textBox.textOffsetX, textBox.realY + textBox.height / 2 - textBox.textHeight / 2 - 4 + textBox.textOffsetY, textBox.width, "center")
            
                if textBox.editingText == true then
                    textBox.flashTimer = textBox.flashTimer + 0.001
                    if textBox.flashTimer <= textBox.flashInterval /  2 then
                        love.graphics.rectangle("fill", textBox.realX + textBox.width / 2 + textBox.textWidth/2, textBox.realY + 6, 2, 12)
                    end
                    if textBox.flashTimer >= textBox.flashInterval then
                        textBox.flashTimer = 0
                    end
                end
            else
                -- draw the accent
                love.graphics.setColor(textBox.accentColor.r / 255, textBox.accentColor.g / 255, textBox.accentColor.b / 255, textBox.accentColor.a / 255)
                love.graphics.rectangle("fill", textBox.realX + 12, textBox.realY + 3 * textBox.shadowSize / 4, textBox.width - 24, textBox.height + textBox.shadowSize / 4)
                
                --left side curvature
                love.graphics.circle("fill", textBox.realX + 12, textBox.realY + 12 + 3 * textBox.shadowSize / 4, 12)
                love.graphics.circle("fill", textBox.realX + 12, textBox.realY - 12 + textBox.height + textBox.shadowSize, 12)
                love.graphics.rectangle("fill", textBox.realX, textBox.realY + 12 + 3 * textBox.shadowSize / 4, 24, textBox.height - 24)

                --right side curvature
                love.graphics.circle("fill", textBox.realX - 12 + textBox.width, textBox.realY + 12 + 3 * textBox.shadowSize / 4, 12)
                love.graphics.circle("fill", textBox.realX - 12 + textBox.width, textBox.realY - 12 + textBox.height + textBox.shadowSize, 12)
                love.graphics.rectangle("fill", textBox.realX + textBox.width - 24, textBox.realY + 12 + 3 * textBox.shadowSize / 4, 24, textBox.height - 24)


                -- draw the actual textBox
                love.graphics.setColor(textBox.color.r / 255, textBox.color.g / 255, textBox.color.b / 255, textBox.color.a / 255)
                love.graphics.rectangle("fill", textBox.realX + 12, textBox.realY + textBox.accentSize / 2 + 3 * textBox.shadowSize / 4, textBox.width - 24, textBox.height - textBox.accentSize)

                --left side curvature
                love.graphics.circle("fill", textBox.realX + 12 + textBox.accentSize / 2, textBox.realY + 12 + textBox.accentSize / 2 + 3 * textBox.shadowSize / 4, 12)
                love.graphics.circle("fill", textBox.realX + 12 + textBox.accentSize / 2, textBox.realY - 12 + textBox.height - textBox.accentSize / 2 + 3 * textBox.shadowSize / 4, 12)
                love.graphics.rectangle("fill", textBox.realX + textBox.accentSize / 2, textBox.realY + 12 + 3 * textBox.shadowSize / 4, 24, textBox.height - 24)

                --right side curvature
                love.graphics.circle("fill", textBox.realX - 12 + textBox.width - textBox.accentSize / 2, textBox.realY + 12 + textBox.accentSize / 2 + 3 * textBox.shadowSize / 4, 12)
                love.graphics.circle("fill", textBox.realX - 12 + textBox.width - textBox.accentSize / 2, textBox.realY - 12 + textBox.height - textBox.accentSize / 2 + 3 * textBox.shadowSize / 4, 12)
                love.graphics.rectangle("fill", textBox.realX + textBox.width - 24 - textBox.accentSize / 2, textBox.realY + 12 + 3 * textBox.shadowSize / 4, 24, textBox.height - 24)
                love.graphics.setColor(1,1,1,1)

                love.graphics.setFont(uivi.defaultFont)
                love.graphics.printf(textBox.text, textBox.realX + textBox.textOffsetX, textBox.realY + textBox.height / 2 - textBox.textHeight / 2 - 4 + textBox.textOffsetY + 3 * textBox.shadowSize / 4, textBox.width, "center")
            end
            love.graphics.setColor(1,1,1,1)
        end
    end

    function textBox:checkKey(key)
        if textBox.editingText == true then
            if key == "backspace" then
                textBox:setText(string.sub(textBox.text, 1, string.len(textBox.text) - 1))
                return
            end
            if textBox.numericalOnly == true then
                if tonumber(key) ~= nil then
                    if not (textBox.text == "" and key == "0") then
                        textBox:setText(textBox.text .. key)
                    end
                end
            else
                textBox:setText(textBox.text .. key)
            end
            
        end
    end

    function textBox:isClicked(x, y, mousePress)
        
        local result = false
        
        if x >= textBox.realX and x <= textBox.realX + textBox.width and y >= textBox.realY and y <= textBox.realY + textBox.height then
            if mousePress == true then
                result = true
                --print("wot")
            end
        end

        if textBox.visible == false then
            result = false
        end

        if textBox.pressed == true and result == false then
            
        
            textBox:onReleased()
        end

        

        textBox.pressed = result
        if result == true then
            textBox.editingText =  true
            love.keyboard.setTextInput(true)
        else
            
        end
        return result
    end

    function textBox:onReleased()    

    end

    function textBox:setVisible(toggle)
        textBox.visible = toggle
    end

    function textBox:isVisible()
        return textBox.visible
    end

    function textBox:setAlignment(alignment)
        textBox.alignment = alignment
    end

    function textBox:setText(text)
        textBox.text = text
        textBox.textWidth = uivi.defaultFont:getWidth(text)
    end

    function textBox:setColor(color)
        textBox.color.r, textBox.color.g, textBox.color.b, textBox.color.a = unpack(color)
    end

    return textBox
end

function uivi.newCheckBox(x, y, width, height, text, visible)
    local checkbox = {}
    checkbox.x = x
    checkbox.y = y
    checkbox.realX = x
    checkbox.realY = y
    checkbox.alignment = "top-left"
    checkbox.width = width
    checkbox.height = height
    checkbox.text = text
    checkbox.textOffsetX = 0
    checkbox.textOffsetY = 0
    checkbox.color = {}
    checkbox.color.r = 40
    checkbox.color.g = 40
    checkbox.color.b = 40
    checkbox.color.a = 255
    checkbox.accentSize = 4
    checkbox.shadowSize = 8
    checkbox.accentColor = {}
    checkbox.accentColor.r = 255
    checkbox.accentColor.g = 255
    checkbox.accentColor.b = 255
    checkbox.accentColor.a = 255
    checkbox.visible = visible
    checkbox.pressed = false
    checkbox.checked = false
    checkbox.textHeight = uivi.defaultFont:getHeight()
    checkbox.onClick = function()
        
    end

    checkbox.onClickOutside = function()

    end

    checkbox.onRelease = function()

    end

    checkbox.onCheckStateChanged = function()

    end

    function checkbox:draw()
        if checkbox.visible == true then

            --set alignment
            if checkbox.alignment == "top-left" then
                checkbox.realX = checkbox.x
                checkbox.realY = checkbox.y
            end
            if checkbox.alignment == "center-left" then
                checkbox.realX = checkbox.x
                checkbox.realY = love.graphics.getHeight() / 2 + checkbox.y
            end
            if checkbox.alignment == "bottom-left" then
                checkbox.realX = checkbox.x
                checkbox.realY = love.graphics.getHeight() + checkbox.y
            end
            if checkbox.alignment == "top-center" then
                checkbox.realX = love.graphics.getWidth() / 2 + checkbox.x
                checkbox.realY = checkbox.y
            end
            if checkbox.alignment == "center" then
                checkbox.realX = love.graphics.getWidth() / 2 + checkbox.x
                checkbox.realY = love.graphics.getHeight() / 2 + checkbox.y
            end
            if checkbox.alignment == "bottom-center" then
                checkbox.realX = love.graphics.getWidth() / 2 + checkbox.x
                checkbox.realY = love.graphics.getHeight() + checkbox.y
            end
            if checkbox.alignment == "top-right" then
                checkbox.realX = love.graphics.getWidth() + checkbox.x
                checkbox.realY = checkbox.y
            end
            if checkbox.alignment == "center-right" then
                checkbox.realX = love.graphics.getWidth() + checkbox.x
                checkbox.realY = love.graphics.getHeight() / 2 + checkbox.y
            end
            if checkbox.alignment == "bottom-right" then
                checkbox.realX = love.graphics.getWidth() + checkbox.x
                checkbox.realY = love.graphics.getHeight() + checkbox.y
            end
            --draw checkbox
            if checkbox.pressed == true then
                -- draw the accent
                love.graphics.setColor(checkbox.accentColor.r / 255, checkbox.accentColor.g / 255, checkbox.accentColor.b / 255, checkbox.accentColor.a / 255)
                love.graphics.rectangle("fill", checkbox.realX + 12, checkbox.realY + 3 * checkbox.shadowSize / 4, checkbox.width - 24, checkbox.height + checkbox.shadowSize / 4)
                
                --left side curvature
                love.graphics.circle("fill", checkbox.realX + 12, checkbox.realY + 12 + 3 * checkbox.shadowSize / 4, 12)
                love.graphics.circle("fill", checkbox.realX + 12, checkbox.realY - 12 + checkbox.height + checkbox.shadowSize, 12)
                love.graphics.rectangle("fill", checkbox.realX, checkbox.realY + 12 + 3 * checkbox.shadowSize / 4, 24, checkbox.height - 24)

                --right side curvature
                love.graphics.circle("fill", checkbox.realX - 12 + checkbox.width, checkbox.realY + 12 + 3 * checkbox.shadowSize / 4, 12)
                love.graphics.circle("fill", checkbox.realX - 12 + checkbox.width, checkbox.realY - 12 + checkbox.height + checkbox.shadowSize, 12)
                love.graphics.rectangle("fill", checkbox.realX + checkbox.width - 24, checkbox.realY + 12 + 3 * checkbox.shadowSize / 4, 24, checkbox.height - 24)


                -- draw the actual checkbox
                love.graphics.setColor(checkbox.color.r / 255, checkbox.color.g / 255, checkbox.color.b / 255, checkbox.color.a / 255)
                love.graphics.rectangle("fill", checkbox.realX + 12, checkbox.realY + checkbox.accentSize / 2 + 3 * checkbox.shadowSize / 4, checkbox.width - 24, checkbox.height - checkbox.accentSize)

                --left side curvature
                love.graphics.circle("fill", checkbox.realX + 12 + checkbox.accentSize / 2, checkbox.realY + 12 + checkbox.accentSize / 2 + 3 * checkbox.shadowSize / 4, 12)
                love.graphics.circle("fill", checkbox.realX + 12 + checkbox.accentSize / 2, checkbox.realY - 12 + checkbox.height - checkbox.accentSize / 2 + 3 * checkbox.shadowSize / 4, 12)
                love.graphics.rectangle("fill", checkbox.realX + checkbox.accentSize / 2, checkbox.realY + 12 + 3 * checkbox.shadowSize / 4, 24, checkbox.height - 24)

                --right side curvature
                love.graphics.circle("fill", checkbox.realX - 12 + checkbox.width - checkbox.accentSize / 2, checkbox.realY + 12 + checkbox.accentSize / 2 + 3 * checkbox.shadowSize / 4, 12)
                love.graphics.circle("fill", checkbox.realX - 12 + checkbox.width - checkbox.accentSize / 2, checkbox.realY - 12 + checkbox.height - checkbox.accentSize / 2 + 3 * checkbox.shadowSize / 4, 12)
                love.graphics.rectangle("fill", checkbox.realX + checkbox.width - 24 - checkbox.accentSize / 2, checkbox.realY + 12 + 3 * checkbox.shadowSize / 4, 24, checkbox.height - 24)
                love.graphics.setColor(1,1,1,1)

                love.graphics.setFont(uivi.defaultFont)
                love.graphics.printf(checkbox.text, checkbox.realX + checkbox.textOffsetX, checkbox.realY + checkbox.height / 2 - checkbox.textHeight / 2 - 4 + checkbox.textOffsetY + 3 * checkbox.shadowSize / 4, checkbox.width, "center")
            elseif checkbox.checked == true then
                -- draw the accent
                love.graphics.setColor(checkbox.accentColor.r / 255, checkbox.accentColor.g / 255, checkbox.accentColor.b / 255, checkbox.accentColor.a / 255)
                love.graphics.rectangle("fill", checkbox.realX + 12, checkbox.realY + 3 * checkbox.shadowSize / 8, checkbox.width - 24, checkbox.height + 3 * checkbox.shadowSize / 4)
                
                --left side curvature
                love.graphics.circle("fill", checkbox.realX + 12, checkbox.realY + 12 + 3 * checkbox.shadowSize / 8, 12)
                love.graphics.circle("fill", checkbox.realX + 12, checkbox.realY - 12 + checkbox.height + checkbox.shadowSize, 12)
                love.graphics.rectangle("fill", checkbox.realX, checkbox.realY + 12 + checkbox.shadowSize / 4, 24, checkbox.height - 24)

                --right side curvature
                love.graphics.circle("fill", checkbox.realX - 12 + checkbox.width, checkbox.realY + 12 + 3 * checkbox.shadowSize / 8, 12)
                love.graphics.circle("fill", checkbox.realX - 12 + checkbox.width, checkbox.realY - 12 + checkbox.height + checkbox.shadowSize, 12)
                love.graphics.rectangle("fill", checkbox.realX + checkbox.width - 24, checkbox.realY + 12 + 3 * checkbox.shadowSize / 8, 24, checkbox.height - 24)


                -- draw the actual checkbox
                love.graphics.setColor(checkbox.color.r * 2 / 255, checkbox.color.g * 2 / 255, checkbox.color.b * 2 / 255, checkbox.color.a / 255)
                love.graphics.rectangle("fill", checkbox.realX + 12, checkbox.realY + checkbox.accentSize / 2 + 3 * checkbox.shadowSize / 8, checkbox.width - 24, checkbox.height - checkbox.accentSize)

                --left side curvature
                love.graphics.circle("fill", checkbox.realX + 12 + checkbox.accentSize / 2, checkbox.realY + 12 + checkbox.accentSize / 2 + 3 * checkbox.shadowSize / 8, 12)
                love.graphics.circle("fill", checkbox.realX + 12 + checkbox.accentSize / 2, checkbox.realY - 12 + checkbox.height - checkbox.accentSize / 2 + 3 * checkbox.shadowSize / 8, 12)
                love.graphics.rectangle("fill", checkbox.realX + checkbox.accentSize / 2, checkbox.realY + 12 + 3 * checkbox.shadowSize / 8, 24, checkbox.height - 24)

                --right side curvature
                love.graphics.circle("fill", checkbox.realX - 12 + checkbox.width - checkbox.accentSize / 2, checkbox.realY + 12 + checkbox.accentSize / 2 + 3 * checkbox.shadowSize / 8, 12)
                love.graphics.circle("fill", checkbox.realX - 12 + checkbox.width - checkbox.accentSize / 2, checkbox.realY - 12 + checkbox.height - checkbox.accentSize / 2 + 3 * checkbox.shadowSize / 8, 12)
                love.graphics.rectangle("fill", checkbox.realX + checkbox.width - 24 - checkbox.accentSize / 2, checkbox.realY + 12 + 3 * checkbox.shadowSize / 8, 24, checkbox.height - 24)
                love.graphics.setColor(1,1,1,1)

                love.graphics.setFont(uivi.defaultFont)
                love.graphics.printf(checkbox.text, checkbox.realX + checkbox.textOffsetX, checkbox.realY + checkbox.height / 2 - checkbox.textHeight / 2 - 4 + checkbox.textOffsetY + 3 * checkbox.shadowSize / 8, checkbox.width, "center")
                
                
            else
                -- draw the accent
                love.graphics.setColor(checkbox.accentColor.r / 255, checkbox.accentColor.g / 255, checkbox.accentColor.b / 255, checkbox.accentColor.a / 255)
                love.graphics.rectangle("fill", checkbox.realX + 12, checkbox.realY, checkbox.width - 24, checkbox.height + checkbox.shadowSize)
                
                --left side curvature
                love.graphics.circle("fill", checkbox.realX + 12, checkbox.realY + 12, 12)
                love.graphics.circle("fill", checkbox.realX + 12, checkbox.realY - 12 + checkbox.height + checkbox.shadowSize, 12)
                love.graphics.rectangle("fill", checkbox.realX, checkbox.realY + 12, 24, checkbox.height - 24 + checkbox.shadowSize)

                --right side curvature
                love.graphics.circle("fill", checkbox.realX - 12 + checkbox.width, checkbox.realY + 12, 12)
                love.graphics.circle("fill", checkbox.realX - 12 + checkbox.width, checkbox.realY - 12 + checkbox.height + checkbox.shadowSize, 12)
                love.graphics.rectangle("fill", checkbox.realX + checkbox.width - 24, checkbox.realY + 12, 24, checkbox.height - 24 + checkbox.shadowSize)


                -- draw the actual checkbox
                love.graphics.setColor(checkbox.color.r / 255, checkbox.color.g / 255, checkbox.color.b / 255, checkbox.color.a / 255)
                love.graphics.rectangle("fill", checkbox.realX + 12, checkbox.realY + checkbox.accentSize / 2, checkbox.width - 24, checkbox.height - checkbox.accentSize)

                --left side curvature
                love.graphics.circle("fill", checkbox.realX + 12 + checkbox.accentSize / 2, checkbox.realY + 12 + checkbox.accentSize / 2, 12)
                love.graphics.circle("fill", checkbox.realX + 12 + checkbox.accentSize / 2, checkbox.realY - 12 + checkbox.height - checkbox.accentSize / 2, 12)
                love.graphics.rectangle("fill", checkbox.realX + checkbox.accentSize / 2, checkbox.realY + 12, 24, checkbox.height - 24)

                --right side curvature
                love.graphics.circle("fill", checkbox.realX - 12 + checkbox.width - checkbox.accentSize / 2, checkbox.realY + 12 + checkbox.accentSize / 2, 12)
                love.graphics.circle("fill", checkbox.realX - 12 + checkbox.width - checkbox.accentSize / 2, checkbox.realY - 12 + checkbox.height - checkbox.accentSize / 2, 12)
                love.graphics.rectangle("fill", checkbox.realX + checkbox.width - 24 - checkbox.accentSize / 2, checkbox.realY + 12, 24, checkbox.height - 24)
                love.graphics.setColor(1,1,1,1)

                love.graphics.setFont(uivi.defaultFont)
                love.graphics.printf(checkbox.text, checkbox.realX + checkbox.textOffsetX, checkbox.realY + checkbox.height / 2 - checkbox.textHeight / 2 - 4 + checkbox.textOffsetY, checkbox.width, "center")
            end
            love.graphics.setColor(1,1,1,1)
        end
    end

    function checkbox:isClicked(x, y, mousePress)
        
        local result = false
        if x >= checkbox.realX and x <= checkbox.realX + checkbox.width and y >= checkbox.realY and y <= checkbox.realY + checkbox.height then
            if mousePress == true then
                result = true
                --print("wot")
            end
        end

        if checkbox.visible == false then
            result = false
        end

        if checkbox.pressed == true and result == false then
            
        
            checkbox:onReleased()
        end

        checkbox.pressed = result
        if result == true then
            checkbox.checked = not checkbox.checked
            checkbox:onCheckStateChanged()
        end
        return result
    end

    function checkbox:onReleased()    

    end

    function checkbox:setVisible(toggle)
        checkbox.visible = toggle
    end

    function checkbox:isVisible()
        return checkbox.visible
    end

    function checkbox:setAlignment(alignment)
        checkbox.alignment = alignment
    end

    function checkbox:setColor(color)
        checkbox.color.r, checkbox.color.g, checkbox.color.b, checkbox.color.a = unpack(color)
    end

    return checkbox
end

return uivi