#!/bin/sh
# Creates a landing page at _site/index.html with side-by-side buttons
# linking to the student worksheet (_site/assign/) and the solution key
# (_site/solution/) — the two Quarto profile renders produced by
# publish.yml.
set -eu

cat > _site/index.html << 'HTMLEOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>ISLP Labs</title>
  <style>
    body { font-family: sans-serif; max-width: 640px; margin: 6em auto; text-align: center; color: #333; padding: 0 1em; }
    h1 { font-size: 2em; margin-bottom: 0.25em; }
    p { color: #666; margin-bottom: 2em; }
    .btn-group { display: flex; justify-content: center; gap: 1.5em; flex-wrap: wrap; }
    a.btn { display: inline-block; padding: 1em 2.5em; background: #0066cc; color: white;
            text-decoration: none; border-radius: 8px; font-size: 1.1em; font-weight: bold;
            transition: background 0.2s; }
    a.btn:hover { background: #0052a3; }
    a.btn.secondary { background: #6c757d; }
    a.btn.secondary:hover { background: #5a6268; }
    footer { margin-top: 4em; font-size: 0.85em; color: #999; }
    footer a { color: #999; }
  </style>
</head>
<body>
  <h1>ISLP Labs</h1>
  <p>Quarto handouts for the <em>Introduction to Statistical Learning with Applications in Python</em> labs.</p>
  <div class="btn-group">
    <a class="btn" href="assign/">Student Worksheet</a>
    <a class="btn secondary" href="solution/">Solution Key</a>
  </div>
  <footer>
    Lab content adapted from <a href="https://www.statlearning.com">statlearning.com</a>.
  </footer>
</body>
</html>
HTMLEOF
