# Maintainer: Frédéric Pierret <frederic.pierret@qubes-os.org>

EAPI=7

PYTHON_COMPAT=( python3_{7..11} )

inherit git-r3 multilib distutils-r1 qubes

if [[ ${PV} == *9999 ]]; then
	EGIT_COMMIT=HEAD
else
	EGIT_COMMIT="v${PV}"
fi

EGIT_REPO_URI="https://github.com/QubesOS/qubes-app-shutdown-idle.git"

KEYWORDS="amd64"
DESCRIPTION="Qubes shutdown idle VM script"
HOMEPAGE="http://www.qubes-os.org"
LICENSE="GPL-2+"

SLOT="0"

DEPEND="dev-python/pyudev[${PYTHON_USEDEP}]  
        ${PYTHON_DEPS}
        "
RDEPEND="${DEPEND}"
PDEPEND=""

src_prepare() {
    qubes_verify_sources_git "${EGIT_COMMIT}"
    default
}

src_compile() {
    myopt="${myopt} DESTDIR=${D}"
	emake ${myopt} build
}

src_install() {
	emake ${myopt} install
}
