
# 1. Check that no silly logging remains
# 2. Check tests are going throuch and that they are all enabled
# 3. Load web.html, seq.html

# file:///Users/knut/Documents/source/mermaid/test/web.html
# file:///Users/knut/Documents/source/mermaid/test/seq.html

# 4. Generate a diagram with the cli

#node bin/mermaid.js -c ./test/sconf.json ./test/seq.mermaid
#node bin/mermaid.js ./test/seq.mermaid
#node bin/mermaid.js ./test/flow.mermaid
#node bin/mermaid.js ./test/gant.mmd

# Updates the version number
gulp patch

# Creates new compiled distributables
gulp dist

# Commit the updated version and the distributables
git commit . -m "New release"

# Push the changes to the repository
git push origin master

# Tag the release
git tag  `node -e "var p = require('./package.json');console.log(p.version);"`

# Push the tag
git push --tags

# Publish on npm
npm publish

# Done!!!