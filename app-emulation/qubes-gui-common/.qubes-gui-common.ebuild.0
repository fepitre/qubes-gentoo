# Maintainer: Frédéric Pierret <frederic.pierret@qubes-os.org>

EAPI=7

inherit git-r3 multilib qubes

if [[ ${PV} == *9999 ]]; then
	EGIT_COMMIT=HEAD
else
	EGIT_COMMIT="v${PV}"
fi

EGIT_BRANCH="release4.1"
EGIT_REPO_URI="https://github.com/QubesOS/qubes-gui-common.git"

KEYWORDS="amd64"
DESCRIPTION="Common files for Qubes GUI - protocol headers"
HOMEPAGE="http://www.qubes-os.org"
LICENSE="GPL-2"

SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""
PDEPEND=""

src_prepare() {
    qubes_verify_sources_git "${EGIT_COMMIT}"
    default
}

src_install() {
    insinto 'usr/include'
    doins 'include/qubes-gui-protocol.h'
    doins 'include/qubes-xorg-tray-defs.h'
}
