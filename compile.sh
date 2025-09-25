#!/usr/bin/env bash
for arg in "$@"; do
  case "${arg%=*}" in
    -i | --input)
      file_input="${arg#*=}"
      ;;
    -o | --output)
      file_output="${arg#*=}"
      ;;
  esac
done

if [ -z "$file_input" ]; then
  file_input_default="$(find . -iregex '.*main\.typ$' 2>/dev/null | head -n 1)"

  if [ -z "$file_input_default" ]; then
    file_input_default="$(find . -iregex '.*\.typ$' 2>/dev/null | head -n 1)"
  fi
  read -e -p "File: " -i "$file_input_default" file_input
fi

if ! echo "$file_input" | grep -E '\.typ$' >/dev/null 2>&1 && ! [ -f "$file_input" ]; then
  if [ ! -f "$file_input" ]; then
    echo "Error: Input file '$file_input' not found."
    exit 1
  fi

  case "$file_input" in
    *.typ | *.TYP)
      # Valid extension, continue
      ;;
    *)
      echo "Error: Input file '$file_input' must have a .typ extension."
      exit 1
      ;;
  esac
fi

if [ -z "$file_output" ]; then
  read -e -p "Output File: " -i "$(basename $file_input .typ).pdf" file_output
fi

while true; do
  case $file_output in
    *.html)
      watchexec -c clear -w src "typst compile \"${file_input}\" \"${file_output}\"" --features html
      break
      ;;
    *.pdf | *.png | *.svg)
      watchexec -c clear -w src "typst compile \"${file_input}\" \"${file_output}\""
      break
      ;;
    *)
      echo -e "\n"
      echo "Output file has no valid extension. Please choose one of the following:"
      echo "Possible values: [pdf, png, svg, html]"

      read -N 4 -p "Enter extension (pdf, png, svg, html): " -i "pdf" file_extension

      if ! [ -z file_extension ]; then
        file_extension="$(echo $file_extension | tr -d '\t\n\r')"

        watchexec -c clear -w src "typst compile \"${file_input}\" \"${file_output}.${file_extension}\"" -f $file_extension
        break
      fi
  esac
done

