# Class: cactos_os_proxy
# ===========================
#
# Apache proxy to redirect some tenant OpenStack API requests to CACTOS
#
# Parameters
# ----------
#
# * `tenant_id`
# Redirect API requests for this tenant
#
# * `target_host`
# host:port of redirect target
#
# * `os_port`
# Port the actual OS API is listening on
#
# Examples
# --------
#
# @example
#    class { 'cactos_os_proxy':
#      tenant_id = 'b330159537df45c484986fb1ca4a88a4'
#      target_host = '134.60.64.160:9090'
#      os_port = '18774'
#    }
#
# Authors
# -------
#
# Simon Volpert <simon.volpert@uni-ulm.de>
#
class cactos_os_proxy (

  String $tenant_id   = $cactos_os_proxy::params::tenant_id ,
  String $target_host = $cactos_os_proxy::params::target_host,
  String $os_port     = $cactos_os_proxy::params::os_port,

) inherits cactos_os_proxy::params {


  file {'apache_conf':
    ensure => file,
    path => '/etc/httpd/conf.d/15-default.conf',
    owner  => root,
    group  => root,
    mode   => '0644',
    content => epp('cactos_os_proxy/15-default.conf'),
  }
  exec { "disable selinux on $hostname":
    user    => "root",
    command => "/usr/sbin/setenforce 0",
  }->
  class { 'apache':
    default_vhost => false,
    user => 'apache',
    group => 'apache',
  }

}
