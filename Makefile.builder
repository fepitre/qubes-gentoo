# qubes-builder integration

GENTOO_OVERLAY := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

NAME_core_vchan_xen = qubes-libvchan-xen
NAME_core_qubesdb = qubes-db
NAME_core_qrexec = qubes-core-qrexec
NAME_core_agent_linux = qubes-core-agent-linux
NAME_linux_utils = qubes-utils
NAME_gui_common = qubes-gui-common
NAME_gui_agent_linux = qubes-gui-agent
NAME_app_linux_split_gpg = qubes-gpg-split
NAME_app_linux_usb_proxy = qubes-usb-proxy
NAME_app_linux_input_proxy = qubes-input-proxy
NAME_app_linux_img_converter = qubes-img-converter
NAME_app_linux_pdf_converter = qubes-pdf-converter
NAME_app_thunderbird = qubes-thunderbird
