class odoo::install {

case $::osfamily {
      	'Debian': { 
	package {'odoo':
	ensure => installed,
	require => Exec["add-source"],
	}
}
	'RedHat': { 
	package {"epel-release":
	ensure => installed,
	}

	yumrepo{"odoo-nightly":
	descr		=> "Odoo Nightly repository",
	baseurl		=> "http://nightly.odoo.com/8.0/nightly/rpm/",
	gpgcheck	=> 1,
	gpgkey		=> "https://nightly.odoo.com/odoo.key",
	enabled		=> 1;
}
	package {'odoo':
	ensure => installed,
	require =>Yumrepo["odoo-nightly"],
	}
}
      	default: { fail("Unrecognized operating system") }
}

}
