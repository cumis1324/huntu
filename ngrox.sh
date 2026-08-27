wget -O ng.sh https://github.com/kmille36/Docker-Ubuntu-Desktop-NoMachine/raw/main/ngrok.sh > /dev/null 2>&1
chmod +x ng.sh
./ng.sh

function goto
{
    label=$1
    cd 
    cmd=$(sed -n "/^:[[:blank:]][[:blank:]]*${label}/{:a;n;p;ba};" $0 | 
          grep -v ':$')
    eval "$cmd"
    exit
}

: ngrok
clear
echo "Go to: https://dashboard.ngrok.com/get-started/your-authtoken"
read -p "Paste Ngrok Authtoken: " CRP
./ngrok authtoken $CRP 

clear
echo "======================="
echo "Choose ngrok region (for better connection):"
echo "======================="
echo "us - United States (Ohio)"
echo "eu - Europe (Frankfurt)"
echo "ap - Asia/Pacific (Singapore)"
echo "au - Australia (Sydney)"
echo "sa - South America (Sao Paulo)"
echo "jp - Japan (Tokyo)"
echo "in - India (Mumbai)"
read -p "Choose ngrok region: " CRP

# Forward port 6080 via HTTP (noVNC web port)
./ngrok http --region $CRP 6080 &>/dev/null &
sleep 2

if curl --silent --show-error http://127.0.0.1:4040/api/tunnels > /dev/null 2>&1; then 
    echo OK
else 
    echo "Ngrok Error! Please try again!" && sleep 1 && goto ngrok
fi

# Jalankan container Ubuntu noVNC
docker run --rm -d --network host --privileged --name novnc-desktop \
    -e USER=user \
    -e PASSWORD=123456 \
    -e HTTP_PASSWORD=123456 \
    --cap-add=SYS_PTRACE \
    --shm-size=1g \
    fredblitem/vnc-desktop-lxde

clear
echo "=========================================="
echo "noVNC Desktop siap diakses via Browser!"
echo "=========================================="
echo -n "Akses Web URL: "
curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"(https:\/\/[^"]*)".*/\1/p'
echo ""
echo "User     : user"
echo "Password : 123456"
echo "=========================================="
echo "Tekan Ctrl+C untuk berhenti."

# Loop keep-alive
while true; do
    sleep 60
done
