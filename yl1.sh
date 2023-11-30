#!bin/bash

if [ "$EUID -ne 0 ]; then
	echo "Pead programmi kasutama rootina."
	exit 1
fi
if [ "$#" -ne 1 ]; then
	echo "Peate sisestama argumendina kasutajanime. Kasuta: $0 <kasutajanimi>"
	exit 1
fi

kasutajanimi=$1

if id "$kasutajanimi" &>/dev/null; then
	echo "Kasutaja nimega $kasutajanimi juba eksisteerib"
	exit 1
fi

useradd -m "$kasutajanimi"

if [ $? -eq 0 ]; then
	echo "Kasutaja $kasutajanimi on loodud."
else
	echo "Ei saanud luua kasutajat $kasutajanimi."
	exit 1
fi

echo "Kasutaja info:"
echo "Kasutajanimi: $kasutajanimi "
echo "Kodukaust: /home/$kasutajanimi "
echo "Kasutaja ID: " $(id -u $kasutajanimi)
echo "Grupi ID: " $(id -g $kasutajanimi)
