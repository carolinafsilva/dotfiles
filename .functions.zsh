cdf() {
  target=$(osascript -e \
    "tell application \"Finder\" to \
     if (count of Finder windows) > 0 then \
     get POSIX path of (target of front Finder window as text)")
  [[ -n "${target}" ]] && {
    cd "${target}"
    return 0
  } || {
    echo "${0}: No finder window found"
    return 1
  }
}
