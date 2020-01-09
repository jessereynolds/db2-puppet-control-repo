# WebSphere appserver profile
class profile::websphere_appserver {
  class { 'websphere_application_server':
    user     => 'webadmin',
    group    => 'webadmins',
    base_dir => '/opt/ibm',
  }
}
