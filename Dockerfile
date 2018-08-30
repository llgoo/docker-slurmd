FROM sinonkt/docker-slurmbase

LABEL maintainer="oatkrittin@gmail.com"

# Install slurm, slurmd, slurm-perlapi, slurm-pam_slurm
RUN rpm -ivh ${ROOT_RPMS}/slurm-${SLURM_VERSION}.el7.x86_64.rpm \
  ${ROOT_RPMS}/slurm-slurmd-${SLURM_VERSION}.el7.x86_64.rpm \
  ${ROOT_RPMS}/slurm-perlapi-${SLURM_VERSION}.el7.x86_64.rpm \
  ${ROOT_RPMS}/slurm-pam_slurm-${SLURM_VERSION}.el7.x86_64.rpm && \
  rm -rf ${ROOT_RPMS}/*

ADD scripts/start.sh /root/start.sh
RUN chmod +x /root/start.sh

ADD etc/supervisord.d/slurmd.conf /etc/supervisor/conf.d/slurmd.conf

CMD ["/bin/bash","/root/start.sh"]
