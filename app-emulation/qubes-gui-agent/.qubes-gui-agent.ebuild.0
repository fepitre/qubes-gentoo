# Maintainer: Frédéric Pierret <frederic.pierret@qubes-os.org>

EAPI=7

PYTHON_COMPAT=( python3_{7..11} )

inherit git-r3 multilib distutils-r1 qubes

if [[ ${PV} == *9999 ]]; then
	EGIT_COMMIT=HEAD
else
	EGIT_COMMIT="v${PV}"
fi

EGIT_BRANCH="release4.1"
EGIT_REPO_URI="https://github.com/QubesOS/qubes-gui-agent-linux.git"

KEYWORDS="amd64"
DESCRIPTION="The Qubes GUI Agent for AppVMs"
HOMEPAGE="http://www.qubes-os.org"
LICENSE="GPL-2"

SLOT="0"
IUSE="xfce"

DEPEND="app-emulation/qubes-libvchan-xen
        app-emulation/qubes-db
        app-emulation/qubes-gui-common
        x11-apps/xprop
        x11-apps/xsetroot
        x11-apps/xrandr
        x11-apps/setxkbmap
        x11-base/xorg-server:=
        x11-libs/libXdamage
        x11-apps/xinit
        x11-libs/libXcomposite
        dev-python/xcffib[${PYTHON_USEDEP}]
        dev-python/pygobject[${PYTHON_USEDEP}]
        dev-python/pyxdg[${PYTHON_USEDEP}]
        media-libs/alsa-lib
        media-sound/alsa-utils
        media-sound/pulseaudio
        ${PYTHON_DEPS}
        "
RDEPEND="${DEPEND}"
PDEPEND=""

src_prepare() {
    qubes_verify_sources_git "${EGIT_COMMIT}"
    default
}

src_compile() {
    # Fix PAM
    sed -i 's/postlogin/system-auth/g' appvm-scripts/etc/pam.d/qubes-gui-agent

    pa_ver=$((pkg-config --modversion libpulse 2>/dev/null || echo 0.0) | cut -f 1 -d "-")

    rm -f pulse/pulsecore
    ln -s "pulsecore-$pa_ver" pulse/pulsecore

    # Bug fixes : /var/run/console depends on pam_console, which is Fedora specific
    # As a consequece, /var/run/console does not exists and qubes-gui-agent will always fail
    sed 's:ExecStartPre=/bin/touch:#ExecStartPre=/bin/touch:' -i appvm-scripts/qubes-gui-agent.service
    # Ensure that qubes-gui-agent starts after user autologin
    sed 's/After=\(.*\)qubes-misc-post.service/After=\1qubes-misc-post.service getty.target/' -i appvm-scripts/qubes-gui-agent.service

    myopt="${myopt} DESTDIR="${D}" SYSTEMD=1 BACKEND_VMM=xen LIBDIR=/usr/$(get_libdir)"
    emake ${myopt} appvm
}

src_install() {
    emake ${myopt} install

    insopts -m 0755
    insinto /etc/X11/Sessions/
    doins "${FILESDIR}/Qubes"

    insopts -m 0664
    insinto /etc/env.d/
    doins "${FILESDIR}/90xsession"
}

pkg_postinst() {
    # With pulseaudio 15.0, the module directory was changed to
    # /usr/$(get_libdir)/${PN}/modules
    pa_ver=$((pkg-config --modversion libpulse 2>/dev/null || echo 0.0) | cut -f 1 -d "-")
    pa_ver_short=$(echo "${pa_ver}" | cut -f 1 -d".")
    if [[ "${pa_ver_short}" -ge 15 ]]; then
        mv /usr/$(get_libdir)/pulse-${pa_ver}/modules/module-vchan-sink.so /usr/$(get_libdir)/pulseaudio/modules
        rmdir /usr/$(get_libdir)/pulse-${pa_ver}/modules
        rmdir /usr/$(get_libdir)/pulse-${pa_ver}
    fi

    systemctl enable qubes-gui-agent.service

    # Remove useless file from install-rh-agent
    rm -f /etc/sysconfig/desktop

    # Only for XFCE desktop flavor
    if ! use xfce; then
        rm -f /etc/X11/xinit/xinitrc.d/60xfce-desktop.sh
    fi

    sed -i '/^autospawn/d' /etc/pulse/client.conf
    echo autospawn=no >> /etc/pulse/client.conf

    # We added 90xsession providing XSESSION variable
    # in env.d so an update is required
    env-update
}

pkg_prerm() {
    systemctl disable qubes-gui-agent.service
}
