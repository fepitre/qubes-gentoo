# Maintainer: Frédéric Pierret <frederic.pierret@qubes-os.org>

EAPI=6

inherit git-r3 eutils multilib qubes

MY_PV=${PV/_/-}
MY_P=${PN}-${MY_PV}

KEYWORDS="amd64"
EGIT_REPO_URI="https://github.com/QubesOS/qubes-app-linux-split-gpg.git"
EGIT_COMMIT="v${PV}"
DESCRIPTION="The Qubes service for secure gpg seperation"
HOMEPAGE="http://www.qubes-os.org"
LICENSE="GPLv2"

SLOT="0"
IUSE=""

DEPEND="app-emulation/qubes-libvchan-xen
        app-text/pandoc
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

    myopt="${myopt} DESTDIR=${D} SYSTEMD=1 BACKEND_VMM=xen LIBDIR=/usr/$(get_libdir)"
	emake ${myopt} build
}

src_install() {
	emake ${myopt} install-vm
}