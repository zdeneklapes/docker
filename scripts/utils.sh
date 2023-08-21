function clean() {
    # Clean project
    ${RM} *.zip
    # Folders
    for folder in "venv" "__pycache__" ".ruff_cache" ".pytest_cache" ".cache"; do
        find . -type d -iname "${folder}" | xargs ${RM}
    done
    # Files
    for file in ".DS_Store" "tags" "db.sqlite3" "*.png" "*.zip" "*.log"; do
        find . -type f -iname "${file}" | xargs ${RM}
    done
}

function tags() {
    # Create tags and cscope
    ctags -R .
    cscope -Rb
}

function help() {
    # Print usage on stdout
    echo "Available functions:"
    for file in ./scripts/*.sh; do
        function_names=$(cat ${file} | grep -E "(\ *)function\ +.*\(\)\ *\{" | sed -E "s/\ *function\ +//" | sed -E "s/\ *\(\)\ *\{\ *//")
        for func_name in ${function_names[@]}; do
            printf "    $func_name\n"
            awk "/function ${func_name}()/ { flag = 1 }; flag && /^\ +#/ { print \"        \" \$0 }; flag && !/^\ +#/ && !/function ${func_name}()/  { print "\n"; exit }" ${file}
        done
    done

}

function usage() {
    # Print usage on stdout
    help
}

function die() {
    # Print error message on stdout and exit
    printf "${RED}ERROR: $1${NC}\n"
    help
    exit 1
}

function main() {
    # Main function: Call other functions based on input arguments
    [[ "$#" -eq 0 ]] && die "No arguments provided"
    while [ "$#" -gt 0 ]; do
        case "$1" in
        *) "$1" || die "Unknown function: $1()" ;;
        esac
        shift
    done
}

main "$@"
