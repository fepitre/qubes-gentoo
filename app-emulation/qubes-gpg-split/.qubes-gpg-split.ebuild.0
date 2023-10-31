# Maintainer: Frédéric Pierret <frederic.pierret@qubes-os.org>

EAPI=7

PYTHON_COMPAT=( python3_{7..11} )

inherit git-r3 multilib distutils-r1 qubes

if [[ ${PV} == *9999 ]]; then
	EGIT_COMMIT=HEAD
else
	EGIT_COMMIT="v${PV}"
fi

EGIT_REPO_URI="https://github.com/QubesOS/qubes-app-linux-split-gpg.git"

KEYWORDS="amd64"
DESCRIPTION="The Qubes service for secure gpg separation"
HOMEPAGE="http://www.qubes-os.org"
LICENSE="GPL-2"

SLOT="0"
IUSE="pandoc-bin"

DEPEND="app-emulation/qubes-libvchan-xen
        pandoc-bin? (
            app-text/pandoc-bin
        )
        !pandoc-bin? (
            app-text/pandoc
        )
        ${PYTHON_DEPS}
        "
RDEPEND="${DEPEND}"
PDEPEND=""

src_prepare() {
    qubes_verify_sources_git "${EGIT_COMMIT}"
    default
}

src_compile() {
    # Remove related /var/run
    sed -i 's|/etc/tmpfiles\.d/|/usr/lib/tmpfiles.d/|g' Makefile
    sed -i '/^.*\/var\/run\/.*$/d' Makefile
    # Ensure qubes.Gpg service script will use the correct path
    sed -i "s|/usr/lib/qubes-gpg-split|/usr/$(get_libdir)/qubes-gpg-split|" qubes.Gpg.service

    myopt="${myopt} DESTDIR=${D} SYSTEMD=1 BACKEND_VMM=xen LIBDIR=/usr/$(get_libdir)"
	emake ${myopt} build
}

src_install() {
	emake ${myopt} install-vm
}
