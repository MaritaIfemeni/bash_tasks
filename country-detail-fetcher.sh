#!/bin/bash
print_usage() {
    echo "Usage: $0 [country1] [country2] [country3] ..."
    echo "Example: $0 Vietnam Finland"
}

if [ $# -lt 1 ]; then
    echo "Error: Missing country name."
    print_usage
    exit 1
fi

for country_name in "$@"; do
    country_info=$(curl -s "https://restcountries.com/v3.1/name/$country_name")

    if [ "$(echo "$country_info" | jq 'length')" -gt 0 ]; then
        name=$(echo "$country_info" | jq -r '.[0].name.common')
        capital=$(echo "$country_info" | jq -r '.[0].capital[0]')
        population=$(echo "$country_info" | jq -r '.[0].population')
        languages=$(echo "$country_info" | jq -r '.[0].languages | to_entries | map(.value) | join(", ")')

        echo "Name: $name"
        echo "Capital: $capital"
        echo "Population: $population"
        echo "Languages: $languages"
        echo
    else
        echo "Country '$country_name' not found."
    fi
done

exit 0