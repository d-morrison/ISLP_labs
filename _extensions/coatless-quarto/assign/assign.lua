-- Reformat all Div content
function Div(div)

  if not (div.classes:includes("sol") or div.classes:includes("rubric") or div.classes:includes("direction") ) then
    return nil
  end

  local behavior = "content-visible" -- or "content-hidden", as necessary

  -- Directly translate shortcode class to the full profile
  local value_condition = {}
  if div.classes:includes("sol") then
    value_condition = {"when-profile", "solution"}
  elseif div.classes:includes("rubric") then
    value_condition = {"when-profile", "rubric"}
  elseif div.classes:includes("direction") then
    value_condition = {"when-profile", "assign"}
  end

  -- Register the condition
  local condition = {
    value_condition
  }

  -- Add additional condition related to a project profile.
  if div.classes:includes("sol") and quarto.project.profile:includes("rubric") then
    table.insert(condition, {"when-profile", "rubric"})
  end

  if div.classes:includes("sol") then
    -- Insert "Solution." label as its own Para. div.content holds Block
    -- elements, so an Inline (Emph) must be wrapped in a Para to be valid
    -- Pandoc AST; some Pandoc versions error otherwise.
    local sol_label = pandoc.Para{pandoc.Emph{pandoc.Str("Solution.")}}
    table.insert(div.content, 1, sol_label)
  end

  -- Return the modified ConditionalBlock
  return quarto.ConditionalBlock({
    node = div, -- this is the div containing your content
    behavior = behavior,
    condition = condition
  })
end
