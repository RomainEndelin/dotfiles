#!/bin/bash

declare PDF_DIR="/home/kilik/buffer"

declare DOCUMENT_NAME=
declare MODE=
declare TIFF_FILE=
declare PDF_FILE=

getDocumentName() {
    TEMPFILE=`tempfile 2>/dev/null` || TEMPFILE=/tmp/test$$
    trap "rm -f $TEMPFILE" 0 1 2 5 15
    dialog --title "Document title" --clear \
        --inputbox "Enter document name:" 16 51 2> $TEMPFILE

    valret=$?

    case $valret in
        0)
            DOCUMENT_NAME=`cat $TEMPFILE`;;
        1)
            exit 1;;
        255)
            exit 1;;
    esac
}

getMode() {
    TEMPFILE=`tempfile 2>/dev/null` || TEMPFILE=/tmp/test$$
    trap "rm -f $TEMPFILE" 0 1 2 5 15

    dialog --backtitle "Select mode" \
        --title "Select mode" --clear \
        --radiolist "Select the mode :" 20 61 5 \
        "Lineart" "Lineart" ON\
        "Gray" "Gray" off\
        "Color" "Color" off 2> $TEMPFILE
    valret=$?
    case $valret in
        0)
            MODE=`cat $TEMPFILE`;;
        1)
            exit 1;;
        255)
            exit 1;;
    esac
}

scan() {
    echo "Scanning document"
    TEMPFILE=`tempfile 2>/dev/null` || TEMPFILE=/tmp/test$$
    TEMPFILE=${TEMPFILE}.tiff
    trap "rm -f $TEMPFILE" 0 1 2 5 15

    scanimage --progress --format tiff --mode $MODE \
        --resolution 300 \
        -l 0 -t 0 -x 210mm -y 297mm \
        > ${TEMPFILE}
    TIFF_FILE=${TEMPFILE}
}

saveToPdf() {
    PDF_FILE="${PDF_DIR}/${DOCUMENT_NAME} `date +%m-%d-%y`.pdf"
    echo "Saving document to ${PDF_FILE}"
    tiff2pdf -p A4 -o "${PDF_FILE}" "$TIFF_FILE"
}

print() {
    echo "Printing document"
    tiff2ps -z -w 8.27 -h 11.69 "$TIFF_FILE" | lpr
}

getDocumentName
getMode
scan
saveToPdf
print
