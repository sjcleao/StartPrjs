#!/bin/bash

#  cg.sh
#  
#

prefix="Recife Campaign"
#prefix="CampanhaRecife"
suffix=""
masterkey=talents.jun2017
baseurl=https://coinwise.io/w/

#exemplo: talents.jun2017Recife Campaign0

for a in $(seq 0 4)  ; do

  serial=$(printf "%s%s%d" $masterkey "$prefix" $a )
# serial=$(printf "%s%06d%s" "$prefix" "$a" "$suffix" )
  
# 	echo "serial"
#	echo $serial
  serialhex=$( echo -n $serial | /applications/MyApps/bx base16-encode )

#    serialhex=$(printf "%s%06d%s" "$prefix" "$a" "$suffix" | bx
# base16-encode)

   intermediate=$(echo -n $serialhex | /applications/MyApps/bx sha256 | \
                                        /applications/MyApps/bx sha256 | \
                                        /applications/MyApps/bx base58-encode)
#	echo "Intermediate:"
#	echo $intermediate

    seed=$(echo ${intermediate:0:20})
    url="$baseurl#$seed"

#	echo "Url:"
#	echo $url

    privkey=$(echo -n $seed | /applications/MyApps/bx base16-encode | /applications/MyApps/bx sha256 )
    wif=$(echo -n $privkey  | /applications/MyApps/bx ec-to-wif -u )
    address=$(echo -n $privkey | /applications/MyApps/bx ec-to-public -u | /applications/MyApps/bx ec-to-address )

#    printf "%51s %34s %s\n" "$wif" "$address" "$url"
    printf "%s %s %s\n" "$wif" "$address" "$url"

done

