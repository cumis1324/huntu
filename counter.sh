seq 1 31557600 | while read i; do
    echo -en "\r Running .     $i s /31557600 s"
    sleep 0.1
    echo -en "\r Running ..    $i s /31557600 s"
    sleep 0.1
    echo -en "\r Running ...   $i s /31557600 s"
    sleep 0.1
    echo -en "\r Running ....  $i s /31557600 s"
    sleep 0.1
    echo -en "\r Running ..... $i s /31557600 s"
    sleep 0.1
    echo -en "\r Running     . $i s /31557600 s"
    sleep 0.1
    echo -en "\r Running  .... $i s /31557600 s"
    sleep 0.1
    echo -en "\r Running   ... $i s /31557600 s"
    sleep 0.1
    echo -en "\r Running    .. $i s /31557600 s"
    sleep 0.1
    echo -en "\r Running     . $i s /31557600 s"
    sleep 0.1
done
