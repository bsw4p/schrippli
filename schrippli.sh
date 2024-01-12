#!/bin/bash

# Check if a folder path is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <source_code_folder>"
    exit 1
fi

SOURCE_FOLDER=$1

# Define function to run weggli and print results
run_weggli() {
    local pattern=$1
    local description=$2

    local result=$(weggli "$pattern" "$SOURCE_FOLDER")

    if [ -z "$result" ]; then
        # No results found, print in green
        echo -e "\e[32m[-] $description: No issues found.\e[0m"
    else
        # Results found, print in red
        echo -e "\e[31m[!] $description: Issues found:\e[0m"
        echo "$result"
    fi
}

declare -A patterns=(
    ["{strncat(_,_,sizeof(_));}"]="incorrect use of strncat (CWE-193, CWE-787)"
    ["{strncat(_,_,strlen(_));}"]="incorrect use of strncat (CWE-193, CWE-787)"
    ["{strncat(\$dst,\$src,sizeof(\$dst)-strlen(\$dst));}"]="incorrect use of strncat (CWE-193, CWE-787)"
    ["{_ \$buf[\$len]; strncat(\$buf,_,\$len);}"]="incorrect use of strncat (CWE-193, CWE-787)"
    ["{\$func(_,\$src,_(\$src));}"]="destination buffer access using size of source buffer (CWE-806)"
    ["{\$len=_(\$src); \$func(_,\$src,\$len);}"]="destination buffer access using size of source buffer (CWE-806)"
    ["{_ \$src[\$len]; \$func(\$dst,\$src,\$len);}"]="destination buffer access using size of source buffer (CWE-806)"
    ["{_* \$ptr; sizeof(\$ptr);}"]="use of sizeof() on a pointer type (CWE-467)"
    ["{_* \$ptr=_; sizeof(\$ptr);}"]="use of sizeof() on a pointer type (CWE-467)"
    ["{_ \$func(_* \$ptr) {sizeof(\$ptr);}}"]="use of sizeof() on a pointer type (CWE-467)"
    ["{sizeof('_');}"]="use of sizeof() on a character constant"
    ["{\$func(\$buf,_); not:\$buf[_]=_;}"]="lack of explicit NUL-termination after strncpy(), etc. (CWE-170)"
    ["{\$buf[sizeof(\$buf)];}"]="off-by-one error (CWE-193)"
    ["{_ \$buf[\$len]; \$buf[\$len]=_;}"]="off-by-one error (CWE-193)"
    ["{strlen(\$src)>sizeof(\$dst);}"]="off-by-one error (CWE-193)"
    # ... additional patterns ...
)


# Run each pattern
for pattern in "${!patterns[@]}"; do
    run_weggli "$pattern" "${patterns[$pattern]}"
done
