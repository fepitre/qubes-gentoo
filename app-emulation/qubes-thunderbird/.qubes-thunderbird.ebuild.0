# Maintainer: Frédéric Pierret <frederic.pierret@qubes-os.org>

EAPI=7

PYTHON_COMPAT=( python3_{7..11} )

inherit git-r3 multilib distutils-r1 qubes

if [[ ${PV} == *9999 ]]; then
	EGIT_COMMIT=HEAD
else
	EGIT_COMMIT="v${PV}"
fi

EGIT_REPO_URI="https://github.com/QubesOS/qubes-app-thunderbird.git"

KEYWORDS="amd64"
DESCRIPTION="The Qubes extension for Thunderbird"
HOMEPAGE="http://www.qubes-os.org"
LICENSE="GPL-2"

SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="mail-client/thunderbird"
PDEPEND=""

src_prepare() {
    qubes_verify_sources_git "${EGIT_COMMIT}"
    default
}

src_compile() {
    myopt="${myopt} DESTDIR=${D} SYSTEMD=1 BACKEND_VMM=xen LIBDIR=/usr/$(get_libdir) EXTDIR=/usr/$(get_libdir)/mozilla/extensions/{3550f703-e582-4d05-9a08-453d09bdfdc6}/qubes-attachment@qubes-os.org"
	emake ${myopt} manifest.json
}

src_install() {
	emake ${myopt} install-vm
}