FROM centos

RUN yum install -y openssh-server passwd

RUN useradd remote_user && \
  echo "1234" | passwd remote_user --stdin && \
  mkdir /home/remote_user/.ssh && \
  chmod 700 /home/remote_user/.ssh

COPY remote-key.pub /home/remote_user/.ssh/authorized_keys

RUN chown remote_user:remote_user -R /home/remote_user/ && \
 chmod 600 /home/remote_user/.ssh/authorized_keys

RUN /usr/bin/ssh-keygen -A

EXPOSE 22

RUN rm -rf /run/nologin && \
  yum -y install mysql python38 && \
  curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py" && \
  python3 get-pip.py && \
  pip install awscli

CMD /usr/sbin/sshd -D

