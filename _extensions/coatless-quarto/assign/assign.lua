-- Vendored from ucdavis/epi204 (vignettes/_extensions/coatless-quarto/assign/assign.lua);
-- epi204's fork of coatless-quarto/assign. The fork wraps `.sol` content
-- in a foldable `quarto.Callout` so solutions render as collapsible blocks
-- in html/revealjs/pdf/latex. Upstream credit: coatless-quarto/assign.

local function in_callout_output()
  if quarto and quarto.doc and quarto.doc.is_format then
    return quarto.doc.is_format("html")
      or quarto.doc.is_format("revealjs")
      or quarto.doc.is_format("pdf")
      or quarto.doc.is_format("latex")
  end

  return false
end

local function solution_callout(div)
  return pandoc.Div({
    quarto.Callout({
      type = "solution",
      appearance = "default",
      collapse = true,
      icon = false,
      title = pandoc.Inlines("Solution"),
      content = div.content
    })
  })
end

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
    if in_callout_output() then
      div = solution_callout(div)
    else
      -- Wrap the "Solution." Emph in a Para so we insert a Block, not
      -- an Inline, into div.content (which holds Blocks). Some Pandoc
      -- versions error on the bare-Inline form.
      local sol_label = pandoc.Para{pandoc.Emph{pandoc.Str("Solution.")}}
      table.insert(div.content, 1, sol_label)
    end
  end

  -- Return the modified ConditionalBlock
  return quarto.ConditionalBlock({
    node = div, -- this is the div containing your content
    behavior = behavior,
    condition = condition
  })
end
