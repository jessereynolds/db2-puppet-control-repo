# db2_server preofile
class profile::db2_server (
) {
  package { ['sg3_utils', 'gcc-c++', 'libaio', 'compat-libstdc++-33']:
    ensure => present,
  }
  exec { '/bin/mkdir -p /var/puppet_db2 && /bin/ln -s /var/puppet_db2/server_dec /var/puppet_db2/universal':
    unless => '/bin/ls /var/puppet_db2/universal',
  }
  include db2
  db2::install { '11.1':
    source     => 'file:///media/db2/v11.1_linuxx64_dec.tar.gz',
    components => [
      'ACS',
      'APPLICATION_DEVELOPMENT_TOOLS',
      'DB2_SAMPLE_DATABASE   ',
      'BASE_CLIENT',
      'BASE_DB2_ENGINE',
      'JAVA_SUPPORT',
      'SQL_PROCEDURES',
      'COMMUNICATION_SUPPORT_TCPIP'
    ],
    license_content => template('db2/license/trial.lic'),
  }
}
