# Function to show help message
show_help() {
    echo
    echo "Usage: $0 [OPTIONS] SEARCH_STRING FILENAME"
    echo
    echo "Options:"
    echo "  -n         Show line numbers"
    echo "  -v         Invert match (show non-matching lines)"
    echo "  -nv | -vn  Show line numbers AND invert match"
    echo "  --help     Show this help message"
    echo
    echo "Examples:"
    echo "  $0 \"hello\" testfile.txt"
    echo "  $0 -n \"hello\" testfile.txt"
    echo "  $0 -v \"hello\" testfile.txt"
    echo "  $0 -nv \"hello\" testfile.txt"
    echo
}

# Initialize options
show_numbers=0
invert_match=0

# Parse options
while [[ "$1" =~ ^- ]]; do
    case "$1" in
        -n)
            show_numbers=1
            ;;
        -v)
            invert_match=1
            ;;
        -nv|-vn)
            show_numbers=1
            invert_match=1
            ;;
        --help)
            show_help
            exit 0
            ;;
        *)
            echo "Error: Unknown option '$1'"
            show_help
            exit 1
            ;;
    esac
    shift
done

# Check for required arguments
if [[ -z "$1" || -z "$2" ]]; then
    echo "Error: Missing search string or filename"
    show_help
    exit 1
fi

search_string="$1"
filename="$2"

# Check if file exists
if [[ ! -f "$filename" ]]; then
    echo "Error: File '$filename' not found"
    exit 1
fi

# Read file line by line
line_num=0
while IFS= read -r line; do
    ((line_num++))
    echo "$line" | grep -i -q "$search_string"
    match=$?

    if [[ $invert_match -eq 0 && $match -eq 0 ]] || [[ $invert_match -eq 1 && $match -ne 0 ]]; then
        if [[ $show_numbers -eq 1 ]]; then
            echo "${line_num}:$line"
        else
            echo "$line"
        fi
    fi
done < "$filename"
