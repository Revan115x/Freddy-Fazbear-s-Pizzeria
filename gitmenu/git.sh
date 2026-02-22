#!/bin/bash
while true; do

echo "*****************"
echo "MENU GITHUB 1.0v"
echo "*****************"
echo "Rama actual: $(git branch --show-current)"
echo "1. PUSH"
echo "2. PULL"
echo "3. RAMAS GENERALES"
echo "4. MOVERTE DE RAMA"
echo "5. HISTORIAL COMMITS"
echo "6. TRAER CAMBIOS DE MAIN"
echo "7. FUSIONAR A MAIN (SOLO ADMIN)"
echo "8. CREAR NUEVA RAMA (SOLO ADMIN)"
echo "0. SALIR"

read num

case $num in 

    1 )
        echo "SUBIENDO A GITHUB..."
        git add .
        echo "Descripcion del commit:"
        read commit
        git commit -m "$commit"
        git push -u origin $(git branch --show-current)
        ;;

    2 )
        echo "ACTUALIZANDO REPOSITORIO..."
        git pull
        ;;

    3 )
        echo "RAMAS EXISTENTES:"
        git fetch --all
        git branch -a
        ;;

    4 )
        echo "NOMBRE RAMA:"
        read rama
        git checkout "$rama"
        ;;

    5 )
        git log --oneline
        ;;

    6 )
        echo "TRAER CAMBIOS DE MAIN A TU RAMA ACTUAL..."
        git fetch origin
        git merge origin/main || echo "No hay cambios nuevos para fusionar"
        echo "Cambios de main aplicados a $(git branch --show-current)"
        git push
        ;;

    7 )
        if [ "$(git branch --show-current)" = "main" ]; then
            echo "¿Qué rama quieres fusionar a main?"
            read rama
            git merge "$rama"
            git push
            echo "Fusión completada."
        else
            echo "TIENES QUE ESTAR EN LA RAMA MAIN PARA FUSIONAR"
        fi
        ;;

    8 )
        echo "NOMBRE DE LA NUEVA RAMA:"
        read nombre
        git checkout -b "$nombre"
        ;;

    0 ) 
        break
        ;;

    * )
        echo "NO EXISTE"
        ;;

esac

done