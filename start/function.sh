fpath=($MYZSH_DIR/functions $fpath)
for func in $MYZSH_DIR/functions/*(.:t); do
    autoload -Uz $func
done