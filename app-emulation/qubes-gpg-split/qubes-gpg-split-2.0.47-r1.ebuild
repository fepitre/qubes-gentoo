# Maintainer: Frédéric Pierret <frederic.pierret@qubes-os.org>

EAPI=6

inherit git-r3 eutils multilib

MY_PV=${PV/_/-}
MY_P=${PN}-${MY_PV}

KEYWORDS="~amd64"
EGIT_REPO_URI="https://github.com/QubesOS/qubes-app-linux-split-gpg.git"
EGIT_COMMIT="v${PV}"
DESCRIPTION="The Qubes service for secure gpg seperation"
HOMEPAGE="http://www.qubes-os.org"
LICENSE="GPLv2"

SLOT="0"
IUSE=""

DEPEND="app-emulation/qubes-libvchan-xen
        "
# WIP: currently ignore pandoc for time saving
#        app-text/pandoc"
RDEPEND=""
PDEPEND=""

src_prepare() {
    qubes_verify_sources_git "${EGIT_COMMIT}"
    eapply_user
}

src_compile() {
    # WIP: currently disable pandoc
    sed -i 's/pandoc -s -f rst -t man/touch/' doc/Makefile

    # Remove related /var/run
    sed -i 's|/etc/tmpfiles\.d/|/usr/lib/tmpfiles.d/|g' Makefile
	sed -i '/^.*\/var\/run\/.*$/d' Makefile

    myopt="${myopt} DESTDIR=${D} SYSTEMD=1 BACKEND_VMM=xen LIBDIR=/usr/$(get_libdir)"
	emake ${myopt} build
}

src_install() {
	emake ${myopt} install-vm
}