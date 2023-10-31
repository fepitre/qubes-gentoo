# Maintainer: Frédéric Pierret <frederic.pierret@qubes-os.org>

EAPI=7

PYTHON_COMPAT=( python3_{7..11} )

inherit git-r3 multilib distutils-r1 qubes

if [[ ${PV} == *9999 ]]; then
	EGIT_COMMIT=HEAD
else
	EGIT_COMMIT="v${PV}"
fi

EGIT_REPO_URI="https://github.com/QubesOS/qubes-app-linux-usb-proxy.git"

KEYWORDS="amd64"
DESCRIPTION="USBIP wrapper to run it over Qubes RPC connection"
HOMEPAGE="http://www.qubes-os.org"
LICENSE="GPL-2"

SLOT="0"
IUSE=""

DEPEND="app-emulation/qubes-libvchan-xen
        sys-apps/usbutils
        ${PYTHON_DEPS}
        "
RDEPEND="${DEPEND}"
PDEPEND=""

src_prepare() {
    qubes_verify_sources_git "${EGIT_COMMIT}"
    default
}

src_install() {
    myopt="${myopt} DESTDIR=${D} SYSTEMD=1 BACKEND_VMM=xen LIBDIR=/usr/$(get_libdir)"
	emake ${myopt} install-vm
}