EXTRA_DIST += \
	debian/changelog \
	debian/compat \
	debian/control \
	debian/control.modules.in \
	debian/copyright \
	debian/copyright.in \
	debian/dkms.conf.in \
	debian/dirs \
	debian/libmlnx-openvswitch.install \
	debian/libmlnx-openvswitch-dev.install \
	debian/mlnx-openvswitch-common.dirs \
	debian/mlnx-openvswitch-common.docs \
	debian/mlnx-openvswitch-common.install \
	debian/mlnx-openvswitch-common.manpages \
	debian/mlnx-openvswitch-datapath-module-_KVERS_.postinst.modules.in \
	debian/mlnx-openvswitch-datapath-dkms.postinst \
	debian/mlnx-openvswitch-datapath-dkms.prerm \
	debian/mlnx-openvswitch-datapath-source.README.Debian \
	debian/mlnx-openvswitch-datapath-source.copyright \
	debian/mlnx-openvswitch-datapath-source.dirs \
	debian/mlnx-openvswitch-datapath-source.install \
	debian/mlnx-openvswitch-ipsec.dirs \
	debian/mlnx-openvswitch-ipsec.init \
	debian/mlnx-openvswitch-ipsec.install \
	debian/mlnx-openvswitch-pki.dirs \
	debian/mlnx-openvswitch-pki.postinst \
	debian/mlnx-openvswitch-pki.postrm \
	debian/mlnx-openvswitch-switch.README.Debian \
	debian/mlnx-openvswitch-switch.dirs \
	debian/mlnx-openvswitch-switch.init \
	debian/mlnx-openvswitch-switch.install \
	debian/mlnx-openvswitch-switch.logrotate \
	debian/mlnx-openvswitch-switch.manpages \
	debian/mlnx-openvswitch-switch.postinst \
	debian/mlnx-openvswitch-switch.postrm \
	debian/mlnx-openvswitch-switch.template \
	debian/mlnx-openvswitch-switch.links \
	debian/mlnx-openvswitch-test.dirs \
	debian/mlnx-openvswitch-test.install \
	debian/mlnx-openvswitch-test.manpages \
	debian/mlnx-openvswitch-testcontroller.README.Debian \
	debian/mlnx-openvswitch-testcontroller.default \
	debian/mlnx-openvswitch-testcontroller.dirs \
	debian/mlnx-openvswitch-testcontroller.init \
	debian/mlnx-openvswitch-testcontroller.install \
	debian/mlnx-openvswitch-testcontroller.manpages \
	debian/mlnx-openvswitch-testcontroller.postinst \
	debian/mlnx-openvswitch-testcontroller.postrm \
	debian/mlnx-openvswitch-vtep.default \
	debian/mlnx-openvswitch-vtep.dirs \
	debian/mlnx-openvswitch-vtep.init \
	debian/mlnx-openvswitch-vtep.install \
	debian/mlnx-openvswitch-vtep.manpages \
	debian/python3-mlnx-openvswitch.dirs \
	debian/python3-mlnx-openvswitch.install \
	debian/rules \
	debian/rules.modules \
	debian/ifupdown.sh \
	debian/source/format

check-debian-changelog-version:
	@DEB_VERSION=`echo '$(VERSION)' | sed 's/pre/~pre/'`;		     \
	if $(FGREP) '($(DEB_VERSION)' $(srcdir)/debian/changelog >/dev/null; \
	then								     \
	  :;								     \
	else								     \
	  echo "Update debian/changelog to mention version $(VERSION)";	     \
	  exit 1;							     \
	fi
ALL_LOCAL += check-debian-changelog-version
DIST_HOOKS += check-debian-changelog-version

$(srcdir)/debian/copyright: AUTHORS.rst debian/copyright.in
	$(AM_V_GEN) \
	{ sed -n -e '/%AUTHORS%/q' -e p < $(srcdir)/debian/copyright.in;   \
	  sed '34,/^$$/d' $(srcdir)/AUTHORS.rst |			   \
		sed -n -e '/^$$/q' -e 's/^/  /p';			   \
	  sed -e '34,/%AUTHORS%/d' $(srcdir)/debian/copyright.in;	   \
	} > $@

CLEANFILES += debian/copyright
