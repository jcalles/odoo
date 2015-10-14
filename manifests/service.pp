class odoo::service {
	service {"odoo":
	ensure => 'running',
	enable => true,
	require => Class["odoo::config"],
}
}
