# Name: Tay How Yang Gilbert 
# Student ID: 10512374
#!/bin/bash

# function to obtain the properties of the file
getprop () {

    local word_count=0 # local variable 'word_count' to store the number of words in the text
    
    # A html file can be used to display text but it contains html tags which need to be removed before any counting of words can be done
    # A if control structure to test whether the file passed to the function is a html file
    # Need to remove the "title" tag and its contents since its contents shouldn't appear in the main text
    # Need to remove all html tags to enable an aacurate count of the words in the text
    if [[ $1 = *.html ]]; then
        word_count=$(sed -e 's%<title>.\+</title>%%g' -e 's/<[^>]\+>/ /g' "$1" | wc -w | awk '{ print $1 }') # html tags are removed via sed. Result of sed is passed to wc which counts the number of words. Obtains the number of words that is stored in the 1st field of wc through awk
    else # Non html files are sent to the else block
        word_count=$(wc -w "$1" | awk '{ print $1 }') # counts the number of words through wc. Obtains the number of words that is stored in the 1st field of wc through awk
    fi
        
    local file_size=$(du -b "$1" | awk '{ size=$1/1024; printf "%.3f", size }') # gets the size of the file through du. Formats the value to 3 decimal places via awk 
    local date=$(date -r "$1" +"%d-%m-%Y %H:%M:%S") # obtains the date and time the file was last modified and formatted in the form dd-mm-yy hh-mm-ss. Time is in 24 hour format  

    echo -n "The file "$1" contains $word_count words and is $file_size" # prints the word count and file size while suppressing the newline
    echo "KB in size and was last modified $date." # Continues the previous line. Prints the date and time the file was last modified
}

read -p "Enter a file name to check: " input # prompts user to enter a file name and stores the value in the variable 'input'
getprop "$input" # calls the function 'getprop' and passes the value inside the variable 'input' to the function
exit 0