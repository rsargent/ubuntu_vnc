USER=$1
HOMEDIR=/home/${USER}
echo Creating $USER using existing $HOMEDIR
HOMEDIR_UID=`stat -c '%u' $HOMEDIR`
useradd \
  --no-create-home \
  --uid ${HOMEDIR_UID} \
  --groups sudo \
  --password `cat ${HOMEDIR}/.secrets/login_passwd_encrypted` \
  --shell /bin/bash \
  ${USER}
rm -rf ${HOMEDIR}/original_dotfiles
cp -a /etc/skel ${HOMEDIR}/original_dotfiles
mkdir -p ${HOMEDIR}/.vnc
cp ${HOMEDIR}/.secrets/vnc_passwd  ${HOMEDIR}/.vnc/passwd
chown -R ${USER}:${USER} ${HOMEDIR}/.vnc
chmod 0600 ${HOMEDIR}/.vnc/passwd
echo "hi"
df
ls -l ${HOMEDIR}
sudo -u rsargent tigervncserver :1 -localhost no -xstartup dbus-run-session -- startxfce4
sleep 9999999

