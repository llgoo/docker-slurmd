FROM sinonkt/docker-slurmbase

LABEL maintainer="oatkrittin@gmail.com"

# Install slurm, slurmd, slurm-perlapi, slurm-pam_slurm
RUN rpm -ivh ${ROOT_RPMS}/slurm-${SLURM_VERSION}.el7.x86_64.rpm \
  ${ROOT_RPMS}/slurm-slurmd-${SLURM_VERSION}.el7.x86_64.rpm \
  ${ROOT_RPMS}/slurm-perlapi-${SLURM_VERSION}.el7.x86_64.rpm \
  ${ROOT_RPMS}/slurm-pam_slurm-${SLURM_VERSION}.el7.x86_64.rpm && \
  rm -rf ${ROOT_RPMS}/*

# Fixed ownership and permission of Slurm
RUN mkdir /var/spool/slurmd /var/log/slurm && \
  chown slurm: /var/spool/slurmd  /var/log/slurm && \
  chmod 755 /var/spool/slurmd  /var/log/slurm && \
  touch /var/log/slurm/slurmd.log && \
  chown slurm: /var/log/slurm/slurmd.log

ADD etc/supervisord.d/slurmd.ini /etc/supervisord.d/slurmd.ini

VOLUME [ "/sys/fs/cgroup", "/etc/slurm" ]

EXPOSE 6818 60001-63000