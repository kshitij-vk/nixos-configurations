FROM archlinux:latest

# Install reflector first to update mirrors
RUN pacman -Sy --noconfirm reflector && \
    reflector --latest 10 --protocol https --sort rate --save /etc/pacman.d/mirrorlist

# Enable multilib repo
RUN sed -i '/\[multilib\]/,/Include/s/^#//' /etc/pacman.conf && \
    pacman -Sy

# Now update system & install packages
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm base-devel git sudo

# Create non-root user for yay
RUN useradd -m -G wheel -s /bin/bash builder && \
    echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

USER builder
WORKDIR /home/builder

# Install yay
RUN git clone https://aur.archlinux.org/yay.git && \
    cd yay && \
    makepkg -si --noconfirm

USER root
RUN rm -rf /home/builder/yay && \
    pacman -Scc --noconfirm

CMD ["/bin/bash"]
