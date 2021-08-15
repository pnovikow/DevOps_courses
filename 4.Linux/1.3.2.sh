#!/bin/bash
curl -s --cookie cookies.txt --cookie-jar cookies.txt --data "login_credentials[login]=xxx&login_credentials[password]=xxx&submit=commit" passport.yandex.by/auth
curl -s --cookie cookies.txt --user-agent Mozilla/4.0 https://mail.yandex.by/| grep -o "inbox\"
