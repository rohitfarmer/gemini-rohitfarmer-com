# My Gemini Website Setup

Website url: [gemini://rohitfarmer.com](gemini://rohitfarmer.com)

## Post Template

```markdown
=> / Home
=> /gemlog Gemlog

# Title

(Subtitle or description)


### Have thoughts, feedback, or questions? Feel free to write to me at:

=> mailto:rohit@rohitfarmer.com rohit@rohitfarmer.com

### Crosspost
This post is also available at:

=> https://rohitfarmer.com/posts/2025/bring-your-bible-back/
```

## Folder Setup

On the GCP instance I created a `gemini` as a new user with it's home directory. 

In the home directory I created a `bin` and `capsule` folder to contain `agate` server binary file and the gemini website content respectively.

Content from the `capsule` folder in this repository gets `rsync`ed to the `/home/gemini/capsule` folder. 

## Server Setup

Before setting up the `agate` Gemini server I had to add a firewall rule in the GCP instance to enable ingress for the port tcp:1965.

In the bin folder besides placing the `agate` latest binary file downloaded from [https://github.com/mbrubeck/agate](https://github.com/mbrubeck/agate) I also placed an `agate.sh` shell script to execute the server for the first time. 

```bash
agate --content /home/gemini/capsule/ \
      --addr [::]:1965 \
      --addr 0.0.0.0:1965 \
      --hostname rohitfarmer.com \
      --lang en-US
```

Upon executing this script from the home directory (not bin directory), for the first time, it created the self-signed certificates automatically and placed them in `.certificate` folder in the `/home/gemini/` folder. This will also run the server and if the port is correctly forwarded and there is an `index.gmi` file in the capsule folder the website should become live and available on a Gemini browser.

To configure `systemd` create a service unit in the systemd folder and place the commands as listed below.

`sudo vim /etc/systemd/system/agate.service`

```bash
[Unit]
Description=Agate Gemini Server
After=network.target

[Service]
Type=simple
User=gemini
Group=gemini
ExecStart=/home/gemini/bin/agate --content /home/gemini/capsule/ --certs /home/gemini/.certificates  --addr [::]:1965 --addr 0.0.0.0:1965 --hostname rohitfarmer.com --lang en-US

[Install]
WantedBy=default.target
```

I then started this service and confirmed it was working.

```bash
sudo systemctl start agate.service

sudo systemctl status agate.service
```

The final step was to have this service start when the system is rebooted.

```bash
sudo systemctl enable agate.service
```

## Upload the Content

To upload the content I wil use `deploy.sh` script which will `rsync` the contents from the capsule folder of this repository to the capsule folder on the instance. 



