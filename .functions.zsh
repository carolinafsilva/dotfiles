chpwd() {
  echo
  ls
  echo
}

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

github() {
    help () {
    echo "usage: $1 [ -i gitignore ] [ -l license ]"
    echo
    echo "  --help          - Show this help menu"
    echo
    echo "  --gitignores    - Show available gitignores"
    echo "  --licenses      - Show available licenses"
    echo
    echo "  -i <gitignore>  - Specify gitignore"
    echo "  -l <license>    - Specify license"
  }

  gitignores () {
    curl -sfL "https://api.github.com/gitignore/templates" |\
    jq --raw-output ".[]"
  }

  licenses () {
    curl -sfL "https://api.github.com/licenses" |\
    jq --raw-output ".[].key"
  }

  while getopts ":i:l:-:" option; do
    case "${option}" in
      "i")
        gitignore="${OPTARG}"
        ;;
      "l")
        license="${OPTARG}"
        ;;
      "-")
        case "${OPTARG}" in
          "help")
            help $0
            return 0
          ;;
          "gitignores")
            gitignores
            return 0
          ;;
          "licenses")
            licenses
            return 0
          ;;
          *)
          echo "$0: Invalid option or missing argument: --${OPTARG}"
          help $0
          return 1
          ;;
        esac
        ;;
      *)
        echo "$0: Invalid option or missing argument: -${OPTARG}"
        help $0
        return 1
        ;;
    esac
  done

  [[ $(git rev-parse --git-dir 2>/dev/null) ]] && {
    echo "$0: Already in a git repository"
    return 1
  }

  [[ -n ${gitignore} ]] && {
    curl -sfL "https://api.github.com/gitignore/templates/${gitignore}" |\
    jq --raw-output ".source" >> .gitignore
    [[ ! -s .gitignore ]] && {
      echo "$0: Invalid .gitignore: ${gitignore}"
      help $0
      rm .gitignore
      return 1
    }
  }

  [[ -n ${license} ]]  && {
    curl -sfL "https://api.github.com/licenses/${license}" |\
    jq --raw-output ".body"  > LICENSE
    [[ ! -s LICENSE ]] && {
      echo "$0: Invalid license: ${license}"
      help $0
      rm LICENSE
      return 1
    }
    sed -i "" \
    "s/\[year\]/$(date +"%Y")/g;s/\[fullname\]/$(git config user.name)/g" \
    LICENSE
  }

  if [[ ! -f "README.md" ]]; then
    echo "# $(basename $(pwd))" > README.md
    if [[ -f "LICENSE" ]]; then
      echo >> README.md
      echo "This project is licensed under the ${license} License - see the [LICENSE](LICENSE) file for details" >> README.md
    fi
  fi

  git init

  git add .
  git commit -m 'Initial commit'

  gh repo create

  git push -u origin master
}
