#!/bin/sh

function exportGitGraph(){

  touch gitlog.txt
  chmod 755 gitlog.txt
  git log --graph --abbrev-commit --date-order --full-history --simplify-merges --decorate=no --format=format:'<spanclass="date">%ai</span>%n''<spanclass="author">%an</span>%n''%B<spanclass="hash">%T</span>%n' --all  > gitlog.txt
  #  --no-merges --dense


  sed -i "s/<.*@.*>//g" gitlog.txt
  sed -i 's/\s/\&nbsp;/g' gitlog.txt
  sed -i 's/spanclass/span class/g' gitlog.txt
  sed -i ':a;N;$!ba;s/\n/<br>/g' gitlog.txt # http://stackoverflow.com/questions/1251999/sed-how-can-i-replace-a-newline-n
  sed -i 's/\*/<span class="node">o<\/span>/g' gitlog.txt
  # sed -i 's/|/<span class="line">|<\/span>/g' gitlog.txt # how to catch also "/" and "\"


  gitlog=`cat gitlog.txt`
  html_body+="<section id='gitlog'><div class='inner'>$gitlog</div></section>"
  rm gitlog.txt
}


html_index_files=`cat ./templates/header.tpl.html`

html_body="<body>"

exportGitGraph

html_body+="</body>"

html_index_files+="$html_body"
html_index_files+=`cat ./templates/footer.tpl.html`

echo "$html_index_files" > ./index.html
