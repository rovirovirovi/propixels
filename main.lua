require "camera"

local ffi = require("ffi")
local binser = require("binser")

-- ============ UI PART ==============
local uivi = require("uivi")
local panels = {}
local buttons = {}
local textBoxes = {}

-- =========== PANELS ==============
local panelTop = uivi.newPanel(0, 0, love.graphics.getWidth(), 42, true)
local panelLeft = uivi.newPanel(0, panelTop.height+2, 128, love.graphics.getHeight() - (panelTop.height + 2), true)
local panelRight = uivi.newPanel(-70, panelTop.height+2, 70, love.graphics.getHeight() - (panelTop.height + 2), true)

-- =========== TOP BUTTONS ============
local buttonFile = uivi.newSquareButton(4, 2, 48, 32 - 4, "file", true)
local buttonView = uivi.newSquareButton(buttonFile.realX + 52, 2, 48, 32-4, "view", true)

-- =========== RIGHT SIDE BUTTONS =============
local buttonPen = uivi.newCheckBox( -67, panelRight.realY + 3, 64, 48, "pen", true)
local buttonEraser = uivi.newCheckBox(-67, buttonPen.realY+48+8+2, 64, 48, "eraser", true)
local buttonColorPicker = uivi.newCheckBox(-67, buttonEraser.realY+48+8+2, 64, 48, "color\npicker", true)
local buttonSquareSelect = uivi.newCheckBox(-67, buttonColorPicker.realY+48+8+2, 64, 48, "area\nselect", true)
local buttonFill = uivi.newCheckBox(-67, buttonSquareSelect.realY+48+8+2, 64, 48, "fill", true)
local buttonPan = uivi.newCheckBox(-67, buttonFill.realY + 48+8+2, 64, 48, "pan", true)
local buttonZoom = uivi.newCheckBox(-67, buttonPan.realY + 48+8+2, 64, 48, "zoom", true)


table.insert(panels, panelTop)
table.insert(panels, panelLeft)
table.insert(panels, panelRight)



-- /////// RIGHT SIDE BUTTONS //////////
table.insert(buttons, buttonPen)
table.insert(buttons, buttonEraser)
table.insert(buttons, buttonColorPicker)
table.insert(buttons, buttonSquareSelect)
table.insert(buttons, buttonPan)
table.insert(buttons, buttonFill)
table.insert(buttons, buttonZoom)

-- ///////// TOP BUTTONS ////////
table.insert(buttons, buttonFile)
table.insert(buttons, buttonView)

-- /////// PANELS //////////
local panelFileMenu = uivi.newPanel(-128, -128, 256, 256, false)
table.insert(panels, panelFileMenu)


-- //////// LABELS //////////
local labelFileMenuFileName = uivi.newLabel(0, panelFileMenu.realY + 2, "untitled.pp", false)

local labels = {}
table.insert(labels, labelFileMenuFileName)


-- //////// FileMenuObject ///////
local buttonFileMenuClose = uivi.newSquareButton(panelFileMenu.realY + panelFileMenu.width - 28 - 2, panelFileMenu.realY + 2, 28, 28, "x", false)
local buttonFileMenuNew = uivi.newSquareButton(panelFileMenu.realX + 2, labelFileMenuFileName.realY + 2 + 28, 64, 28, "new", false)
local buttonFileMenuSaveFile = uivi.newSquareButton(panelFileMenu.realX + 2, buttonFileMenuNew.realY + 2 + 28 + 8, 64, 28, "save", false)
local buttonFileMenuLoadFile = uivi.newSquareButton(panelFileMenu.realX + 2, buttonFileMenuSaveFile.realY + 2 + 28 + 8, 64, 28, "load", false)
local buttonFileMenuExportFile = uivi.newSquareButton(panelFileMenu.realX + 2, buttonFileMenuLoadFile.realY + 2 + 28 + 8, 64, 28, "export", false)

table.insert(buttons, buttonFileMenuClose)
table.insert(buttons, buttonFileMenuSaveFile)
table.insert(buttons, buttonFileMenuNew)
table.insert(buttons, buttonFileMenuLoadFile)
table.insert(buttons, buttonFileMenuExportFile)

-- /////// NEW FILE OBJECTS ///////
local panelFileMenuNewFile = uivi.newPanel(-128, -128, 256, 256, false)
local labelFileMenuNewFile = uivi.newLabel(panelFileMenuNewFile.realX + panelFileMenuNewFile.width / 2, panelFileMenuNewFile.realY, "new file", false)
local labelFileMenuNewFileWidth = uivi.newLabel(panelFileMenuNewFile.realX + panelFileMenuNewFile.width / 2, panelFileMenuNewFile.realY + 50, "canvas width", false)
local buttonFileMenuNewFileClose = uivi.newSquareButton(panelFileMenuNewFile.realY + panelFileMenuNewFile.width - 28 - 2, panelFileMenuNewFile.realY + 2, 28, 28, "X", false)
local buttonFileMenuNewFileWidth = uivi.newTextBox(panelFileMenuNewFile.realX + 2, labelFileMenuNewFileWidth.realY + 20, panelFileMenuNewFile.width - 4, 28, "16", false)
local labelFileMenuNewFileHeight = uivi.newLabel(panelFileMenuNewFile.realX + panelFileMenuNewFile.width / 2, buttonFileMenuNewFileWidth.realY + 50, "canvas height", false)
local buttonFileMenuNewFileHeight = uivi.newTextBox(panelFileMenuNewFile.realX + 2, labelFileMenuNewFileHeight.realY + 20, panelFileMenuNewFile.width - 4, 28, "16", false)
local buttonFileMenuNewFileCreate = uivi.newSquareButton(panelFileMenuNewFile.realX + 2, buttonFileMenuNewFileHeight.realY + 64, panelFileMenuNewFile.width - 4, 28, "create", false)

editingWidthButton = false
editingHeightButton = false

table.insert(panels, panelFileMenuNewFile)
table.insert(buttons, buttonFileMenuNewFileClose)
table.insert(textBoxes, buttonFileMenuNewFileWidth)
table.insert(labels, labelFileMenuNewFileHeight)
table.insert(labels, labelFileMenuNewFile)
table.insert(labels, labelFileMenuNewFileWidth)
table.insert(textBoxes, buttonFileMenuNewFileHeight)
table.insert(buttons, buttonFileMenuNewFileCreate)

-- //////// VIEW MENU OBJECTS
local panelView = uivi.newPanel(-128, -128, 256, 256, false)
local buttonViewClose = uivi.newSquareButton(panelView.realX + panelView.width - 28 - 2, panelView.realY + 2, 28, 28, "X", false)
local checkBoxToggleGrid = uivi.newCheckBox(panelView.realX, panelView.realY + 48, 110, 28, "toggle grid", false)
local textBoxGridWidth = uivi.newTextBox(checkBoxToggleGrid.realX + checkBoxToggleGrid.width + 4, checkBoxToggleGrid.realY, 64, 28, "16", false)
local textBoxGridHeight = uivi.newTextBox(textBoxGridWidth.realX + textBoxGridWidth.width + 4, checkBoxToggleGrid.realY, 64, 28, "16", false)
local buttonToggleRepeatX = uivi.newCheckBox(panelView.realX, textBoxGridHeight.realY + 32 + 6, 110, 28, "tiling x", false)
local buttonToggleRepeatY = uivi.newCheckBox(panelView.realX, buttonToggleRepeatX.realY + 32 + 6, 110, 28, "tiling y", false)

table.insert(panels, panelView)
table.insert(buttons, buttonViewClose)
table.insert(buttons, checkBoxToggleGrid)
table.insert(textBoxes, textBoxGridWidth)
table.insert(textBoxes, textBoxGridHeight)
table.insert(buttons, buttonToggleRepeatX)
table.insert(buttons, buttonToggleRepeatY)

-- //////// LAYERS OBJECTS /////////
local panelLayers = uivi.newPanel(panelLeft.width + 2, -180, love.graphics.getWidth() - panelRight.width - panelLeft.width - 4, 180, true)
local labelLayers = uivi.newLabel(panelLayers.realX + 8, panelLayers.y + 2, "layers", true)
local labelFrames = uivi.newLabel(panelLayers.realX + 160 + 2 + 28, panelLayers.y + 2, "frames", true)
local buttonAddLayer = uivi.newSquareButton(labelLayers.realX + 64, panelLayers.y + 2, 28, 28, "+", true)
local layersButtons = {}
local layersVisibleButtons = {}

table.insert(panels, panelLayers)
table.insert(labels, labelLayers)
table.insert(labels, labelFrames)
table.insert(buttons, buttonAddLayer)

-- /////// FRAMES OBJECTS ////////
local framesButtons = {}


shouldCheckMouse = false

-- =========== DRAWING PART ============
width = 16
height = 16
scale = 16

drawingRectangle = {}
drawingRectangle.x = 0
drawingRectangle.y = 0

layers = {}

currentTool = "pen"
color1 = {}
color1.r = 255
color1.g = 255
color1.b = 255
color1.a = 255
color2 = {}
color2.r = 255
color2.g = 255
color2.b = 255
color2.a = 255

lastMouseX = 0
lastMouseY = 0

lastTileX = 0
lastTileY = 0

mX = 0
mY = 0

menuOpen = false

gridWidth = 16
gridHeight = 16

backgroundGridWidth = 16
backgroundGridHeight = 16
local backgroundGridCanvas

tileRepeatX = false
tileRepeatY = false

recursiveCount = 0

selectedLayer = 1

function love.load()

    if love.system.getOS() == "iOS" then
        love.window.setMode(love.graphics.getWidth(), love.graphics.getHeight(), {fullscreen = true, borderless = true})
    end

    love.filesystem.setIdentity("propixels")
    love.graphics.setDefaultFilter("nearest", "nearest")

    ffi.cdef[[
        int printf(const char *fmt, ...);
    ]]

    --ffi.C.printf("Hello %s!\n", "world")


    drawingRectangle.x = love.graphics.getWidth() / 2
    drawingRectangle.y = love.graphics.getHeight() / 2

    backgroundGridCanvas = love.graphics.newCanvas(width, height)
    backgroundGridCanvas:renderTo(function()
        love.graphics.setColor(.7,.7,.7)
        love.graphics.rectangle("fill", 0, 0, width,height)
        
        love.graphics.setColor(.5,.5,.5)
        for x = 0, math.floor(width / backgroundGridWidth) do
            for y = 0, math.floor(height / backgroundGridHeight) do
                if (x + y) % 2 == 0 then
                    love.graphics.rectangle("fill", x * backgroundGridWidth, y * backgroundGridHeight, backgroundGridWidth, backgroundGridHeight)
                else
                    love.graphics.rectangle("fill", x * backgroundGridWidth + backgroundGridWidth, y * backgroundGridHeight, backgroundGridWidth, backgroundGridHeight)
                end
            end
        end
        love.graphics.setColor(1,1,1)
        
    end)

    
    -- FIX SAVE / LOAD / EXPORT


    loadPaletteFile("palette1.ppalette")
    
    panelRight:setAlignment("top-right")

    buttonPen:setAlignment("top-right")
    buttonEraser:setAlignment("top-right")
    buttonColorPicker:setAlignment("top-right")
    buttonSquareSelect:setAlignment("top-right")
    buttonFill:setAlignment("top-right")
    buttonPan:setAlignment("top-right")
    buttonZoom:setAlignment("top-right")

    buttonPen.checked = true

    buttonColorPicker.textOffsetY = -8
    buttonSquareSelect.textOffsetY = -8
    buttonFile.textOffsetY = 2


    -- /////// LAYERS MENU ////////
    panelLayers:setAlignment("bottom-left")
    labelLayers:setAlignment("bottom-left")
    labelFrames:setAlignment("bottom-left")
    buttonAddLayer:setAlignment("bottom-left")

    layers[1] = {}
    layers[1].name = "layer 1"
    layers[1].data = love.image.newImageData(width, height)
    layers[1].image = love.graphics.newImage(layers[1].data)
    layers[1].visible = true

    buttonAddLayer.onRelease = function()
        newLayer = {}
        newLayer.name = "new layer"
        newLayer.data = love.image.newImageData(width, height)
        newLayer.image = love.graphics.newImage(newLayer.data)
        newLayer.visible = true
        table.insert(layers, newLayer)


        -- add layer btn
        local btn = uivi.newCheckBox(panelLayers.realX, panelLayers.y + 28 + 38 * (#layers-1), 160, 28, layers[#layers].name, true)
        btn:setAlignment("bottom-left")
        btn.layerNr = #layers
        btn.onRelease = function()
            for j = 1, #layers do
                if btn.layerNr ~= j then
                    layersButtons[j].checked = false
                    btn.checked = true
                    selectedLayer = btn.layerNr
                end
            end
        end
        
        table.insert(layersButtons, btn)
        local btnVisible = uivi.newSquareButton(btn.realX + 160 + 4, panelLayers.y + 28 + 38 * (#layers-1), 28, 28, "V", true)
        btnVisible:setAlignment("bottom-left")
        btnVisible.onRelease = function()
            layers[btn.layerNr].visible = not layers[btn.layerNr].visible
        end
        table.insert(layersVisibleButtons, btnVisible)

        -- add frames btns
        -- for j = 1, 10 do
        --     local btnFrame = uivi.newSquareButton(panelLayers.realX + j * 32 + 160, panelLayers.y + 28 + 38 * (#layers-1), 28, 28, j, true)
        --     btnFrame:setAlignment("bottom-left")
        --     btnFrame.onRelease = function()
        --         btn.checked = true
        --         btn:onRelease()
        --     end
        --     table.insert(framesButtons, btnFrame)
        -- end`
    end

    -- add button for layer 1
    local btnLayer1 = uivi.newCheckBox(panelLayers.realX, panelLayers.y + 28, 160, 28, layers[1].name, true)
    btnLayer1:setAlignment("bottom-left")
    btnLayer1.layerNr = 1
    btnLayer1.onRelease = function()
        for j = 1, #layers do
            if btnLayer1.layerNr ~= j then
                layersButtons[j].checked = false
                btnLayer1.checked = true
                selectedLayer = btnLayer1.layerNr
            end
        end
    end
    
    table.insert(layersButtons, btnLayer1)

    local btnVisible = uivi.newSquareButton(btnLayer1.realX + 160 + 4, panelLayers.y + 28, 28, 28, "V", true)
    btnVisible:setAlignment("bottom-left")
    btnVisible.onRelease = function()
        layers[btnLayer1.layerNr].visible = not layers[btnLayer1.layerNr].visible
    end
    table.insert(layersVisibleButtons, btnVisible)

    -- add frames btns
    -- for j = 1, 10 do
    --     local btn = uivi.newSquareButton(panelLayers.realX + j * 32 + 160, panelLayers.y + 28, 28, 28, j, true)
    --     btn:setAlignment("bottom-left")
    --     btn.onRelease = function()
    --         btn.checked = true
    --         btnLayer1:onRelease()
    --     end
    --     table.insert(framesButtons, btn)
    -- end
    -- close add button
    layersButtons[1].checked = true

    -- /////// FILE MENU ///////
    panelFileMenu:setAlignment("center")
    buttonFileMenuClose:setAlignment("center")
    buttonFileMenuSaveFile:setAlignment("center")
    buttonFileMenuNew:setAlignment("center")
    buttonFileMenuLoadFile:setAlignment("center")
    buttonFileMenuExportFile:setAlignment("center")
    labelFileMenuFileName:setAlignment("center")
    labelFileMenuFileName.textCentered = true

    -- /////// VIEW MENU /////////
    panelView:setAlignment("center")
    buttonViewClose:setAlignment("center")
    checkBoxToggleGrid:setAlignment("center")
    textBoxGridWidth:setAlignment("center")
    textBoxGridHeight:setAlignment("center")
    textBoxGridWidth.numericalOnly = true
    textBoxGridHeight.numericalOnly = true
    buttonToggleRepeatX:setAlignment("center")
    buttonToggleRepeatY:setAlignment("center")

    buttonToggleRepeatX.onCheckStateChanged = function()
        tileRepeatX = buttonToggleRepeatX.checked
    end

    buttonToggleRepeatY.onCheckStateChanged = function()
        tileRepeatY = buttonToggleRepeatY.checked
    end

    buttonView.onRelease = function()
        buttonFileMenuNewFileClose:onRelease()
        buttonFileMenuClose:onRelease()

        panelView.visible = true
        buttonViewClose.visible = true
        checkBoxToggleGrid.visible = true
        textBoxGridWidth.visible = true
        textBoxGridHeight.visible = true
        buttonToggleRepeatX.visible = true
        buttonToggleRepeatY.visible = true
    end

    buttonViewClose.onRelease = function()
        panelView.visible = false
        buttonViewClose.visible = false
        checkBoxToggleGrid.visible = false
        textBoxGridWidth.visible = false
        textBoxGridHeight.visible = false
        buttonToggleRepeatX.visible = false
        buttonToggleRepeatY.visible = false
    end

    textBoxGridWidth.onClickOutside = function()
        if textBoxGridWidth.text == "" then
            textBoxGridWidth.text = "16"
        end
        gridWidth = tonumber(textBoxGridWidth.text)
    end
    textBoxGridHeight.onClickOutside = function()
        if textBoxGridHeight.text == "" then
            textBoxGridHeight.text = "16"
        end
        gridHeight = tonumber(textBoxGridHeight.text)
    end

    -- /////// NEW FILE MENU //////////
    panelFileMenuNewFile:setAlignment("center")
    buttonFileMenuNewFileClose:setAlignment("center")
    buttonFileMenuNewFileWidth:setAlignment("center")
    buttonFileMenuNewFileWidth.numericalOnly = true
    labelFileMenuNewFile:setAlignment("center")
    labelFileMenuNewFile.textCentered = true
    labelFileMenuNewFileWidth:setAlignment("center")
    labelFileMenuNewFileWidth.textCentered = true
    labelFileMenuNewFileHeight:setAlignment("center")
    labelFileMenuNewFileHeight.textCentered = true
    buttonFileMenuNewFileHeight:setAlignment("center")
    buttonFileMenuNewFileHeight.numericalOnly = true
    buttonFileMenuNewFileCreate:setAlignment("center")


    panelFileMenu.onClickOutside = function()
        panelFileMenu.visible = false
        buttonFileMenuNew.visible = false
        buttonFileMenuClose.visible = false
        buttonFileMenuSaveFile.visible = false
        buttonFileMenuLoadFile.visible = false
        labelFileMenuFileName.visible = false
        buttonFileMenuExportFile.visible = false
    end


    buttonPen.onRelease = function() -- clear sprite
        currentTool = "pen"
        buttonColorPicker.checked = false
        buttonEraser.checked = false
        buttonFill.checked = false
        buttonSquareSelect.checked = false
        buttonPen.checked = true
        buttonPan.checked = false
        buttonZoom.checked = false
    end

    buttonEraser.onRelease = function()
        currentTool = "eraser"
        buttonColorPicker.checked = false
        buttonEraser.checked = true
        buttonFill.checked = false
        buttonSquareSelect.checked = false
        buttonPen.checked = false
        buttonPan.checked = false
        buttonZoom.checked = false
    end

    buttonColorPicker.onRelease = function()
        currentTool = "colorPicker"
        buttonColorPicker.checked = true
        buttonEraser.checked = false
        buttonFill.checked = false
        buttonSquareSelect.checked = false
        buttonPen.checked = false
        buttonPan.checked = false
        buttonZoom.checked = false
    end

    buttonFill.onRelease = function()
        currentTool = "fill"
        buttonColorPicker.checked = false
        buttonEraser.checked = false
        buttonFill.checked = true
        buttonSquareSelect.checked = false
        buttonPen.checked = false
        buttonPan.checked = false
        buttonZoom.checked = false
    end

    buttonPan.onRelease = function()
        currentTool = "pan"
        buttonColorPicker.checked = false
        buttonEraser.checked = false
        buttonFill.checked = false
        buttonSquareSelect.checked = false
        buttonPen.checked = false
        buttonPan.checked = true
        buttonZoom.checked = false
    end

    buttonSquareSelect.onRelease = function()
        currentTool = "squareSelect"
        buttonColorPicker.checked = false
        buttonEraser.checked = false
        buttonFill.checked = false
        buttonSquareSelect.checked = true
        buttonPen.checked = false
        buttonPan.checked = false
        buttonZoom.checked = false
    end

    buttonZoom.onRelease = function()
        currentTool = "zoom"
        buttonColorPicker.checked = false
        buttonEraser.checked = false
        buttonFill.checked = false
        buttonSquareSelect.checked = false
        buttonPen.checked = false
        buttonPan.checked = false
        buttonZoom.checked = true
    end

    buttonFile.onRelease = function()
        panelFileMenu.visible = true
        buttonFileMenuNew.visible = true
        buttonFileMenuClose.visible = true
        buttonFileMenuSaveFile.visible = true
        buttonFileMenuLoadFile.visible = true
        labelFileMenuFileName.visible = true
        buttonFileMenuExportFile.visible = true
    end

    buttonFileMenuClose.onRelease = function()
        panelFileMenu.visible = false
        buttonFileMenuNew.visible = false
        buttonFileMenuClose.visible = false
        buttonFileMenuSaveFile.visible = false
        buttonFileMenuLoadFile.visible = false
        labelFileMenuFileName.visible = false
        buttonFileMenuExportFile.visible = false
    end

    buttonFileMenuExportFile.onRelease = function()
        local image = love.image.newImageData(width, height)

        for x = 0, width - 1, 1 do
            for y = 0, height - 1, 1 do
                local r, g, b, a = layers[selectedLayer].data:getPixel(x, y)
                image:setPixel(x, y, r, g, b, a)
                
            end
        end

        local fileName = "test123Sprite"

        local fileData = image:encode("png", fileName .. ".png")
        image:release()

        local saveDir = love.filesystem.getSaveDirectory()
        local savedFile = saveDir.."/"..fileName..".png"

        print("Lua: Exported file is at: " .. savedFile)

        local osString = love.system.getOS()

        if osString == "iOS" then
            love.system.openURL("propixels/"..fileName..".png") -- save the file to ios's camera roll
            -- SHOULD DELETE IMAGE ON IOS AFTER SAVED TO CAMERA ROLL
        else
            love.system.openURL("file://"..saveDir)
        end
    end

    

    buttonFileMenuNew.onRelease = function()
        buttonFileMenuClose:onRelease()

        panelFileMenuNewFile.visible = true
        buttonFileMenuNewFileClose.visible = true
        buttonFileMenuNewFileWidth.visible = true
        labelFileMenuNewFile.visible = true
        labelFileMenuNewFileWidth.visible = true
        labelFileMenuNewFileHeight.visible = true
        buttonFileMenuNewFileHeight.visible = true
        buttonFileMenuNewFileCreate.visible = true
    end

    buttonFileMenuNewFileClose.onRelease = function()
        panelFileMenuNewFile.visible = false
        buttonFileMenuNewFileClose.visible = false
        buttonFileMenuNewFileWidth.visible = false
        labelFileMenuNewFile.visible = false
        labelFileMenuNewFileWidth.visible = false
        labelFileMenuNewFileHeight.visible = false
        buttonFileMenuNewFileHeight.visible = false
        buttonFileMenuNewFileCreate.visible = false

        buttonFile:onRelease()
    end

    buttonFileMenuNewFileCreate.onRelease = function()
        if buttonFileMenuNewFileWidth.text ~= "" and tonumber(buttonFileMenuNewFileWidth.text) ~= nil and buttonFileMenuNewFileHeight.text ~= "" and tonumber(buttonFileMenuNewFileHeight.text) ~= nil then
            buttonFileMenuNewFileClose:onRelease()
            buttonFileMenuClose:onRelease()
            
            width = tonumber(buttonFileMenuNewFileWidth.text)
            height = tonumber(buttonFileMenuNewFileHeight.text)
            buttonFileMenuNewFileWidth:setText(16)
            buttonFileMenuNewFileHeight:setText(16)

            backgroundGridCanvas:release()
            backgroundGridCanvas = nil
            backgroundGridCanvas = love.graphics.newCanvas(width, height)
            backgroundGridCanvas:renderTo(function()
                love.graphics.setColor(.7,.7,.7)
                love.graphics.rectangle("fill", 0, 0, width,height)
                
                love.graphics.setColor(.5,.5,.5)
                for x = 0, math.floor(width / backgroundGridWidth) do
                    for y = 0, math.floor(height / backgroundGridHeight) do
                        if (x + y) % 2 == 0 then
                            love.graphics.rectangle("fill", x * backgroundGridWidth, y * backgroundGridHeight, backgroundGridWidth, backgroundGridHeight)
                        else
                            love.graphics.rectangle("fill", x * backgroundGridWidth + backgroundGridWidth, y * backgroundGridHeight, backgroundGridWidth, backgroundGridHeight)
                        end
                    end
                end
                love.graphics.setColor(1,1,1)
                
            end)

            layers[selectedLayer].name = nil
            layers[selectedLayer].image:release()
            layers[selectedLayer].image = nil
            layers[selectedLayer].data:release()
            layers[selectedLayer].data = nil
            layers[selectedLayer] = nil

            layers[selectedLayer] = {}
            layers[selectedLayer].name = "layer 1"
            layers[selectedLayer].data = love.image.newImageData(width, height)
            layers[selectedLayer].image = love.graphics.newImage(layers[selectedLayer].data)
            
        end
    end

    buttonFileMenuNewFileWidth.onRelease = function()
        editingWidthButton = true
        love.keyboard.setTextInput(true)
    end

    buttonFileMenuNewFileWidth.onClickOutside = function()
        editingWidthButton = false
        love.keyboard.setTextInput(false)
    end

    buttonFileMenuNewFileHeight.onRelease = function()
        editingHeightButton = true
        love.keyboard.setTextInput(true)
    end

    buttonFileMenuNewFileHeight.onClickOutside = function()
        editingHeightButton = false
        love.keyboard.setTextInput(false)
    end

    buttonFileMenuSaveFile.onRelease = function()

        buttonFileMenuClose:onRelease()
        --save custom .pp file
        --contains animations, layers, etc
        local ppFile = love.filesystem.newFile("test.pp")
        ppFile:open("w")
        --print(pixelData[0][0].r .. " " .. pixelData[0][0].g .. " " .. pixelData[0][0].b .. " " .. pixelData[0][0].a)
        ppFile:write(width.."\n"..height.."\n")
        for i = 1, #layers do
            ppFile:write("{\n")
            ppFile:write(layers[i].name .. "\n")
            for y = 0, height - 1 do
                for x = 0, width - 1 do
                    local r, g, b, a = layers[i].data:getPixel(x, y)
                    ppFile:write(rgbToHex({r*255, g*255, b*255, a*255}))
                    if x < width -  1 then
                        ppFile:write(",")
                    end 
                end
                ppFile:write("\n")
            end
            ppFile:write("}\n")
        end

        ppFile:close()
    end

    buttonFileMenuLoadFile.onRelease = function()

        buttonFileMenuClose:onRelease()

        local oldLayersNr = #layers

        for i = #layers, 1, -1 do
            layers[i].name = nil
            layers[i].image:release()
            layers[i].image = nil
            layers[i].data:release()
            layers[i].data = nil
            layers[i] = nil
        end

        

        local ppFile = love.filesystem.read("test.pp")
        local lines = {}
        for line in love.filesystem.lines("test.pp") do
            table.insert(lines, line)
        end
        --print(lines[1])
        local loadWidth = tonumber(lines[1])
        local loadHeight = tonumber(lines[2])

        local loadLayerNr = tonumber(lines[3])

        width = loadWidth
        height = loadHeight

        backgroundGridCanvas:release()
        backgroundGridCanvas = nil

        backgroundGridCanvas = love.graphics.newCanvas(width, height)
        backgroundGridCanvas:renderTo(function()
            love.graphics.setColor(.7,.7,.7)
            love.graphics.rectangle("fill", 0, 0, width,height)
            
            love.graphics.setColor(.5,.5,.5)
            for x = 0, math.floor(width / backgroundGridWidth) do
                for y = 0, math.floor(height / backgroundGridHeight) do
                    if (x + y) % 2 == 0 then
                        love.graphics.rectangle("fill", x * backgroundGridWidth, y * backgroundGridHeight, backgroundGridWidth, backgroundGridHeight)
                    else
                        love.graphics.rectangle("fill", x * backgroundGridWidth + backgroundGridWidth, y * backgroundGridHeight, backgroundGridWidth, backgroundGridHeight)
                    end
                end
            end
            love.graphics.setColor(1,1,1)
            
        end)

        if oldLayersNr < loadLayerNr then

        end
                
        if oldLayersNr > loadLayerNr then
            for l = 1, oldLayersNr do
                table.remove(layersVisibleButtons, l)
                print(l)
            end
        end

        print("load: " .. loadLayerNr .. "    " .. "layers: " .. oldLayersNr)

        for i = 1, loadLayerNr do
            local layerName = lines[5 + (loadHeight + 3) * (i - 1)]
            layers[i] = {}
            layers[i].name = layerName
            layers[i].data = love.image.newImageData(width, height)
            layers[i].image = love.graphics.newImage(layers[i].data)

            for y = 6, 5 + (loadHeight + 3) * (i - 1) + 1 + loadHeight - 1 do
                for x = 0, loadWidth - 1 do
                    local color = 0
                    if x == 0 then
                        color = string.sub(lines[y], x * 10 + x, x * 10 + x + 10)
                    else
                        color = string.sub(lines[y], x * 10 + x + 1, x * 10 + x + 10)
                    end
                    local r, g, b, a = hex2rgb(color)

                    layers[i].data:setPixel(x, y-6, r/255, g/255, b/255, a/255)
                    layers[i].image:replacePixels(layers[i].data)
                end
            end

            

            -- -- add layer btn
            -- local btn = uivi.newCheckBox(panelLayers.realX, panelLayers.y + 28 + 38 * (i-1), 160, 28, layers[i].name, true)
            -- btn:setAlignment("bottom-left")
            -- btn.layerNr = i
            -- btn.onRelease = function()
            --     for j = 1, #layers do
            --         if btn.layerNr ~= j then
            --             layersButtons[j].checked = false
            --             btn.checked = true
            --             selectedLayer = btn.layerNr
            --         end
            --     end
            -- end
            
            -- table.insert(layersButtons, btn)
            -- local btnVisible = uivi.newSquareButton(btn.realX + 160 + 4, panelLayers.y + 28 + 38 * (i-1), 28, 28, "V", true)
            -- btnVisible:setAlignment("bottom-left")
            -- btnVisible.onRelease = function()
            --     layers[btn.layerNr].visible = not layers[btn.layerNr].visible
            -- end
            -- table.insert(buttons, btnVisible)
        end
    end

end

function scandir(directory)
    local i, t, popen = 0, {}, io.popen
    local pfile = popen('ls -a "'..directory..'"')
    for filename in pfile:lines() do
        i = i + 1
        t[i] = filename
    end
    pfile:close()
    return t
end

function string:split(sep)
    local sep, fields = sep or ":", {}
    local pattern = string.format("([^%s]+)", sep)
    self:gsub(pattern, function(c) fields[#fields+1] = c end)
    return fields
 end

function love.update(dt)
    -- print(selectedLayer)
    --handle color picker
    -- if love.mouse.isDown(1) then
    --     if math.sqrt( (buttonColor.realX - love.mouse.getX()) * (buttonColor.realX - love.mouse.getX()) + (buttonColor.realY - love.mouse.getY()) * (buttonColor.realY - love.mouse.getY())) <= buttonColor.radius then
    --         color1.r = buttonColor.returnedColor.r * 255
    --         color1.g = buttonColor.returnedColor.g * 255
    --         color1.b = buttonColor.returnedColor.b * 255
    --         color1.a = 255
    --     end
    -- end

    --modify the pixel data using the current tool
    handleCurrentTool()
end

function love.draw()
    

    camera:set()

    --draw the background
    drawBackgroundRectangle()

    --draw the image
    drawPixelData()
    drawGridLines()
    drawPenCursor()

    camera:unset()

    drawUI()

    
end

function drawPenCursor()
    if love.system.getOS() == "iOS" and love.mouse.isDown(1) == false then
        return
    end


    -- /////// DRAW CURSOR ICON ////////
    local mx, my = camera:getMousePosition()
    mx = mx + width * scale / 2
    my = my + height * scale / 2
    mx = math.floor(mx / scale - drawingRectangle.x / scale)
    my = math.floor(my / scale - drawingRectangle.y / scale)

    

    --print(mx .. " " .. my)
    
    -- pen tool
    if panelFileMenu.visible == false and panelFileMenuNewFile.visible == false then
        if (currentTool == "pen" or currentTool == "eraser") and (mx >= 0 and my >= 0 and mx < width and my < height) then

            if currentTool == "pen" then
                love.graphics.setColor(color1.r / 255, color1.g / 255, color1.b / 255, color1.a / 255)
                love.graphics.rectangle("fill", mx * scale + drawingRectangle.x - width * scale / 2, my * scale + drawingRectangle.y - height * scale / 2, scale, scale)
            end

            love.graphics.setColor(1,1,1,1)
            love.graphics.line(mx * scale  + drawingRectangle.x - width * scale / 2, my * scale + drawingRectangle.y - height * scale / 2, mx * scale + scale + drawingRectangle.x - width * scale / 2, my * scale + drawingRectangle.y - height * scale / 2)
            love.graphics.line(mx * scale + drawingRectangle.x - width * scale / 2, my * scale + scale + drawingRectangle.y - height * scale / 2, mx * scale + scale + drawingRectangle.x - width * scale / 2, my * scale + scale + drawingRectangle.y - height * scale / 2)
            love.graphics.line(mx * scale + drawingRectangle.x - width * scale / 2, my * scale + drawingRectangle.y - height * scale / 2, mx * scale + drawingRectangle.x - width * scale / 2, my * scale + scale + drawingRectangle.y - height * scale / 2)
            love.graphics.line(mx * scale + scale + drawingRectangle.x - width * scale / 2, my * scale + drawingRectangle.y - height * scale / 2, mx * scale + scale + drawingRectangle.x - width * scale / 2, my * scale + scale + drawingRectangle.y - height * scale / 2)
        end
    end
end

function loadPaletteFile(fileName)
    local colors = {}
    local info = love.filesystem.getInfo("palette1.ppalette")
    if info == nil then
        local f = love.filesystem.newFile("palette1.ppalette")
        f:open("w")
        f:write("0x472D3C\n0x5E3643\n0x7A444A\n0xA05B53\n0xBF7958\n0xEEA160\n0xF4CCA1\n0xB6D53C\n0x71AA34\n0x397B44\n0x3C5956\n0x302C2E\n0x5A5353\n0x7D7071\n0xA0938E\n0xCFC6B8\n0xDFF6F5\n0x8AEBF1\n0x28CCDF\n0x3978A8\n0x394778\n0x39314B\n0x564064\n0x8E478C\n0xCD6093\n0xFFAEB6\n0xF4B41B\n0xF47E1B\n0xE6482E\n0xA93B3B\n0x827094\n0x4F546B")
        f:close()

    end

    for line in love.filesystem.lines("palette1.ppalette") do
        table.insert(colors, line)
        --print(line)
    end

    loadPalette(colors)
end

function loadPalette(palette)
    for i = 1, #palette do
        local btn = uivi.newSquareButton(4 + 30 * math.floor((i-1) % 4), panelRight.realY + 2 + 38 * math.floor((i-1) / 4), 28, 28, "", true)
        local colR, colG, colB, colA = Hex3ToRgb(palette[i])

        btn.color.r = colR
        btn.color.g = colG
        btn.color.b = colB

        btn.onClick = function()
            color1.r = btn.color.r
            color1.g = btn.color.g
            color1.b = btn.color.b
            color1.a = 255
        end
        -- btn.color.a = colA

        table.insert(buttons, btn)
    end
end


function love.keypressed(key, scancode, isrepeat)
    local editingTextBox = false
    for i = 1, #textBoxes do
        if textBoxes[i].editingText == true then
            editingTextBox = true
            break
        end
    end
    if not editingTextBox then
        if key == 'x' then -- swap colors
            temp = color1
            color1 = color2
            color2 = temp
        end
        if key == 'e' then
            currentTool = "eraser"
        end
        if key == 'b' then
            currentTool = "pen"
        end
    else
        for i = 1, #textBoxes do
            if textBoxes[i].editingText == true then
                textBoxes[i]:checkKey(key)
                break
            end
        end
    end
    
end 

function love.mousepressed(x, y, button, istouch, presses)
    mX, mY = camera:getAbsoluteMousePosition()
    lastMouseX = mX
    lastMouseY = mY
    
    mouseX, mouseY = camera:getMousePosition()
    mouseX = mouseX + width * scale / 2
    mouseY = mouseY + height * scale / 2
    mouseX = math.floor(mouseX / scale - drawingRectangle.x / scale)
    mouseY = math.floor(mouseY / scale - drawingRectangle.y / scale)
    lastTileX = mouseX
    lastTileY = mouseY

    local checkMouseAfter = true
    
    

    for i, button in ipairs(buttons) do
        if button:isClicked(x, y, true) == true then
            button:onClick()
            checkMouseAfter = false
        elseif button:isClicked(x, y, true) == false then
            button:onClickOutside()
        end
    end

    for i, button in ipairs(layersButtons) do
        if button:isClicked(x, y, true) == true then
            button:onClick()
            checkMouseAfter = false
        elseif button:isClicked(x, y, true) == false then
            button:onClickOutside()
        end
    end
    for i, button in ipairs(layersVisibleButtons) do
        if button:isClicked(x, y, true) == true then
            button:onClick()
            checkMouseAfter = false
        elseif button:isClicked(x, y, true) == false then
            button:onClickOutside()
        end
    end
    for i, button in ipairs(framesButtons) do
        if button:isClicked(x, y, true) == true then
            button:onClick()
            checkMouseAfter = false
        elseif button:isClicked(x, y, true) == false then
            button:onClickOutside()
        end
    end
    for i, textBox in ipairs(textBoxes) do
        if textBox:isClicked(x, y, true) == true then
            textBox:onClick()
            checkMouseAfter = false
        elseif textBox:isClicked(x, y, true) == false then
            textBox:onClickOutside()
            textBox.editingText = false
        end
    end
    for i, panel in ipairs(panels) do
        if panel:isClicked(x, y, true) == true then
            panel:onClick()
            checkMouseAfter = false
        elseif panel:isClicked(x, y, true) == false then
            panel:onClickOutside()

        end
    end
    

    shouldCheckMouse = checkMouseAfter

    
    mouseX, mouseY = camera:getMousePosition()
    mouseX = mouseX + width * scale / 2
    mouseY = mouseY + height * scale / 2
    mouseX = math.floor(mouseX / scale - drawingRectangle.x / scale)
    mouseY = math.floor(mouseY / scale - drawingRectangle.y / scale)
    if tileRepeatX == true then
        if mouseX < 0 and mouseX >= -width then
            mouseX = mouseX + width
        end
        if mouseX > width - 1 and mouseX <= width - 1 + width then
            mouseX = mouseX - width 
        end
    end
    if tileRepeatY == true then
        if mouseY < 0 and mouseY >= -height then
            mouseY = mouseY + height
        end
        if mouseY > height - 1 and mouseY <= height - 1 + height then
            mouseY = mouseY - height 
        end
    end
    if currentTool == "fill" then
        
        if mouseX >= 0 and mouseX < width and mouseY >= 0 and mouseY < height and shouldCheckMouse == true then
            local r, g, b, a = layers[selectedLayer].data:getPixel(mouseX, mouseY)
            fill(mouseX, mouseY, color1.r / 255, color1.g / 255, color1.b / 255, color1.a / 255, r, g, b, a)
            layers[selectedLayer].image:replacePixels(layers[selectedLayer].data)
            -- print("recursive: " .. recursiveCount)
        end
    end
end

function love.mousereleased(x, y, button, istouch, presses)
    for i, button in ipairs(buttons) do
        if button.pressed then
            button:onRelease()
        end
        button:isClicked(x, y, false)
    end

    for i, button in ipairs(layersButtons) do
        if button.pressed then
            button:onRelease()
        end
        button:isClicked(x, y, false)
    end
    for i, button in ipairs(framesButtons) do
        if button.pressed then
            button:onRelease()
        end
        button:isClicked(x, y, false)
    end
    for i, button in ipairs(layersVisibleButtons) do
        if button.pressed then
            button:onRelease()
        end
        button:isClicked(x, y, false)
    end
    for i, textBox in ipairs(textBoxes) do
        if textBox.pressed then
            textBox:onRelease()
        end
        textBox:isClicked(x, y, false)
    end
end

function drawUI()
    for i, panel in ipairs(panels) do
        panel:draw()
    end
    -- buttonColor:setColor(color1)
    for i, button in ipairs(buttons) do
        button:draw()
    end
    for i, button in ipairs(layersButtons) do
        button:draw()
    end
    for i, button in ipairs(framesButtons) do
        button:draw()
    end
    for i, button in ipairs(layersVisibleButtons) do
        button:draw()
    end
    for i, textBox in ipairs(textBoxes) do
        textBox:draw()
    end

    for i, label in ipairs(labels) do 
        label:draw()
    end

    

end

function handleCurrentTool()

    lastMouseX = mX
    lastMouseY = mY
    mouseX, mouseY = camera:getMousePosition()
    mouseX = mouseX + width * scale / 2
    mouseY = mouseY + height * scale / 2
    mX, mY = camera:getAbsoluteMousePosition()
    mouseX = math.floor(mouseX / scale - drawingRectangle.x / scale)
    mouseY = math.floor(mouseY / scale - drawingRectangle.y / scale)
    
    local deltaX = mX - lastMouseX
    local deltaY = mY - lastMouseY

    local camX = camera.x
    local camY = camera.y

    -- print(camX .. " " .. camY)

    if love.mouse.isDown(1) and shouldCheckMouse == true then

        if currentTool == "pan" then
            -- move canvas
            camera:move(-deltaX, -deltaY)
        end
        if currentTool == "zoom" then
            scale = scale + deltaX / 4
            camera:move(deltaX*sign(camera.x), deltaX*sign(camera.y))
        end

        if scale < 1 then
            scale = 1
        end

        local startX, startY = 0, 0
        local endX, endY = width - 1, height - 1

        if tileRepeatX == true then
            if mouseX < 0 and mouseX >= -width then
                mouseX = mouseX + width
            end
            if mouseX > width - 1 and mouseX <= width - 1 + width then
                mouseX = mouseX - width 
            end
        end
        if tileRepeatY == true then
            if mouseY < 0 and mouseY >= -height then
                mouseY = mouseY + height
            end
            if mouseY > height - 1 and mouseY <= height - 1 + height then
                mouseY = mouseY - height 
            end
        end

        -- check pen line outside boundries
        if currentTool == "pen"  and panelFileMenu.visible == false and panelFileMenuNewFile.visible == false then
            if math.abs(mouseX - lastTileX) > 1 or math.abs(mouseY - lastTileY) > 1 then
                makeLine(lastTileX, lastTileY, mouseX, mouseY, {r = color1.r, g = color1.g, b = color1.b, a = color1.a})
            elseif mouseX >= 0 and mouseX < width and mouseY >= 0 and mouseY < height then
                layers[selectedLayer].data:setPixel(mouseX, mouseY, color1.r / 255, color1.g / 255, color1.b / 255, color1.a / 255)
                layers[selectedLayer].image:replacePixels(layers[selectedLayer].data)
            end
        end
        if currentTool == "eraser"  and panelFileMenu.visible == false and panelFileMenuNewFile.visible == false then
            if math.abs(mouseX - lastTileX) > 1 or math.abs(mouseY - lastTileY) > 1 then
                makeLine(lastTileX, lastTileY, mouseX, mouseY, {r = 255, g = 255 , b = 255, a = 0})
            elseif mouseX >= 0 and mouseX < width and mouseY >= 0 and mouseY < height then
                layers[selectedLayer].data:setPixel(mouseX, mouseY, 1, 1, 1, 0)
                layers[selectedLayer].image:replacePixels(layers[selectedLayer].data)
            end
        end

        if mouseX >= 0 and mouseX < width and mouseY >= 0 and mouseY < height and panelFileMenu.visible == false and panelFileMenuNewFile.visible == false then
            if currentTool == "colorPicker" then
                local r, g, b, a = layers[selectedLayer].data:getPixel(mouseX, mouseY)
                color1.r = r * 255
                color1.g = g * 255
                color1.b = b * 255
                color1.a = a * 255
                -- currentTool = "pen"
            end
            
        end
    end


    lastTileX = mouseX
    lastTileY = mouseY
end

function fill(x, y, r, g, b, a, checkR, checkG, checkB, checkA)
    local layers_1_data = layers[selectedLayer].data
    local layers_1_image = layers[selectedLayer].image

    local cr, cg, cb, ca = layers_1_data:getPixel(x, y)
    if (checkR == r and checkG == g and checkB == b and checkA == a) or (cr ~= checkR and cg ~= checkG and cb ~= checkB and ca ~= checkA) then
        return
    end

    if not (x >= 0 and x < width and y >= 0 and y < height) then
        return
    end

    layers_1_data:setPixel(x, y, r, g, b, a)
    layers_1_image:replacePixels(layers_1_data)

    local fillQueue = { {x,y} }
    local i, j = 1, 1

    while(i <= j) do

        local n = fillQueue[i]
        fillQueue[i] = nil
        i = i + 1

        if n[1]-1 >= 0 then
            local lr, lg, lb, la = layers_1_data:getPixel(n[1]-1, n[2])
            if lr == checkR and lg == checkG and lb == checkB and la == checkA then
                layers_1_data:setPixel(n[1]-1, n[2], r, g, b, a)
                
                fillQueue[ j + 1 ] = {n[1]-1, n[2]}
                j = j + 1
            end
        end
        if n[1]+1 < width then
            local lr, lg, lb, la = layers_1_data:getPixel(n[1]+1, n[2])
            if lr == checkR and lg == checkG and lb == checkB and la == checkA then
                layers_1_data:setPixel(n[1]+1, n[2], r, g, b, a)
                
                fillQueue[ j + 1 ] = {n[1]+1, n[2]}
                j = j + 1
            end
        end
        if n[2]-1 >= 0 then
            local lr, lg, lb, la = layers_1_data:getPixel(n[1], n[2]-1)
            if lr == checkR and lg == checkG and lb == checkB and la == checkA then
                layers_1_data:setPixel(n[1], n[2]-1, r, g, b, a)
                
                fillQueue[ j + 1] = {n[1], n[2]-1}
                j = j + 1
            end
        end
        if n[2]+1 < height then
            local lr, lg, lb, la = layers_1_data:getPixel(n[1], n[2]+1)
            if lr == checkR and lg == checkG and lb == checkB and la == checkA then
                layers_1_data:setPixel(n[1], n[2]+1, r, g, b, a)
                
                fillQueue[ j + 1] = {n[1], n[2]+1}
                j = j + 1
            end
        end
    end
    layers_1_image:replacePixels(layers_1_data)
end

function makeLine(x1, y1, x2, y2, color)
    local dx = math.abs(x2 - x1)
    local dy = math.abs(y2 - y1) * -1

    local sx = x1 < x2 and 1 or -1
    local sy = y1 < y2 and 1 or -1
    local error = dx + dy

    local i = 0

    while true do
        if x1 >= 0 and x1 < width and y1 >= 0 and y1 < height then
            layers[selectedLayer].data:setPixel(x1, y1, color.r / 255, color.g / 255, color.b / 255, color.a / 255)
            print(x1 .. " " .. y1)
        end

        i = i + 1

        if x1 == x2 and y1 == y2 then
            layers[selectedLayer].image:replacePixels(layers[selectedLayer].data)
            return true, i
        end

        local tempError = 2 * error
        if tempError > dy then
            error = error + dy
            x1 = x1 + sx
        end
        if tempError < dx then
            error = error + dx
            y1 = y1 + sy
        end
    end
end

function drawPixelData()
    local camX1 = math.floor(camera.x/scale - drawingRectangle.x / scale + width / 2)
    local camY1 = math.floor(camera.y/scale - drawingRectangle.y / scale + height / 2)
    local camX2 = math.floor(camera.x/scale - drawingRectangle.x / scale - width / 2 + love.graphics.getWidth() / scale)
    local camY2 = math.floor(camera.y/scale - drawingRectangle.y / scale - height / 2 + love.graphics.getHeight() / scale)
    -- print(math.max(0, camX1) .. " " .. width - 1 + math.min(0, camX2))
    -- for x = math.max(0, camX1), width - 1 + math.min(0, camX2), 1 do
    --     for y = math.max(0, camY1), height-1 + math.min(0, camY2), 1 do
    --         local r, g, b, a = layers[selectedLayer].data:getPixel(x, y)
    --         local drawX = drawingRectangle.x + x * scale - width * scale / 2
    --         local drawY = drawingRectangle.y + y * scale - height * scale / 2
    --         if drawX >= camera.x and drawY >= camera.y and drawX < camera.x + love.graphics.getWidth() and drawY < camera.y + love.graphics.getHeight() then
    --             love.graphics.setColor(r, g, b, a)
    --             love.graphics.rectangle("fill", drawingRectangle.x + x * scale - width * scale / 2, drawingRectangle.y + y * scale - height * scale / 2, scale, scale)
    --         end
    --     end
    -- end
    for i = #layers, 1, -1 do
        if layers[i].visible == true then
            if tileRepeatX == true and tileRepeatY == true then
                for x = -1, 1 do 
                    for y = -1, 1 do
                        love.graphics.draw(layers[i].image, drawingRectangle.x - width * scale / 2 + x * width * scale, drawingRectangle.y - height * scale / 2 + y * scale * width, 0, scale, scale)
                    end
                end
            elseif tileRepeatX == true then
                for x = -1, 1 do 
                    love.graphics.draw(layers[i].image, drawingRectangle.x - width * scale / 2 + x * width * scale, drawingRectangle.y - height * scale / 2, 0, scale, scale)
                end
            elseif tileRepeatY == true then
                for y = -1, 1 do
                    love.graphics.draw(layers[i].image, drawingRectangle.x - width * scale / 2, drawingRectangle.y - height * scale / 2 + y * scale * width, 0, scale, scale)
                end
            else
                love.graphics.draw(layers[i].image, drawingRectangle.x - width * scale / 2, drawingRectangle.y - height * scale / 2, 0, scale, scale)
            end
        end

    end
    love.graphics.setColor(1,1,1,1)
end

function drawGridLines()
    if checkBoxToggleGrid.checked == true then
        love.graphics.setColor(0,1,1,1)
        local camX1 = math.floor((camera.x/scale - drawingRectangle.x / scale + width / 2) / gridWidth)
        local camY1 = math.floor((camera.y/scale - drawingRectangle.y / scale + height / 2) / gridHeight)
        local camX2 = math.floor((camera.x/scale - drawingRectangle.x / scale - width / 2 + love.graphics.getWidth() / scale) / gridWidth)
        local camY2 = math.floor((camera.y/scale - drawingRectangle.y / scale - height / 2 + love.graphics.getHeight() / scale) / gridHeight)
        for x = math.max(0, camX1), math.floor(width / gridWidth) - 1 + math.min(0, camX2), 1 do
            local drawX = drawingRectangle.x + x * scale * gridWidth - width * scale / 2
            love.graphics.line(drawX, drawingRectangle.y - height * scale / 2, drawX, drawingRectangle.y + height * scale / 2)
        end
        for y = math.max(0, camY1), math.floor(height / gridHeight)-1 + math.min(0, camY2), 1 do
            local drawY = drawingRectangle.y + y * scale * gridHeight - height * scale / 2
            love.graphics.line(drawingRectangle.x - width * scale / 2, drawY, drawingRectangle.x + width * scale / 2, drawY)
        end
        love.graphics.setColor(1,1,1,1)
    end
end

function drawBackgroundRectangle()

    -- love.graphics.setColor(.5, .5, .5)
    -- love.graphics.rectangle("fill", drawingRectangle.x - width * scale / 2, drawingRectangle.y - height * scale / 2, width * scale, height * scale)
    -- love.graphics.setColor(.7, .7, .7)
    -- local camX1 = math.floor(camera.x/scale - drawingRectangle.x / scale + width / 2)
    -- local camY1 = math.floor(camera.y/scale - drawingRectangle.y / scale + height / 2)
    -- local camX2 = math.floor(camera.x/scale - drawingRectangle.x / scale - width / 2 + love.graphics.getWidth() / scale)
    -- local camY2 = math.floor(camera.y/scale - drawingRectangle.y / scale - height / 2 + love.graphics.getHeight() / scale)
    -- for x = math.max(0, camX1), width - 1 + math.min(0, camX2), 1 do
    --     for y = math.max(0, camY1), height-1 + math.min(0, camY2), 1 do
    --         if (y % 2 == 0 and x % 2 ~= 0) or (y % 2 ~= 0 and x % 2 == 0) then
    --             local drawX = drawingRectangle.x + x * scale - width * scale / 2
    --             local drawY = drawingRectangle.y + y * scale - height * scale / 2
    --             if drawX >= camera.x and drawY >= camera.y and drawX < camera.x + love.graphics.getWidth() and drawY < camera.y + love.graphics.getHeight() then
    --                 love.graphics.rectangle("fill", drawX, drawY, scale, scale)
                
    --             end
    --         end
    --     end
    -- end

    love.graphics.draw(backgroundGridCanvas, drawingRectangle.x - width * scale / 2, drawingRectangle.y - height * scale / 2, 0, scale, scale)

    love.graphics.setColor(1,1,1)
    love.graphics.setLineStyle("rough")
    love.graphics.setLineWidth(1)
    love.graphics.line(drawingRectangle.x - width * scale / 2, drawingRectangle.y - height * scale / 2, drawingRectangle.x + width * scale - width * scale / 2, drawingRectangle.y - height * scale / 2)
    love.graphics.line(drawingRectangle.x - width * scale / 2, drawingRectangle.y + height * scale + 1 - height * scale / 2, drawingRectangle.x + width * scale - width * scale / 2, drawingRectangle.y + height * scale + 1 - height * scale / 2)
    love.graphics.line(drawingRectangle.x - width * scale / 2, drawingRectangle.y - 1 - height * scale / 2, drawingRectangle.x - width * scale / 2, drawingRectangle.y + height * scale + 1 - height * scale / 2)
    love.graphics.line(drawingRectangle.x - width * scale / 2 + width * scale + 1, drawingRectangle.y - 1 - height * scale / 2, drawingRectangle.x + width * scale + 1 - width * scale / 2, drawingRectangle.y + height  * scale + 1 - height * scale / 2)
end

function love.quit()
    for i = 1, #layers do
        layers[i].data:release()
    end
end