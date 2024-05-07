FROM ubuntu:latest as builder

# Install dependencies and tools
RUN apt-get update && apt-get install -y \
    libusb-1.0-0-dev \
    libpng-dev \
    libconfig-dev \
    libfftw3-dev \
    lynx \
    telnet \
    procserv \
    ntp \
    ntpdate \
    cmake \
    make \
    git \
    wget

# Clone rtl-sdr repository
RUN git clone https://github.com/rtlsdrblog/rtl-sdr /opt/rtl-sdr

# Build and install rtl-sdr
RUN mkdir /opt/rtl-sdr/build && \
    cmake -B /opt/rtl-sdr/build -DCMAKE_INSTALL_PREFIX=/usr /opt/rtl-sdr && \
    make -C /opt/rtl-sdr/build && \
    make install -C /opt/rtl-sdr/build

# Download and extract rtlsdr-ogn binary
RUN wget --no-check-certificate http://download.glidernet.org/arm64/rtlsdr-ogn-bin-arm64-latest.tgz -O /opt/rtlsdr-ogn-bin-arm64-latest.tgz && \
    tar -xzf /opt/rtlsdr-ogn-bin-arm64-latest.tgz -C /opt/

# Download EGM data
RUN wget --no-check-certificate https://earth-info.nga.mil/GandG/wgs84/gravitymod/egm96/binary/WW15MGH.DAC -O /opt/rtlsdr-ogn/WW15MGH.DAC

# Create configuration files
RUN echo "#shellbox configuration file\n\
          #Starts commands inside a "box" with a telnet-like server.\n\
          #Contact the shell with: telnet <hostname> <port>\n\
          #Syntax:\n\
          #port  user     directory       command      args\n\
          50000  root /opt/rtlsdr-ogn    ./ogn-rf     /opt/rtlsdr-ogn/ogn-config.json\n\
          50001  root /opt/rtlsdr-ogn    ./ogn-decode /opt/rtlsdr-ogn/ogn-config.json" \
      > /etc/rtlsdr-ogn.conf

# Copy entrypoint script no cache
COPY entrypoint.sh /entrypoint.sh

# Set entrypoint script permissions
RUN chmod +x /entrypoint.sh

# Set entrypoint
ENTRYPOINT ["/entrypoint.sh"]