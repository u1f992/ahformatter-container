FROM rockylinux/rockylinux:10

ARG AHF_RPM=AHFormatterV75-7.5E-MR7.x86_64.rpm
ARG AHF_LIC=AHFormatter.lic

RUN --mount=type=bind,source=${AHF_RPM},target=/tmp/${AHF_RPM} \
    rpm -i /tmp/${AHF_RPM}

COPY ${AHF_LIC} /usr/AHFormatterV75/etc/AHFormatter.lic

WORKDIR /data

ENTRYPOINT ["/usr/AHFormatterV75/run.sh"]
