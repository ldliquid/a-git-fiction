#!/bin/sh

function exportGitGraph(){

  touch gitlog.txt
  chmod 755 gitlog.txt
  git log \
    --graph \
    --date-order \
    --full-history \
    --simplify-merges \
    --decorate=no \
    --format=format:'<spanclass="subject">%s</span>%n''<spanclass="date">%ai</span>%n''<spanclass="author">%an</span>%n''<spanclass="hash">%T</span>%n''<spanclass="body">%b</span>%n' \
    --all  > gitlog.txt

    #'<spanclass="body">%b</span>%n'
    #  --no-merges --dense
    #--abbrev-commit \
    # -p -999 \
    # --full-diff \
    # --branches=dev\

  sed -i "s/<.*@.*>//g" gitlog.txt
  sed -i 's/|/<spanclass="line">|<\/span>/g' gitlog.txt # how to catch also "/" and "\"
  sed -i 's/\\/<spanclass="line">\\<\/span>/g' gitlog.txt # how to catch also "/" and "\"
  sed -i 's/\/\s/<spanclass="line">\/<\/span> /g' gitlog.txt # how to catch also "/" and "\"
  sed -i 's/\s/\&nbsp;/g' gitlog.txt #convert white space to &nbsp;
  sed -i 's/spanclass/span class/g' gitlog.txt # convert 'spanclass' to 'span class'
  sed -i 's/divclass/div class/g' gitlog.txt # convert 'spanclass' to 'span class'
  sed -i ':a;N;$!ba;s/\n/<br>\n/g' gitlog.txt # convert newline to br ł http://stackoverflow.com/questions/1251999/sed-how-can-i-replace-a-newline-n
  sed -i 's/\*/<span class="node">o<\/span>/g' gitlog.txt  # convert * to span node

  # diff = grep '<span class=""></span>'

  gitlog=`cat gitlog.txt`
  html_body+='<section id="gitlog">
  <div class="inner">
  '"$gitlog"'
  </div>
  </section>';
  rm gitlog.txt
}


html_index_files=`cat ./templates/header.tpl.html`

html_body='<body>
';

exportGitGraph

html_body+='</body>
';

html_index_files+="$html_body"
html_index_files+=`cat ./templates/footer.tpl.html`

echo "$html_index_files" > ./index.html
