# Maintainer: Frédéric Pierret <frederic.pierret@qubes-os.org>

# Workaround for verifying git tags
# Feature request: https://bugs.gentoo.org/733430
qubes_verify_sources_git() {
    QUBES_OVERLAY_DIR="$(portageq get_repo_path / qubes)"
    # Import Qubes developers keys
    gpg --import "${QUBES_OVERLAY_DIR}/keys/qubes-developers-keys.asc" 2>/dev/null
    # Trust Qubes Master Signing Key
    echo '427F11FD0FAA4B080123F01CDDFA1A3E36879494:6:' | gpg --import-ownertrust

    VALID_TAG_FOUND=0
    for tag in $(git tag --points-at="$1"); do
        if git verify-tag --raw "$tag" 2>&1 | grep -q '^\[GNUPG:\] TRUST_\(FULLY\|ULTIMATE\)'; then
            VALID_TAG_FOUND=1
        fi
    done

    if [ "$VALID_TAG_FOUND" -eq 0 ]; then
        die 'Signature verification failed!'
    fi
}