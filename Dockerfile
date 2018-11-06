FROM sinonkt/docker-slurmbase

LABEL maintainer="oatkrittin@gmail.com"

# Install slurm, slurmd, slurm-perlapi, slurm-pam_slurm
RUN rpm -ivh ${ROOT_RPMS}/slurm-${SLURM_VERSION}-1.el7.x86_64.rpm \
  ${ROOT_RPMS}/slurm-slurmd-${SLURM_VERSION}-1.el7.x86_64.rpm \
  ${ROOT_RPMS}/slurm-perlapi-${SLURM_VERSION}-1.el7.x86_64.rpm \
  ${ROOT_RPMS}/slurm-pam_slurm-${SLURM_VERSION}-1.el7.x86_64.rpm && \
  rm -rf ${ROOT_RPMS}/*

# Fixed ownership and permission of Slurm
RUN mkdir -p /var/spool/slurm/slurmd /var/log/slurm && \
  chown slurm: /var/spool/slurm/slurmd  /var/log/slurm && \
  chmod 755 /var/spool/slurm/slurmd  /var/log/slurm && \
  touch /var/log/slurm/slurmd.log && \
  chown slurm: /var/log/slurm/slurmd.log && \
  systemctl enable slurmd

VOLUME [ "/sys/fs/cgroup", "/etc/slurm" ]

EXPOSE 6818 60001-63000