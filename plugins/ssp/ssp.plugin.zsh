# See also:
# http://stackoverflow.com/a/626574
# http://superuser.com/a/163228
function ssp() {
  env TERM="$(pwd):$TERM" \
    ssh -t "$@" 'cd "${TERM%:*}" && TERM="${TERM##*:}" && $SHELL -l'
}

