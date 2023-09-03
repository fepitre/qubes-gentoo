# Maintainer: Frédéric Pierret <frederic.pierret@qubes-os.org>

EAPI=7

inherit git-r3 multilib qubes

if [[ ${PV} == *9999 ]]; then
	EGIT_COMMIT=HEAD
else
	EGIT_COMMIT="v${PV}"
fi

EGIT_BRANCH="release4.1"
EGIT_REPO_URI="https://github.com/QubesOS/qubes-core-vchan-xen.git"

KEYWORDS="amd64"
DESCRIPTION="QubesOS libvchan cross-domain communication library"
HOMEPAGE="http://www.qubes-os.org"
LICENSE="GPL-2"

SLOT="0"
IUSE=""

DEPEND="app-emulation/xen-tools"
RDEPEND="${DEPEND}"
PDEPEND=""

src_prepare() {
    qubes_verify_sources_git "${EGIT_COMMIT}"
    default
}

src_compile() {
    myopt="${myopt} DESTDIR=${D} SYSTEMD=1 BACKEND_VMM=xen LIBDIR=/usr/$(get_libdir)"
    emake ${myopt} all
}

src_install() {
    emake ${myopt} install
}
