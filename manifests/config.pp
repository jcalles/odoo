class odoo::config {

$version='8.0'
$path='/bin:/sbin:/usr/bin:/usr/sbin'
case $::osfamily {
	'Debian': {
if ! defined(Package["wget"])
{
	package {"wget": ensure => installed,}
}
	exec {"get-key":
	path	=> "${path}",
	command => "wget -O - https://nightly.odoo.com/odoo.key | apt-key add -",
	#unless => "apt-key adv --list-public-keys --with-fingerprint --with-colons|grep odoo",
	require => Package["wget"],
	}

	exec {"add-source":
	path	=> "${path}",
	command	=> "echo \"deb http://nightly.odoo.com/${version}/nightly/deb/ ./\" >> /etc/apt/sources.list",
	unless	=> "cat /etc/apt/sources.list|grep odoo",
	require => Exec["get-key"],
	}

	exec {"update-apt":
	path	=> "${path}",
	command => "apt-get update",
	onlyif	=> "cat /etc/apt/sources.list|grep odoo",
	require => Exec["add-source"],
	}

 	package {'odoo':
        ensure	=> installed,
        require => Exec["add-source"],
        }

	exec {"create-rol":
	path	=> "${path}",
	command	=> "sudo su - postgres -c \"createuser -s odoo\"",
	unless	=> "test $(sudo  -i -u postgres psql postgres -tAc \"SELECT * FROM pg_roles WHERE rolname='odoo'\"|cut -f1 -d'|') = 'odoo'",
	require => Class["postgresql::server"],
}
}
	'RedHat': {
        package {"epel-release":
        ensure => installed,
        }
        yumrepo {"odoo-nightly":
        descr	=> "Odoo Nightly repository",
        baseurl	=> "http://nightly.odoo.com/${version}/nightly/rpm/",
	gpgcheck => 1,
        gpgkey	=> "https://nightly.odoo.com/odoo.key",
        enabled	=> 1,
	require => Package['epel-release'],
	}
        package {'odoo':
        ensure => installed,
        require =>Yumrepo["odoo-nightly"],
        }

	exec {"create-rol":
	path => "${path}",
	command => "sudo su - postgres -c \"createuser -s odoo\"",
	unless => "test $(sudo  -i -u postgres psql postgres -tAc \"SELECT * FROM pg_roles WHERE rolname='odoo'\"|cut -f1 -d'|') = 'odoo'",
	require => Class["postgresql::server"],
	}	

	exec {"firewall":
	path => "${path}",
	command => "firewall-cmd --zone=public --add-port=8069/tcp; firewall-cmd --zone=public --add-port=8069/tcp --permanent",
	require => Package["odoo"],
}

}
	 default: { fail("Unrecognized operating system") }
}
}
