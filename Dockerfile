FROM gxm1015/slurm-base:v22.05.3

LABEL maintainer="gxm.web@gmail.com"

# Install slurm, slurmd, slurm-perlapi, slurm-pam_slurm
RUN rpm -ivh ${ROOT_RPMS}/slurm-${SLURM_VERSION}-1.el7.x86_64.rpm \
  ${ROOT_RPMS}/slurm-slurmd-${SLURM_VERSION}-1.el7.x86_64.rpm \
  ${ROOT_RPMS}/slurm-perlapi-${SLURM_VERSION}-1.el7.x86_64.rpm \
  ${ROOT_RPMS}/slurm-pam_slurm-${SLURM_VERSION}-1.el7.x86_64.rpm && \
  rm -rf ${ROOT_RPMS}/*

# Fixed ownership and permission of Slurm
RUN mkdir -p /var/spool/slurm/slurmd /var/run/slurm /var/log/slurm /var/spool/slurmctld && \
  chown slurm: /var/spool/slurm/slurmd  /var/run/slurm /var/log/slurm /var/spool/slurmctld && \
  chmod 755 /var/spool/slurm/slurmd /var/run/slurm /var/log/slurm && \
  touch /var/log/slurm/slurmd.log && \
  chown slurm: /var/log/slurm/slurmd.log && \
  systemctl enable slurmd

VOLUME [ "/sys/fs/cgroup", "/etc/slurm" ]

EXPOSE 6818 60001-63000