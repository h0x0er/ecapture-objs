#!/bin/bash


log(){
    printf "[$(date)] [$1] $2\n"
}

# $1=symbol $2=folder
get-matches(){
    local matches=$(grep "$1" -R "$2" -l)
    echo $matches
}

# $1=target_symbol
# $2=replacement_symbol
# $3=file1.go file2.go
patch-symbol(){
    for f in $3; do
        sed -si --quiet "s/$1/$2/g" $f
    done
}

openssl(){

    local symbol="detectOpenssl"
    local replace_to="DetectOpenssl"
    local matches=$(get-matches $symbol "user")

    log "patch-openssl" "$matches"

    patch-symbol "$symbol" "$replace_to" "$matches"

}


# run cmd
$1

# 
#  patch-symbol "detectOpenssl" "DetectOpenssl" "user/module/probe_openssl.go user/module/probe_openssl_lib.go"